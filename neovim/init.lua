local vim = vim

-- vim.opt.shadafile = 'NONE' -- somebody said I should do this

_G.util = require('util')
-- load config
require('mappings')
require('options')
-- load plugins
require('plugins')

if vim.g.vscode then
    require('frontends.vscode')
end

-- load some settings later as I don't need them right away
local async
async = vim.loop.new_async(vim.schedule_wrap(function()
    require('options.async')

    async:close()
end))

async:send()

-- vim.opt.shadafile = '' -- reset ShaDa file
