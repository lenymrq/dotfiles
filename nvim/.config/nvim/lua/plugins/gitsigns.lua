return {
  'lewis6991/gitsigns.nvim',
  event = 'BufEnter',
  keys = {
    { '<leader>gB', '<cmd>Gitsigns blame_line<cr>', desc = 'Git blame' },
    { '<leader>gh', '<cmd>Gitsigns preview_hunk_inline<cr>', desc = 'Git view hunk inline' },
    { '<leader>gH', '<cmd>Gitsigns preview_hunk<cr>', desc = 'Git view hunk' },
    { '[h', '<cmd>Gitsigns nav_hunk prev<cr>', desc = 'Previous hunk' },
    { ']h', '<cmd>Gitsigns nav_hunk next<cr>', desc = 'Next hunk' },
  },
}
