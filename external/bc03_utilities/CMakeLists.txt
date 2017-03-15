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
  src/chaext.f src/filter_n.f src/largo.f src/sort2.f src/trapz1.f src/linear.f src/iplace.f 
 src/rminim.f src/rmaxim.f src/percent.f src/rf_color.f src/name_sed.f src/gw_indices.f 
 src/irec_check.f src/gw_ix_sed.f src/gw_ix_sed_lick_system.f src/clyman.f src/ymag2.f 
 src/b912.f src/b4000.f src/ew_balmer.f src/file_header.f src/dattim.f src/t.f 
 src/zx.f src/locate.f src/trapz2.f src/trapz3.f src/trapz_lr.f src/gaussian_v_disp.f 
 src/gauss.f src/chabimf.f src/gw_etal_dat.f src/gw_thesis_dat.f src/gc_d4000.f 
 src/sfr.f src/sfr_0_b.f src/expand_time_steps.f src/convolve_new.f src/copyright.f 
 src/usrsfr.f src/xreverse.f src/sort.f src/trapez.f src/delete_files.f 
 src/gal_mass.f src/sdss_color.f src/read_ised.f src/nread.f src/evol_ised.f 
 src/ke_2filt_correction.f src/dismod.f src/midpnt.f src/dl.f src/fmag.f src/cosmol_c.f 
 src/lick_system.f src/degrade_resolution.f src/trapzq.f src/usort.f src/smthpl.f 
 src/bh_ix_sed.f src/degrade_to_constant_resolution.f src/sigma_indous.f 
 src/fwhm_lick_ids.f src/chelium.f src/pgas.f src/nargu.f src/ke_nfilt_correction.f 
 src/mixfilenames.f src/file_w_ages.f src/no_bl.f src/interpolate_ssp.f src/s500.f 
 src/intrp_ised.f
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

  add_executable(${exec} src/${exec}.f)
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

