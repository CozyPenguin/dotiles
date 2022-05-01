require('lspconfig')['sumneko_lua'].setup(
    require('coq').lsp_ensure_capabilities(require('lua-dev').setup(util.lsp.get_config()))
)
