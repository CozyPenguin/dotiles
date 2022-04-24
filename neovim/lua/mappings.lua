-- mappings and abbreviations

-- setup mapx and custom functions
require('mapx').setup { global = true }
require('util.abbrev')

-- leader key to space ' '
vim.g.mapleader = ' '

-- remove arrow key mappings
noremap('<up>', '<nop>')
noremap('<down>', '<nop>')
noremap('<left>', '<nop>')
noremap('<right>', '<nop>')

-- map jk to escape
inoremap('jk', '<ESC>')
inoremap('JK', '<ESC>')
inoremap('jK', '<ESC>')

-- map :h to :tab help
cnoreabbrev('h', 'tab help')