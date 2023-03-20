local M = {}

local map = require('util.map')

local format_group = vim.api.nvim_create_augroup('LspFormat', { clear = false })

local format = function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  }
end

-- TODO: only register things server is capable of.
local keybindings = function(client, buf)
  map.nmapbuf(buf, 'gd', vim.lsp.buf.definition, 'Go to definition')
  map.nmapbuf(buf, 'gh', vim.lsp.buf.hover, 'Get hover')
  map.nmapbuf(buf, 'gi', vim.lsp.buf.implementation, 'List implementations')
  map.nmapbuf(buf, 'gr', vim.lsp.buf.rename, 'Rename symbol')
end

function M.on_attach(client, bufnr)
  -- set up format
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds { group = format_group, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = format_group,
      buffer = bufnr,
      callback = function()
        format(bufnr)
      end,
    })
  end
  -- set up keybindings
  keybindings(client, bufnr)
end

function M.get_config()
  return {
    on_attach = M.on_attach,
  }
end

function M.get_config_with(config)
  config.on_attach = M.on_attach
  return config
end

return M
