# Allows to set project version
cmake_policy(SET CMP0048 NEW)
PROJECT(cfitsio VERSION 3.39)
CMAKE_MINIMUM_REQUIRED(VERSION 2.8.0)

# Allow the developer to select if Dynamic or Static libraries are built
OPTION (USE_PTHREADS "Thread-safe build (using pthreads)" OFF)

SET(LIBRARY_NAME cfitsio)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}")
set (CMAKE_LIBDIR "${CMAKE_INSTALL_PREFIX}/lib${LIB_SUFFIX}")
set (CMAKE_INCLUDEDIR "${CMAKE_INSTALL_PREFIX}/include/${LIBRARY_NAME}")

# Define project version
SET(${PROJECT_NAME}_MAJOR_VERSION 3)
SET(${PROJECT_NAME}_MINOR_VERSION 39)
SET(${PROJECT_NAME}_VERSION ${${PROJECT_NAME}_MAJOR_VERSION}.${${PROJECT_NAME}_MINOR_VERSION})

# Microsoft Visual Studio:
IF(MSVC OR BORLAND)
    # Define
    ADD_DEFINITIONS(-D_CRT_SECURE_NO_DEPRECATE)
    # Need an empty unistd.h in MSVC for flex-generated eval_l.c:
    FILE(WRITE ${CMAKE_SOURCE_DIR}/unistd.h "")
    INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR})
ENDIF()

IF(BORLAND)
    # Suppress spurious Borland compiler warnings about "Suspicious
    # pointer arithmetic", "Possibly incorrect assignment", and
    # "Comparing signed and unsigned values".
    ADD_DEFINITIONS(-w-spa)
    ADD_DEFINITIONS(-w-pia)
    ADD_DEFINITIONS(-w-csu)
ENDIF()

#add_subdirectory (src)

SET (LIBRARY_TYPE SHARED)
IF (CMAKE_LIBRARY_TYPE)
  SET (LIBRARY_TYPE ${CMAKE_LIBRARY_TYPE})
ENDIF (CMAKE_LIBRARY_TYPE)

FILE(GLOB H_FILES "*.h")

IF (USE_PTHREADS)
    FIND_PACKAGE(pthreads REQUIRED)
    INCLUDE_DIRECTORIES(${PTHREADS_INCLUDE_DIR})
    ADD_DEFINITIONS(-D_REENTRANT)
ENDIF()

# Math library (not available in MSVC)
IF (NOT MSVC)
    FIND_LIBRARY(M_LIB m)
ELSE()
    SET(M_LIB "")
ENDIF()

SET(SRC_FILES
    buffers.c cfileio.c checksum.c drvrfile.c drvrmem.c
    drvrnet.c drvrsmem.c drvrgsiftp.c editcol.c edithdu.c eval_l.c
    eval_y.c eval_f.c fitscore.c getcol.c getcolb.c getcold.c getcole.c
    getcoli.c getcolj.c getcolk.c getcoll.c getcols.c getcolsb.c
    getcoluk.c getcolui.c getcoluj.c getkey.c group.c grparser.c
    histo.c iraffits.c
    modkey.c putcol.c putcolb.c putcold.c putcole.c putcoli.c
    putcolj.c putcolk.c putcoluk.c putcoll.c putcols.c putcolsb.c
    putcolu.c putcolui.c putcoluj.c putkey.c region.c scalnull.c
    swapproc.c wcssub.c wcsutil.c imcompress.c quantize.c ricecomp.c
    pliocomp.c fits_hcompress.c fits_hdecompress.c zlib/zuncompress.c
    zlib/zcompress.c zlib/adler32.c zlib/crc32.c zlib/inffast.c
    zlib/inftrees.c zlib/trees.c zlib/zutil.c zlib/deflate.c
    zlib/infback.c zlib/inflate.c zlib/uncompr.c simplerng.c
    f77_wrap1.c f77_wrap2.c f77_wrap3.c f77_wrap4.c
)

ADD_LIBRARY(${LIBRARY_NAME} ${LIBRARY_TYPE} ${H_FILES} ${SRC_FILES})
TARGET_LINK_LIBRARIES(${LIBRARY_NAME} ${PTHREADS_LIBRARY} ${M_LIB})

SET_TARGET_PROPERTIES(${LIBRARY_NAME} PROPERTIES VERSION ${${PROJECT_NAME}_VERSION} SOVERSION ${${PROJECT_NAME}_MAJOR_VERSION})
install(TARGETS ${LIBRARY_NAME} DESTINATION ${CMAKE_LIBDIR})
install(FILES ${H_FILES} DESTINATION ${CMAKE_INCLUDEDIR} COMPONENT Devel)

# configure a number version file to pass some of the CMake settings
# to the source code
configure_file(
  $ENV{CMAKE_MACROS}/pkg-config.pc.cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/${LIBRARY_NAME}.pc
  @ONLY
)

# install configuration file
install(
  FILES ${CMAKE_CURRENT_SOURCE_DIR}/${LIBRARY_NAME}.pc
  DESTINATION ${CMAKE_LIBDIR}/pkgconfig
  )

ENABLE_TESTING()

ADD_EXECUTABLE(TestProg testprog.c)
TARGET_LINK_LIBRARIES(TestProg ${LIBRARY_NAME})
ADD_TEST(TestProg TestProg)
# Copy testprog.tpt to build directory to allow quick test
# of ./TestProg (or .\Release\TestProg.exe in MSVC):
FILE(COPY ${CMAKE_SOURCE_DIR}/testprog.tpt DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

ADD_EXECUTABLE(cookbook cookbook.c)
TARGET_LINK_LIBRARIES(cookbook ${LIBRARY_NAME})
ADD_TEST(cookbook cookbook)

ADD_EXECUTABLE(FPack fpack.c fpackutil.c)
TARGET_LINK_LIBRARIES(FPack ${LIBRARY_NAME})

ADD_EXECUTABLE(Funpack funpack.c fpackutil.c)
TARGET_LINK_LIBRARIES(Funpack ${LIBRARY_NAME})

ADD_EXECUTABLE(Fitscopy fitscopy.c)
TARGET_LINK_LIBRARIES(Fitscopy ${LIBRARY_NAME})

# To expands the command line arguments in Windows, see:
# http://msdn.microsoft.com/en-us/library/8bch7bkk.aspx
if(MSVC)
  set_target_properties(FPack Funpack PROPERTIES 
    LINK_FLAGS "setargv.obj"
  )
endif(MSVC)

set ( CFITSIO_INCLUDE_DIR "${CMAKE_INCLUDEDIR}" CACHE INTERNAL "cfitsio include directory" )
set ( CFITSIO_LIBRARIES_DIR "${CMAKE_LIBDIR}" CACHE INTERNAL "cfitsio library directory" )
set ( CFITSIO_LIBRARIES "${LIBRARY_NAME}" CACHE INTERNAL "cfitsio library" )
