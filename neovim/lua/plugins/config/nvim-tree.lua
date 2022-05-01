local vim = vim
local map = util.map

require('nvim-tree').setup {
    disable_netrw = true,
    hijack_cursor = true,
    diagnostics = {
        enable = true,
    },
    view = {
        hide_root_folder = true,
        side = 'right',
        mappings = {
            list = {
                { key = 'L', action = 'edit' },
                { key = 'l', action = 'tabnew' },
                { key = 'h', action = 'parent_node' },
            },
        },
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
    },
    filters = {
        custom = { [[^\.git]] },
    },
    actions = {
        open_file = {
            quit_on_open = true,
            resize_window = true,
        },
    },
}

vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
}
vim.g.nvim_tree_create_in_close_folder = 1

map.map('<Leader>e', '<Cmd>NvimTreeToggle<CR>', 'Toggle the file explorer')
