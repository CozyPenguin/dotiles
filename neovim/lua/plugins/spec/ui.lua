local vim = vim
local map = util.map

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
          ['<tab>'] = 'focus_preview'
        }
      }
    },
    --todo: proper keybindings with neotree lua api
    keys = {
      {
        '<Leader>e', 
        '<cmd>Neotree toggle right reveal_force_cwd<cr>',
        desc='NeoTree'
      }
    }
  }
}
