return {
  {
    'nvim-neorg/neorg',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'zen-mode',
    },
    build = ':Neorg sync-parsers',
    opts = {
      load = {
        ['core.defaults'] = {}, -- Loads default behaviour
        ['core.norg.concealer'] = {}, -- Adds pretty icons to your documents
        ['core.norg.dirman'] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = '~/Nextcloud/Notes',
            },
          },
        },
        ['core.presenter'] = {
          zen_mode = 'zen-mode',
        },
      },
    },
    ft = 'norg',
    cmd = 'Neorg',
  },
}
