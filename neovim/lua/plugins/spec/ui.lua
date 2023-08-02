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
      -- TODO: think about keybinding
      open_mapping = '<Leader>wt',
      insert_mappings = false,
      terminal_mappings = false,
      direction = 'horizontal',
    },
    keys = {
      {
        '<Leader>wt',
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
          tab_help = { pattern = '^:%s*tab help%s+' }, -- TODO: configure icon
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
}
