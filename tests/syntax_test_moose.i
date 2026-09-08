# SYNTAX TEST "Packages/User/MOOSE.sublime-syntax"

[Mesh]
#^^^^^ entity.name.section.moose

  [gen]
#  ^^^ entity.name.section.moose

    type = GeneratedMeshGenerator
#   ^^^^ support.type.property-name.moose
#          ^^^^^^^^^^^^^^^^^^^^^ entity.name.type.class.moose

    dim = 2
#   ^^^ support.type.property-name.moose
#         ^ constant.numeric.integer.moose

    nx = 100
#   ^^ support.type.property-name.moose
#        ^^^ constant.numeric.integer.moose

  []
[]

# MOOSE comment

[UserObjects]
  [dictator]
    type = PorousFlowDictator
    number_fluid_phases = 1
    number_fluid_components = 1
    porous_flow_vars = 'porepressure temperature'
  []
[]

!include other_file.i
