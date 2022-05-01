local M = {}

local map = require('util.map')

local on_attach = function(client, buf)
    map.nmapbuf(buf, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', 'Go to definition')
    map.nmapbuf(buf, 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', 'Get hover')
    map.nmapbuf(buf, 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', 'List implementations')
end

function M.get_config()
    return {
        on_attach = on_attach,
    }
end

return M
