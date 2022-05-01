require('nvim-lsp-installer').setup {
    automatic_installation = true,
}

-- language servers
local lspconfig = require('lspconfig')
-- local coq = require('coq')

local servers = { 'omnisharp', 'sumneko_lua' }

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup( --[[coq.lsp_ensure_capabilities]](util.lsp.get_config()))
end
