local vim = vim
local lsp = util.lsp
local map = util.map
local frontend = require('util.frontend')

-- no lsp plugins for frontends
if frontend.is_frontend_running() then
  return {}
end

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
        clangd = {},
        rnix = {},
        rust_analyzer = {},
        jedi_language_server = {},
        lua_ls = {
          on_attach = lsp.disable_formatting,
        },
      },
    },
    config = function(_, opts)
      local servers = opts.servers
      local function setup(server)
        require('lspconfig')[server].setup(lsp.get_config_with(servers[server]))
      end
      local mlsp = require('mason-lspconfig')

      local ensure_installed = {}
      for server, _ in pairs(servers) do
        ensure_installed[#ensure_installed + 1] = server
      end
      mlsp.setup { ensure_installed = ensure_installed }
      mlsp.setup_handlers { setup }

      -- keys
      map.nnoremap('<c-.>', vim.lsp.buf.code_action, 'Get code actions')
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
        black = {},
        nixfmt = {},
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

      mnls.setup {
        ensure_installed = ensure_installed,
        handlers = {
          setup,
        },
      }
      null_ls.setup {
        on_attach = lsp.on_attach,
      }
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
  -- completion
  {
    'ms-jpq/coq_nvim',
    dependencies = {
      'ms-jpq/coq.artifacts',
    },
    branch = 'coq',
    build = ':COQdeps',
    event = 'BufEnter',
    config = function()
      vim.g.coq_settings = {
        keymap = {
          manual_complete = '<C-Space>',
          pre_select = true,
          jump_to_mark = '<c-h>',
          bigger_preview = '<c-/>',
        },
      }
      vim.cmd(':COQnow -s')
    end,
    keys = {
      {
        '<Esc>',
        function()
          if util.fn.pumvisible() then
            return '<C-e>'
          else
            return '<Esc>'
          end
        end,
        mode = 'i',
        desc = 'Exit the completion menu',
        expr = true,
      },
      {
        '<C-j>',
        function()
          return util.fn.pumvisible() and '<C-n>' or '<C-j>'
        end,
        mode = 'i',
        desc = 'Select next completion entry',
        expr = true,
      },
      {
        '<C-k>',
        function()
          return util.fn.pumvisible() and '<C-p>' or '<C-k>'
        end,
        mode = 'i',
        desc = 'Select previous completion entry',
        expr = true,
      },
    },
  },
  {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts',
    build = ':COQsnips compile',
  },
}
