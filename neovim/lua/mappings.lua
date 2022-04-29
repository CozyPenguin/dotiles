-- mappings and abbreviations
local map = util.map

-- leader key
vim.g.mapleader = ' '

-- remove arrow key mappings
map.map('<up>', '<nop>')
map.map('<down>', '<nop>')
map.map('<left>', '<nop>')
map.map('<right>', '<nop>')

-- map jk to escape
map.imap('jk', '<ESC>')
map.imap('JK', '<ESC>')
map.imap('jK', '<ESC>')

-- map :h to :tab help
cnoreabbrev('h', 'tab help')
