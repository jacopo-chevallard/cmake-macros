cmake_minimum_required(VERSION 2.8) 

# Allows to set project version
cmake_policy(SET CMP0048 NEW)
project ( BC03_Utilities )

# Which languages do we use
enable_language( Fortran )

# Set the CMAKE_MODULE_PATH
LIST ( APPEND CMAKE_MODULE_PATH $ENV{CMAKE_MACROS})

if ( NOT RPATH_CONFIG )
  include ( General_rpath_config ) 
endif ( NOT RPATH_CONFIG )

# Set library name
set ( LIBRARY_NAME bc03_utilities )

# Whether you build a static or shared library
set(LIBRARY_TYPE SHARED)
if (CMAKE_LIBRARY_TYPE)
  set(LIBRARY_TYPE ${CMAKE_LIBRARY_TYPE})
endif (CMAKE_LIBRARY_TYPE)

# Library installation directory
set (CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)

# Header files installation directory
set (CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${LIBRARY_NAME})

# Binary files installation directory
set (CMAKE_BINDIR ${CMAKE_INSTALL_PREFIX}/bin)

# Set installation directory for *mod files
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/mod_files)

# Source files used to build the library
set ( SRC_FILES 
  src/chaext.f90 src/filter_n.f90 src/largo.f90 src/sort2.f90 src/trapz1.f90 src/linear.f90 src/iplace.f90 
 src/rminim.f90 src/rmaxim.f90 src/percent.f90 src/rf_color.f90 src/name_sed.f90 src/gw_indices.f90 
 src/irec_check.f90 src/gw_ix_sed.f90 src/gw_ix_sed_lick_system.f90 src/clyman.f90 src/ymag2.f90 
 src/b912.f90 src/b4000.f90 src/ew_balmer.f90 src/file_header.f90 src/dattim.f90 src/t.f90 
 src/zx.f90 src/locate.f90 src/trapz2.f90 src/trapz3.f90 src/trapz_lr.f90 src/gaussian_v_disp.f90 
 src/gauss.f90 src/chabimf.f90 src/gw_etal_dat.f90 src/gw_thesis_dat.f90 src/gc_d4000.f90 
 src/sfr.f90 src/sfr_0_b.f90 src/expand_time_steps.f90 src/convolve_new.f90 src/copyright.f90 
 src/usrsfr.f90 src/xreverse.f90 src/sort.f90 src/trapez.f90 src/delete_files.f90 
 src/gal_mass.f90 src/sdss_color.f90 src/read_ised.f90 src/nread.f90 src/evol_ised.f90 
 src/ke_2filt_correction.f90 src/dismod.f90 src/midpnt.f90 src/dl.f90 src/fmag.f90 src/cosmol_c.f90 
 src/lick_system.f90 src/degrade_resolution.f90 src/trapzq.f90 src/usort.f90 src/smthpl.f90 
 src/bh_ix_sed.f90 src/degrade_to_constant_resolution.f90 src/sigma_indous.f90 
 src/fwhm_lick_ids.f90 src/chelium.f90 src/pgas.f90 src/nargu.f90 src/ke_nfilt_correction.f90 
 src/mixfilenames.f90 src/file_w_ages.f90 src/no_bl.f90 src/interpolate_ssp.f90 src/s500.f90 
 src/intrp_ised.f90
  )

# Build the library
add_library(
  ${LIBRARY_NAME}
  ${LIBRARY_TYPE} 
  ${SRC_FILES}
)

# Set variables which can be used by CMakeLists.txt calling this CMakeLists.txt through a 'add_subdirectory()' command
# For this you need to add the PARENT_SCOPE option
set ( BC03_UTILITIES_INCLUDE_DIR ${CMAKE_INCLUDEDIR} CACHE INTERNAL "BC03_UTILITIES include directory" )
set ( BC03_UTILITIES_LIBRARIES_DIR ${CMAKE_LIBDIR} CACHE INTERNAL "BC03_UTILITIES library directory" )
set ( BC03_UTILITIES_LIBRARIES "${LIBRARY_NAME}" CACHE INTERNAL "BC03_UTILITIES library" )

include_directories ( ${CMAKE_CURRENT_SOURCE_DIR} )

set(EXEC_LIST 
  add_filters seefilter sun_color galaxevpl zeropoint csp_galaxev add_bursts
  vel_disp downgrade_resolution ascii_ised bin_ised cm_evolution flux_evolution mm_evolution
  zmag interpolate_ised 
  )

foreach (exec ${EXEC_LIST})

  add_executable(${exec} src/${exec}.f90)
  target_link_libraries(${exec} ${LIBRARY_NAME})

endforeach (exec)

# Install the library and *mod (header) files
install(
  TARGETS ${LIBRARY_NAME} ${EXEC_LIST}
  ARCHIVE DESTINATION  ${CMAKE_LIBDIR}
  LIBRARY DESTINATION  ${CMAKE_LIBDIR}
  RUNTIME DESTINATION  ${CMAKE_BINDIR}
  )

install(
  DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/
  DESTINATION ${CMAKE_INCLUDEDIR}
)

