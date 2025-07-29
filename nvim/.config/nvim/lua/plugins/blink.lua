return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',

    opts = {
      keymap = { preset = 'enter' },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = { documentation = { auto_show = false } },

      sources = {
        -- default = { 'lsp', 'path', 'snippets' },
        default = { 'lsp' },
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' },
      signature = { enabled = true },
    },
    opts_extend = { 'sources.default' },
  },
}
