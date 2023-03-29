[Problem]
  type = NekRSProblem
  casename = 'pyramid'
  has_heat_source = false
  output = 'temperature'
[]

[Mesh]
  type = NekRSMesh
  volume = true
[]

[Executioner]
  type = Transient

  [TimeStepper]
    type = NekTimeStepper
  []
[]

[UserObjects]
  [scalar1]
    type = NekScalarValue
    value = 1.0
  []
  [scalar2]
    type = NekScalarValue
    value = 1.0
  []
[]

[Controls]
  [func_control]
    type = RealFunctionControl
    parameter = 'UserObjects/scalar1/value'
    function = 'val'
    execute_on = 'timestep_begin'
  []
  [func_control2]
    type = RealFunctionControl
    parameter = 'UserObjects/scalar2/value'
    function = 'val2'
    execute_on = 'timestep_begin'
  []
[]

[Functions]
  [val]
    type = ParsedFunction
    expression = 'if (t > 1, 200.0, 100.0)'
  []
  [val2]
    type = ParsedFunction
    expression = 'if (t > 1, 400.0, 300.0)'
  []
[]

[Postprocessors]
  [avg_t_5]
    type = NekSideAverage
    field = temperature
    boundary = '5'
  []
  [avg_t_6]
    type = NekSideAverage
    field = temperature
    boundary = '6'
  []
[]

[Outputs]
  exodus = true
  csv = true
[]
