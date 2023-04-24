-- general (neo)vim settings
local vim = vim
local opt = vim.opt

-- enable 24-bit termgui colors
opt.termguicolors = true

-- file settings
opt.ffs = 'unix,dos'
opt.fileencoding = 'utf-8'

-- indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- line numbers and stuff
opt.signcolumn = 'yes'

-- editor settings
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.autowrite = true
opt.autowriteall = true
opt.showmode = false

-- tabline
opt.showtabline = 2
