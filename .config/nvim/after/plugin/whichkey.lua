vim.keymap.set("n", "<C-_>", function()
  require("which-key").show()
end, { desc = "Show WhichKey" })
