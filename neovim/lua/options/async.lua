-- options which I don't need right away
local vim = vim
local opt = vim.opt

-- configure language
vim.cmd('language en_GB')

-- set clipboard to global clipboard
opt.clipboard:append('unnamedplus')
