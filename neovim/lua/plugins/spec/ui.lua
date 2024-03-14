local vim = vim
local frontend = require('util.frontend')

-- ui plugins should not run when a frontend is attached
if frontend.is_frontend_running() then
  return {}
end

return {
  -- File Tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    opts = {
      window = {
        mappings = {
          ['l'] = 'open',
          ['<tab>'] = 'focus_preview',
        },
      },
    },
    -- TODO: proper keybindings with neotree lua api
    keys = {
      {
        '<Leader>e',
        '<cmd>Neotree toggle right reveal_force_cwd<cr>',
        desc = 'NeoTree',
      },
    },
  },
  --
  {
    'folke/zen-mode.nvim',
    config = true,
    cmd = 'ZenMode',
    keys = {
      {
        '<Leader>z',
        require('zen-mode').toggle,
        desc = 'Toggle zen mode',
      },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    opts = {
      open_mapping = '<Leader>t',
      insert_mappings = false,
      terminal_mappings = false,
      direction = 'horizontal',
    },
    keys = {
      {
        '<Leader>t',
        desc = 'Toggle the terminal',
      },
    },
  },
  {
    -- TODO: configure
    'rcarriga/nvim-notify',
    opts = {
      top_down = false,
    },
  },
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'VeryLazy',
    opts = {
      cmdline = {
        view = 'cmdline',
        format = {
          tab_help = {
            pattern = '^:%s*tab help%s+',
            icon = '',
          },
        },
      },
      messages = {
        view = 'cmdline_timeout',
      },
      popupmenu = {
        enabled = false,
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'written',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'yanked',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'fewer lines',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'more lines',
          },
          opts = { skip = true },
        },
      },
      views = {
        cmdline_timeout = {
          backend = 'popup',
          relative = 'editor',
          timeout = 2000,
          position = {
            row = '100%',
            col = 0,
          },
          size = {
            height = 'auto',
            width = '100%',
          },
          border = {
            style = 'none',
          },
          win_options = {
            winhighlight = {
              Normal = 'NoiceCmdline',
              IncSearch = '',
              CurSearch = '',
              Search = '',
            },
          },
        },
      },
    },
  },
  -- TODO: configure
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = 'screen'
    end,
    opts = {
      bottom = {
        {
          ft = 'toggleterm',
          size = { height = 0.4 },

          -- exclude floating windows
          filter = function(_, win)
            return vim.api.nvim_win_get_config(win).relative == ''
          end,
        },
        right = {
          {
            title = 'Neo-Tree',
            ft = 'neo-tree',
            filter = function(buf)
              return vim.b[buf].neo_tree_source == 'filesystem'
            end,
            size = { height = 0.5 },
          },
        },
      },
    },
  },
  -- TODO: configure
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  -- TODO: configure
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        mode = 'tabs',
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'folke/trouble.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
}
