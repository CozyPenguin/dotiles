-- global settings

util = {}
require('plugins')
require('mappings')

-- enable 24-bit termgui colors
vim.o.termguicolors = true

-- configure language
vim.cmd('language en_GB')

-- set clipboard to global clipboard
vim.opt.clipboard:append('unnamedplus')

-- use lf line endings
vim.o.ffs = 'unix,dos'

-- tab width
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- vscode and nvim only settings
if vim.g.vscode then
    require('vscode')
else
    -- ordinary neovim
end
