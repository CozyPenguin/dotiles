local M = {}

local fn = vim.fn
local api = vim.api

function M.get_event(event)
    return 'User ' .. event
end

local function exec_autocmds(event)
    api.nvim_exec_autocmds('User', { pattern = event, modeline = false })
end

local pluginGroup = api.nvim_create_augroup('plugin', {})

-- is the cwd part of a git repository
api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
    group = pluginGroup,
    desc = 'Check if we are inside a git repository',
    callback = function()
        if vim.fn.system('git rev-parse --is-inside-work-tree'):match('true') then
            exec_autocmds('InGitRepo')
        end
    end,
})

api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
    group = pluginGroup,
    desc = 'Check if we have opened a directory',
    callback = function()
        if vim.fn.isdirectory(vim.fn.expand('%:p')) ~= 0 then
            exec_autocmds('InDirectory')
        end
    end,
})

api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
    group = pluginGroup,
    desc = 'Check if we are inside the nvim config directory',
    callback = function()
        if 'nvim' == vim.fn.expand('%:t') then
            exec_autocmds('InConfigDir')
        end
    end,
})

return M
