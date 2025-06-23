return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = {
        char = '▏', -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        highlight = 'Function',
      },
    },
  },
}
