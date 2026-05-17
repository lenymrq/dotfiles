local now_if_args = Config.now_if_args

now_if_args(function()
  local ts_update = function()
    vim.cmd 'TSUpdate'
  end
  Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  vim.pack.add {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  }

  require('nvim-treesitter').setup()

  local highlight = function(bufnr, lang)
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(bufnr, lang)
    end
  end

  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local ft = vim.bo.filetype
      local bt = vim.bo.buftype
      local buf = args.buf

      if bt ~= '' then
        return
      end

      -- Folds
      vim.opt_local.foldmethod = 'expr'
      vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

      -- Indentation
      vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"

      -- Parsers
      if vim.fn.executable 'tree-sitter' ~= 1 then
        return vim.notify('tree-sitter CLI not found. Parsers cannot be installed.', vim.log.levels.ERROR, { title = 'Treesitter' })
      end

      if not vim.treesitter.language.get_lang(ft) then
        return
      end

      -- Highlights
      local treesitter = require 'nvim-treesitter'

      if vim.list_contains(treesitter.get_installed(), ft) then
        highlight(buf, ft)
      elseif vim.list_contains(treesitter.get_available(), ft) then
        treesitter.install(ft):await(function()
          highlight(buf, ft)
        end)
      end
    end,
  })
end)
