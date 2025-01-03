-- settings when using VSCode as a frontend
local map = util.map

map.map('<Leader>e', "<Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>")
map.map('<Leader>t', "<Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>")

-- map keyboard quickfix
map.nmap('z=', "<Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<Cr>")
