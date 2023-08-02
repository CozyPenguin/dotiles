-- mappings and command abbreviations
local vim = vim
local map = util.map
local command = util.command

-- leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- remove arrow key mappings
map.map('<up>', '<nop>')
map.map('<down>', '<nop>')
map.map('<left>', '<nop>')
map.map('<right>', '<nop>')

-- map jk to escape
map.inoremap('jk', '<ESC>')
map.inoremap('jK', '<ESC>')
map.inoremap('Jk', '<ESC>')
map.inoremap('JK', '<ESC>')

local enter_normal = '<cmd>stopinsert<cr>'
map.tnoremap('jk', enter_normal)
map.tnoremap('jK', enter_normal)
map.tnoremap('Jk', enter_normal)
map.tnoremap('JK', enter_normal)

-- map :h to :tab help
command.cnoreabbrev('h', 'tab help')
