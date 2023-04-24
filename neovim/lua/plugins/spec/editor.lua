local frontend = require('util.frontend')

-- no editor plugins for frontends
if frontend.is_frontend_running() then
  return {}
end

return {
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = 'BufReadPost',
    config = true,
  },
  {
    -- TODO: configure
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
  {
    'cschierig/linenumbers.nvim',
    event = 'BufEnter',
    config = true,
  },
}
