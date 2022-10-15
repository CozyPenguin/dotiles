local packer, bootstrapped = require('plugins.packerInit')

local notvscode = function()
    return not vim.g.vscode
end

-- configure plugins
packer.startup(function(use)
    -- libraries and required stuff
    use('wbthomason/packer.nvim')
    use('lewis6991/impatient.nvim') -- caches plugins to reduce startup time
    use {
        'kyazdani42/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup()
        end,
        cond = notvscode,
        module = 'nvim-web-devicons',
    }

    use {
        'dstein64/vim-startuptime',
        config = function()
            vim.g.startuptime_tries = 10
        end,
        cond = notvscode,
        cmd = 'StartupTime',
    }

    -- highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            util.load_config('nvim-treesitter')
        end,
        cond = notvscode,
        event = 'BufRead',
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup { '*' }
        end,
        cond = notvscode,
        cmd = 'ColorizerAttachToBuffer',
        event = 'BufReadPre',
    }

    -- lsp, dap, etc.
    use {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
        cond = notvscode,
    }

    use {
        'williamboman/mason-lspconfig.nvim',
        after = 'mason.nvim',
        config = function()
            require('mason-lspconfig').setup {
                automatic_installation = true
            }
        end,
        cond = notvscode
    }

    -- todo: configure
    use {
        'neovim/nvim-lspconfig',
        after = { 'mason-lspconfig.nvim', 'coq_nvim' },
        cond = notvscode,
        config = function()
            util.load_config('nvim-lspconfig')
        end,
    }

    -- todo: configure
    use {
        'ms-jpq/coq_nvim',
        run = ':COQdeps',
        setup = function()
            vim.g.coq_settings = {
                auto_start = 'shut-up',
                keymap = {
                    jump_to_mark = '',
                },
            }
        end,
        cond = notvscode,
    }
    use {
        'ms-jpq/coq.artifacts',
        after = 'coq_nvim',
    }
    use {
        'ms-jpq/coq.thirdparty',
        after = 'coq_nvim',
    }

    -- languages
    use {
        'folke/neodev.nvim',
        wants = 'nvim-lspconfig',
        config = function()
            util.load_config('neodev')
        end,
        cond = notvscode,
    }

    -- operators and mappings
    use {
        'machakann/vim-sandwich',
        config = function()
            -- remove s keybind as it conflicts with vim-sandwich and I never use it anyways
            util.map.map('s', '<nop>')
        end,
        keys = { { 'n', 's' }, { 'v', 's' } },
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
        keys = { { 'n', 'gc' }, { 'n', 'gb' }, { 'v', 'gc' }, { 'v', 'gb' } },
    }

    -- git
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
        cond = notvscode,
    }

    -- utility
    use {
        'nmac427/guess-indent.nvim',
        config = function()
            require('guess-indent').setup {}
        end
    }

    -- formatting
    use {
        'mhartington/formatter.nvim',
        config = function()
            require('formatter').setup {
                filetype = {
                    lua = require('formatter.filetypes.lua').stylua,
                },
            }

            -- autoformat
            local formatGroup = vim.api.nvim_create_augroup('Formatter', {})
            vim.api.nvim_create_autocmd('BufWritePost', {
                group = formatGroup,
                -- desc = 'Format file',
                command = 'FormatWrite',
            })
        end,
    }

    -- ui
    use {
        'alvarosevilla95/luatab.nvim',
        requires = {
            { 'kyazdani42/nvim-web-devicons', opt = true },
        },
        cond = notvscode,
        config = function()
            require('luatab').setup()
        end,
    }

    -- todo: configure
    use {
        'feline-nvim/feline.nvim',
        requires = {
            { 'kyazdani42/nvim-web-devicons', opt = true },
            { 'lewis6991/gitsigns.nvim', opt = true },
        },
        config = function()
            util.load_config('feline')
        end,
        cond = notvscode,
        after = 'nightfox.nvim',
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            { 'kyazdani42/nvim-web-devicons', opt = true },
        },
        config = function()
            util.load_config('nvim-tree')
        end,
        cond = notvscode,
    }

    use {
        'akinsho/toggleterm.nvim',
        config = function()
            util.load_config('toggleterm')
        end,
        keys = { '<Leader>t', '<C-j>' },
        cond = notvscode,
    }

    -- fuzzy finder
    -- todo: configure
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim', opt = true },
            { 'kyazdani42/nvim-web-devicons', opt = true },
            { 'nvim-treesitter/nvim-treesitter', opt = true },
            -- provides faster native fzf implementation
            use {
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make',
            },
        },
        config = function()
            local ts = require('telescope')
            ts.setup {}
            ts.load_extension('fzf')
        end,
        cond = notvscode,
        cmd = 'Telescope',
        module = 'telescope',
    }

    use {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup()
        end,
        cond = notvscode,
    }

    -- todo: temporary
    use {
        'EdenEast/nightfox.nvim',
        run = ':NightfoxCompile',
        config = function()
            require('nightfox').setup {
                options = {
                    transparent = true, -- Disables background
                },
            }
            vim.cmd('colorscheme nightfox')
        end,
        cond = notvscode,
    }

    if bootstrapped then
        require('packer').sync()
    end
end)
