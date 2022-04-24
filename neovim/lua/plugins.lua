-- Plugin configuration

-- ensure that packer is installed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
end

local notvscode = function()
    return not vim.g.vscode
end

-- configure plugins
require('packer').startup {
    function(use)
        use('wbthomason/packer.nvim')

        -- for adding mappings
        use('b0o/mapx.nvim')

        -- treesitter
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function()
                require('nvim-treesitter.configs').setup {
                    ensure_installed = 'all',
                }
            end,
            cond = notvscode,
        }
        -- surround text objects
        -- todo: configure/replace with alternative if I find a better one
        use('machakann/vim-sandwich')

        -- comment/uncomment
        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end,
        }

        -- git decorations
        -- todo: configure
        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup()
            end,
            cond = notvscode,
        }

        -- status line
        -- todo: configure
        use {
            'feline-nvim/feline.nvim',
            requires = {
                'kyazdani42/nvim-web-devicons',
                'lewis6991/gitsigns.nvim',
            },
            config = function()
                require('feline').setup()
            end,
            cond = notvscode,
        }

        --todo: eventually add nvim-tree

        -- sets background for color constants in code
        -- todo: configure
        use {
            'norcalli/nvim-colorizer.lua',
            config = function()
                require('colorizer').setup()
            end,
            cond = notvscode,
        }

        -- colorscheme
        -- todo: temporary
        use {
            'EdenEast/nightfox.nvim',
            config = function()
                require('nightfox').setup {
                    options = {
                        transparent = true, -- Disables background
                    },
                }
                vim.cmd('colorscheme nightfox')
            end,
        }

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        },
    },
}
