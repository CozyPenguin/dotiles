return {
  {
    'nvim-neorg/neorg',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/zen-mode.nvim',
    },
    build = ':Neorg sync-parsers',
    opts = {
      load = {
        ['core.defaults'] = {}, -- Loads default behaviour
        ['core.concealer'] = {}, -- Adds pretty icons to documents
        ['core.dirman'] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = '~/Nextcloud/Notes',
            },
          },
        },
        ['core.presenter'] = {
          config = {
            zen_mode = 'zen-mode',
          },
        },
      },
    },
    ft = 'norg',
    cmd = 'Neorg',
  },
}
