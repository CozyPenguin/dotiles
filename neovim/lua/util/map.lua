local M = {}

local vim = vim

function M.map(lhs, rhs)
    vim.keymap.set('', lhs, rhs)
end

function M.imap(lhs, rhs)
    vim.keymap.set('i', lhs, rhs)
end

return M
