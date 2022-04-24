-- global settings

-- packer.nvim config

-- ensure that packer is installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local notvscode = function()
    return not vim.g.vscode
end

-- configure plugins
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- for adding mappings
    use 'b0o/mapx.nvim'

    -- surround text objects
    use 'machakann/vim-sandwich'

    -- comment/uncomment
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    
    -- git decorations
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
        cond = notvscode
    }

    -- status line
    use {
        'feline-nvim/feline.nvim',
        requires = { 
            'kyazdani42/nvim-web-devicons',
            'lewis6991/gitsigns.nvim'
        },
        config = function()
            require('feline').setup()
        end,
        -- only start if not using VSCode
        cond = notvscode
    }

    use { 
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
	cond = notvscode
    }
    
    -- colorscheme
    use {
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup {
                options = {
                    transparent = true -- Disables background
                }
            }
            vim.cmd('colorscheme nightfox')
        end
    }
    
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end
)

-- enable 24-bit termgui colors
vim.o.termguicolors = true

-- configure language
vim.api.nvim_exec('language en_GB', true)

-- set clipboard to global clipboard
vim.opt.clipboard:append("unnamedplus")

-- use lf line endings
vim.o.ffs = "unix,dos"

-- tab width
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- key mappings

-- setup mapx
require('mapx').setup{ global = true }

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

-- vscode and nvim only settings
if (vim.g.vscode) then
    -- VSCode extension
    vim.opt.shada=""

    -- map keyboard quickfix
    nnoremap('z=', "<Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<Cr>")
else
    -- ordinary neovim
end

