prefix=@CMAKE_INSTALL_PREFIX@
exec_prefix=@CMAKE_BINDIR@
libdir=@CMAKE_LIBDIR@
includedir=@CMAKE_INCLUDEDIR@

Name: @PROJECT_NAME@
Description: @PROJECT_DESCRIPTION@
Version: @PROJECT_VERSION@
Requires: @PKG_CONFIG_REQUIRES@
Libs: -L${libdir} -l@LIBRARY_NAME@ @PKG_CONFIG_LIBS@
Cflags: -I${includedir} @PKG_CONFIG_CFLAGS@
