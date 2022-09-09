local M = {}

local vim = vim

function M.map(lhs, rhs, desc)
    vim.keymap.set('', lhs, rhs, { desc = desc, silent = true })
end

function M.imap(lhs, rhs, desc)
    vim.keymap.set('i', lhs, rhs, { desc = desc, silent = true })
end

function M.nmap(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { desc = desc, silent = true })
end

function M.tmap(lhs, rhs, desc)
    vim.keymap.set('t', lhs, rhs, { desc = desc, silent = true })
end

function M.noremap(lhs, rhs, desc)
    vim.keymap.set('', lhs, rhs, { desc = desc, noremap = true, silent = true })
end

function M.inoremap(lhs, rhs, desc)
    vim.keymap.set('i', lhs, rhs, { desc = desc, noremap = true, silent = true })
end

function M.nnoremap(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { desc = desc, noremap = true, silent = true })
end

function M.tnoremap(lhs, rhs, desc)
    vim.keymap.set('t', lhs, rhs, { desc = desc, noremap = true, silent = true })
end

function M.mapbuf(buf, lhs, rhs, desc)
    vim.api.nvim_buf_set_keymap(buf, '', lhs, rhs, { desc = desc, noremap = true, silent = true })
end

function M.imapbuf(buf, lhs, rhs, desc)
    vim.api.nvim_buf_set_keymap(buf, 'i', lhs, rhs, { desc = desc, noremap = true, silent = true })
end

function M.nmapbuf(buf, lhs, rhs, desc)
    vim.api.nvim_buf_set_keymap(buf, 'n', lhs, rhs, { desc = desc, noremap = true, silent = true })
end

function M.tmapbuf(buf, lhs, rhs, desc)
    vim.api.nvim_buf_set_keymap(buf, 't', lhs, rhs, { desc = desc, noremap = true, silent = true })
end

return M
