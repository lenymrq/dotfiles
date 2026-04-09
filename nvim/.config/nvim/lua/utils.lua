return {
  on_packchanged = function(plugin_name, kinds, callback, desc)
    local f = function(ev)
      local name, kind = ev.data.spec.name, ev.data.kind
      if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then
        return
      end
      if not ev.data.active then
        vim.cmd.packadd(plugin_name)
      end
      callback(ev.data)
    end
    vim.api.nvim_create_autocmd('PackChanged', { pattern = '*', callback = f, desc = desc })
  end,
}
