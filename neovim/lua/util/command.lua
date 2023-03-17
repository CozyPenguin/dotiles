-- abbreviation functions
-- credits go to https://gitlab.com/yorickpeterse/dotfiles/-/blob/main/dotfiles/.config/nvim/lua/dotfiles/abbrev.lua

local M = {}
local fn = vim.fn

function M.cnoreabbrev(lhs, rhs)
  vim.cmd.cnoreabbrev {
    '<expr>',
    lhs,
    'v:lua.util.command.incommandline("' .. lhs .. '","' .. rhs .. '")',
  }
end

function M.incommandline(lhs, rhs)
  if fn.getcmdtype() == ':' and fn.getcmdline():match('^' .. lhs) then
    return rhs
  else
    return lhs
  end
end

return M
