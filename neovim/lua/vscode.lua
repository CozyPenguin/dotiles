-- settings when using VSCode as a frontend

-- do not use shada when running VSCode
vim.opt.shada=''
-- map keyboard quickfix
nnoremap('z=', "<Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<Cr>")