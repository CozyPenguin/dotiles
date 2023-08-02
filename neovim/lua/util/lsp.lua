local M = {}

local format_group = vim.api.nvim_create_augroup('LspFormat', { clear = false })

local format = function(bufnr)
  vim.lsp.buf.format {
    bufnr = bufnr,
  }
end

-- TODO: only register things server is capable of.
local keybindings = function(client, buf)
  local map = util.map
  map.nmapbuf(buf, 'gd', vim.lsp.buf.definition, 'Go to definition')
  map.nmapbuf(buf, 'gh', vim.lsp.buf.hover, 'Get hover')
  map.nmapbuf(buf, 'gi', vim.lsp.buf.implementation, 'List implementations')
  map.nmapbuf(buf, 'gr', vim.lsp.buf.rename, 'Rename symbol')
end

function M.on_attach(client, bufnr)
  -- set up formatting
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

function M.disable_formatting(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
end

function M.get_config()
  return {
    on_attach = M.on_attach,
  }
end

function M.get_config_with(config)
  local config_attach = config.on_attach or nil
  if config_attach then
    config.on_attach = function(client, bufnr)
      config_attach(client, bufnr)
      M.on_attach(client, bufnr)
    end
  else
    config.on_attach = M.on_attach
  end
  return config
end

return M
