cmake_minimum_required(VERSION 2.8) 
project ( bc03_utilities )
enable_language( Fortran )

# Set the CMAKE_MODULE_PATH
LIST ( APPEND CMAKE_MODULE_PATH $ENV{CMAKE_MACROS})

if ( NOT RPATH_CONFIG )
  include ( General_rpath_config ) 
endif ( NOT RPATH_CONFIG )

# Set library name
set ( LIBRARY_NAME bc03_utilities )

# Source files used to build the library
set ( SRC_FILES 
  chaext.f filter_n.f largo.f sort2.f trapz1.f linear.f iplace.f
	rminim.f rmaxim.f percent.f rf_color.f name_sed.f gw_indices.f
	irec_check.f gw_ix_sed.f gw_ix_sed_lick_system.f clyman.f ymag2.f
	b912.f b4000.f ew_balmer.f file_header.f dattim.f t.f
	zx.f locate.f trapz2.f trapz3.f trapz_lr.f gaussian_v_disp.f
	gauss.f chabimf.f gw_etal_dat.f gw_thesis_dat.f gc_d4000.f
	sfr.f sfr_0_b.f expand_time_steps.f convolve_new.f copyright.f
	usrsfr.f xreverse.f sort.f trapez.f delete_files.f
	gal_mass.f sdss_color.f read_ised.f nread.f evol_ised.f
	ke_2filt_correction.f dismod.f midpnt.f dl.f fmag.f cosmol_c.f
	lick_system.f degrade_resolution.f trapzq.f usort.f smthpl.f
	bh_ix_sed.f degrade_to_constant_resolution.f sigma_indous.f
	fwhm_lick_ids.f chelium.f pgas.f nargu.f ke_nfilt_correction.f
  )

# Where do we put the *mod files created during compilation?
set ( CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/mod_files )

# Build the library
add_library(
  ${LIBRARY_NAME}
  SHARED 
  ${SRC_FILES}
)

# Set variables which can be used by CMakeLists.txt calling this CMakeLists.txt through a 'add_subdirectory()' command
# For this you need to add the PARENT_SCOPE option
set ( BC03_UTILITIES_LIBRARIES "${CMAKE_INSTALL_PREFIX}/lib/${LIBRARY_NAME}" PARENT_SCOPE )
set ( BC03_UTILITIES_INCLUDE_DIR ${CMAKE_INSTALL_PREFIX}/include PARENT_SCOPE )

include_directories ( ${CMAKE_CURRENT_SOURCE_DIR} )

add_executable( galaxevpl galaxevpl.f )
target_link_libraries( galaxevpl ${LIBRARY_NAME} )

add_executable( add_filters add_filters.f )
target_link_libraries( add_filters ${LIBRARY_NAME} )

add_executable( seefilter seefilter.f )
target_link_libraries( seefilter ${LIBRARY_NAME} )

add_executable( zeropoint zeropoint.f )
target_link_libraries( zeropoint ${LIBRARY_NAME} )

add_executable( csp_galaxev csp_galaxev.f )
target_link_libraries( csp_galaxev ${LIBRARY_NAME} )

add_executable( add_bursts add_bursts.f )
target_link_libraries( add_bursts ${LIBRARY_NAME} )

add_executable( vel_disp vel_disp.f )
target_link_libraries( vel_disp ${LIBRARY_NAME} )

add_executable( downgrade_resolution downgrade_resolution.f )
target_link_libraries( downgrade_resolution ${LIBRARY_NAME} )

add_executable( ascii_ised ascii_ised.f )
target_link_libraries( ascii_ised ${LIBRARY_NAME} )

add_executable( bin_ised bin_ised.f )
target_link_libraries( bin_ised ${LIBRARY_NAME} )

add_executable( cm_evolution cm_evolution.f )
target_link_libraries( cm_evolution ${LIBRARY_NAME} )

add_executable( mm_evolution mm_evolution.f )
target_link_libraries( mm_evolution ${LIBRARY_NAME} )

add_executable( zmag zmag.f )
target_link_libraries( zmag ${LIBRARY_NAME} )

add_executable( add_noise add_noise.f )
target_link_libraries( add_noise ${LIBRARY_NAME} )

set ( EXECUTABLES_NAME 
  galaxevpl
  add_filters
  seefilter
  zeropoint
  csp_galaxev
  add_bursts
  vel_disp
  downgrade_resolution
  ascii_ised
  bin_ised
  cm_evolution
  mm_evolution
  zmag
  add_noise
  )

# Install the library and *mod (header) files
install(
  TARGETS ${LIBRARY_NAME} ${EXECUTABLES_NAME}
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
  )

install(
  DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/
  DESTINATION include
)

