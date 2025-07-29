return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = { enabled = true },
      indent = {
        enabled = true,
        scope = {
          char = '╎',
        },
        -- chunk = {
        --   enabled = true,
        --   char = {
        --     corner_top = '┌',
        --     corner_bottom = '└',
        --     -- corner_top = '╭',
        --     -- corner_bottom = '╰',
        --     horizontal = '─',
        --     vertical = '╎',
        --     arrow = '>',
        --   },
        -- },
      },
      quickfile = { enabled = true },
    },
  },
}
