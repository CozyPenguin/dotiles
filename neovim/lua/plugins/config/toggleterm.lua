local vim = vim
local map = util.map

require('toggleterm').setup {
    open_mapping = '<NOP>',
}

map.map('<Leader>t', '<Cmd>ToggleTerm<CR>', 'Toggle the terminal')
map.map('<C-j>', '<Cmd>ToggleTerm<CR>', 'Toggle the terminal')
map.tmap('<C-j>', '<Cmd>ToggleTerm<CR>', 'Toggle the terminal')
