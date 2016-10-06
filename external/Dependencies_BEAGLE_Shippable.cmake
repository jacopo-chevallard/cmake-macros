include(Dependencies_mcfor)

set (Dependencies_BEAGLE
  multivar_splines%multivariate_splines.mod
  bc03_utilities
  mcfor%prosit.mod
  ${Dependencies_mcfor}
)

set (Dependencies_names_BEAGLE
  multivar_splines
  bc03_utilities
  mcfor
  ${Dependencies_names_mcfor}
)

