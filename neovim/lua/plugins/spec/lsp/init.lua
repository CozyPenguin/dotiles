local vim = vim
local format = require('plugins.spec.lsp.format')

-- adapted from folke's lazyvim
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neodev.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    event = 'BufReadPre',
    opts = {
      servers = {
        rnix = {},
        rust_analyzer = {},
        lua_ls = {},
      },
    },
    config = function(_, opts)
      local servers = opts.servers

      local function setup(server)
        require('lspconfig')[server].setup(servers[server])
      end

      local mlsp = require('mason-lspconfig')

      local ensure_installed = {}
      for server, _ in pairs(servers) do
        ensure_installed[#ensure_installed + 1] = server
      end
      mlsp.setup { ensure_installed = ensure_installed }
      mlsp.setup_handlers { setup }
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'williamboman/mason.nvim',
      'jay-babu/mason-null-ls.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      formatters = {
        stylua = {},
      },
    },
    config = function(_, opts)
      local formatters = opts.formatters

      local null_ls = require('null-ls')

      local function setup(name, types)
        vim.tbl_map(function(type)
          null_ls.register(null_ls.builtins[type][name])
        end, types)
      end

      local mnls = require('mason-null-ls')

      local ensure_installed = {}
      for server, _ in pairs(formatters) do
        ensure_installed[#ensure_installed + 1] = server
      end

      mnls.setup { ensure_installed = ensure_installed }
      null_ls.setup {
        on_attach = format.on_attach,
      }
      mnls.setup_handlers { setup }
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    config = true,
  },
  {
    'folke/neodev.nvim',
    config = true,
  },
}
