local vim = vim

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000, -- load first
    config = function()
      vim.cmd('colorscheme tokyonight')
    end
  }
}
