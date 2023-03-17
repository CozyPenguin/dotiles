return {
  {
    'LhKipp/nvim-nu',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    build = ':TSInstall nu',
    config = function()
      require('nu').setup()
    end,
    ft = 'nu',
  },
}
