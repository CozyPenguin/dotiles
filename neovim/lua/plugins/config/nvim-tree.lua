local vim = vim
local map = util.map

require('nvim-tree').setup {
    create_in_closed_folder = true,
    disable_netrw = true,
    hijack_cursor = true,
    diagnostics = {
        enable = true,
        show_on_dirs = true,
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
        highlight_git = true,
        indent_markers = {
            enable = true,
        },
        icons = {
            show = {
                git = false,
                folder = true,
                file = true,
            },
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

map.map('<Leader>e', '<Cmd>NvimTreeToggle<CR>', 'Toggle the file explorer')
