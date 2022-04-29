local vim = vim

vim.opt.shadafile = 'NONE' -- somebody said I should do this

-- try to load impatient
pcall(require, 'impatient')

util = require('util')
require('plugins')
require('mappings')
require('options')

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

vim.opt.shadafile = '' -- reset ShaDa file
