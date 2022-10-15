require('lspconfig')['sumneko_lua'].setup(
    require('coq').lsp_ensure_capabilities(require('neodev').setup(util.lsp.get_config()))
)
