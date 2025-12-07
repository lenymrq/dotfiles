return {
  settings = {
    basedpyright = {
      typeCheckingMode = 'off',
      analysis = {
        diagnosticSeverityOverrides = {
          reportMissingTypeStubs = false,
          -- Report unknown
          reportUnknownArgumentType = false,
          reportUnknownLambdaType = false,
          reportUnknownMemberType = false,
          reportUnknownParameterType = false,
          reportUnknownVariableType = false,
          -- Report unused
          reportUnusedCallResult = false,
          reportUnusedImport = 'hint',
          reportUnusedClass = 'hint',
          reportUnusedFunction = 'hint',
          reportUnusedVariable = 'hint',
        },
      },
    },
  },
}
