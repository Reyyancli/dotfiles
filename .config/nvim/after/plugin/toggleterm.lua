require("toggleterm").setup({
  direction = "float",
  start_in_insert = true,
  float_opts = {
    border = "curved",
    width = 120,
    height = 30,
  },
})

vim.keymap.set("n", "<leader>`", "<cmd>ToggleTerm<CR>")
