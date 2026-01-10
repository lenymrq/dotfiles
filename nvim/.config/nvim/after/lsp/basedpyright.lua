return {
  settings = {
    basedpyright = {
      typeCheckingMode = 'all',
      analysis = {
        diagnosticSeverityOverrides = {
          reportMissingTypeStubs = 'none',
          -- Report unknown
          reportUnknownArgumentType = 'none',
          reportUnknownLambdaType = 'none',
          reportUnknownMemberType = 'none',
          reportUnknownParameterType = 'none',
          reportUnknownVariableType = 'none',
          -- Report unused
          reportUnusedCallResult = 'none',
          reportUnusedImport = 'hint',
          reportUnusedClass = 'hint',
          reportUnusedFunction = 'hint',
          reportUnusedVariable = 'hint',
          -- Report Any
          reportExplicitAny = 'none',
        },
      },
    },
  },
}
