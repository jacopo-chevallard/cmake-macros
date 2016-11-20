include(Dependencies_astrofortran)

set (Dependencies_mcfor
  ${Dependencies_astrofortran}
  astrofortran%lib_checking.mod
  orderpack2%lib_sorting.mod
  multinest%nested.mod
  nlopt%nlopt.f
  jsonfortran%json_module.mod
  fortranparser%fortranparser.mod
)

set (Dependencies_names_mcfor
  ${Dependencies_names_astrofortran}
  astrofortran
  orderpack2
  multinest
  nlopt
  jsonfortran
  fortranparser
)

