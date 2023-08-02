M = {}

--- A condition which returns false if neovim is called from VSCode.
function M.vscode_disable()
  return not M.is_vscode()
end

function M.is_vscode()
  return vim.g.vscode
end

function M.is_frontend_running()
  return M.is_vscode()
end

return M
