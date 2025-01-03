local M = {}

function M.pumvisible()
  return vim.fn.pumvisible() ~= 0
end

return M
