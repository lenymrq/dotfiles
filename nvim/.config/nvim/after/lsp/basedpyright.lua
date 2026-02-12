return {
  settings = {
    basedpyright = {
      typeCheckingMode = 'strict',
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
          reportUnusedImport = 'warning',
          reportUnusedClass = 'warning',
          reportUnusedFunction = 'warning',
          reportUnusedVariable = 'warning',
          -- Report Any
          reportExplicitAny = 'none',
          -- Report private usage
          reportPrivateUsage = 'none',
        },
      },
    },
  },
}
