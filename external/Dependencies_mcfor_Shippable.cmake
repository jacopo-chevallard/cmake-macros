include(Dependencies_astrofortran_Shippable)

set (Dependencies_mcfor
  orderpack2%lib_sorting.mod
  multinest%nested.mod
  nlopt%nlopt.f
  diver%de.mod
  fortranparser%fortranparser.mod
  astrofortran%lib_checking.mod
  ${Dependencies_astrofortran}
)

set (Dependencies_names_mcfor
  orderpack2
  multinest
  nlopt
  diver
  fortranparser
  astrofortran
  ${Dependencies_names_astrofortran}
)

