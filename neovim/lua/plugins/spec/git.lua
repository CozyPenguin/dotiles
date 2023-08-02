local frontend = require('util.frontend')

-- no git plugins for frontends
if frontend.is_frontend_running() then
  return {}
end

return {
  {
    -- TODO: configure
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
  {},
}
