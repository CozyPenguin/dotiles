return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-ts-rainbow2',
    },
    build = ':TSUpdate',
    event = 'BufReadPost',
    opts = {
      ensure_installed = 'all',
      highlight = { enable = util.frontend.vscode_disable() },
      incremental_selection = { enable = true },
      indent = { enable = true },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      rainbow = {
        enable = util.frontend.vscode_disable(),
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  {
    -- TODO: configure colours
    'HiPhish/nvim-ts-rainbow2',
  },
}
