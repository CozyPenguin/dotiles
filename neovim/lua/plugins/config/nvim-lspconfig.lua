local api = vim.api

require('nvim-lsp-installer').setup {
    automatic_installation = true,
}

-- language servers
local lspconfig = require('lspconfig')
local coq = require('coq')

local servers = { 'omnisharp', 'sumneko_lua' }

for _, lsp in pairs(servers) do
    lspconfig[lsp].setup(coq.lsp_ensure_capabilities(util.lsp.get_config()))
end

-- configuration
local lspGroup = api.nvim_create_augroup('lsp', {})
api.nvim_create_autocmd('BufWritePre', {
    group = lspGroup,
    desc = 'Format file',
    callback = vim.lsp.buf.formatting_sync,
})
