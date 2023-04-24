-- mappings and command abbreviations
local vim = vim
local map = util.map
local command = util.command

-- leader key
vim.g.mapleader = ' '

-- remove arrow key mappings
map.map('<up>', '<nop>')
map.map('<down>', '<nop>')
map.map('<left>', '<nop>')
map.map('<right>', '<nop>')

-- map jk to escape
map.imap('jk', '<ESC>')
map.imap('jK', '<ESC>')
map.imap('Jk', '<ESC>')
map.imap('JK', '<ESC>')

-- map :h to :tab help
command.cnoreabbrev('h', 'tab help')
