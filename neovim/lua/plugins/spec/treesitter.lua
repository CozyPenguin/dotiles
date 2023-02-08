local vim = vim
local map = util.map

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    opts = {
      ensure_installed = 'all',
      highlight = {
        enable = true
      },
      incremental_selection = {
        enable = true
      },
      indent = {
        enable = true
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false
      }
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring'
  }
}
