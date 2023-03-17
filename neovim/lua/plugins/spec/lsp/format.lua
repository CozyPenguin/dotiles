local vim = vim

-- folke's lazyvim again
local M = {}

local group = vim.api.nvim_create_augroup('LspFormat', { clear = false })

function M.format(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  }
end

function M.on_attach(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = group,
      buffer = bufnr,
      callback = function()
        M.format(bufnr)
      end,
    })
  end
end

return M
