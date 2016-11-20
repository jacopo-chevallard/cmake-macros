include(Dependencies_mcfor)

set (Dependencies_BEAGLE
  ${Dependencies_mcfor}
  mcfor%prosit.mod
  multivar_splines%multivariate_splines.mod
  bc03_utilities
  flap%flap.mod
)

set (Dependencies_names_BEAGLE
  ${Dependencies_names_mcfor}
  mcfor
  multivar_splines
  bc03_utilities
  flap
)

