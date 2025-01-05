return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {},
  },
  {
    "cschierig/linenumbers.nvim",
    event = "BufEnter",
    config = true,
  },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {},
  },
}
