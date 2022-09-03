
-- language servers
local lspconfig = require('lspconfig')
local coq = require('coq')

local servers = { 'omnisharp', 'sumneko_lua', 'rnix', 'jedi_language_server' }

for _, lsp in pairs(servers) do
    lspconfig[lsp].setup(coq.lsp_ensure_capabilities(util.lsp.get_config()))
end
