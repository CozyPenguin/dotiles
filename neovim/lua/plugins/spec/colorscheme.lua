local vim = vim
local frontend = require('util.frontend')

-- no colorscheme for frontends
if frontend.is_frontend_running() then
  return {}
end

return {
  -- {
  --   'folke/tokyonight.nvim',
  --   lazy = false,
  --   priority = 1000, -- load first
  --   config = function()
  --     vim.cmd('colorscheme tokyonight')
  --   end,
  -- },
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000, -- load first
    opts = {
      integrations = {
        alpha = true,
        ts_rainbow2 = true,
        noice = true,
        notify = true,
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)

      vim.cmd('colorscheme catppuccin-mocha')
    end,
  },
}
