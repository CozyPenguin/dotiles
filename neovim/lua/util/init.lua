local M = {}

M.command = require('util.command')
M.map = require('util.map')
M.lsp = require('util.lsp')

local plugin_cfg_dir = 'plugins.config.'
function M.load_config(cfg)
    require(plugin_cfg_dir .. cfg)
end

return M
