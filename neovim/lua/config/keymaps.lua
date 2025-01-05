-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = require("util.map")

if vim.g.vscode then
  local vscode = require("vscode")
  -- quit/session
  vim.keymap.set("n", "<leader>qq", function()
    vscode.call("workbench.action.quit")
  end)
end
