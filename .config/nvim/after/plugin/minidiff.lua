require("mini.diff").setup({
        source = require("mini.diff").gen_source.save(),
		view = {
			style = "sign",
			signs = {
			  add = "",
			  change = "",
			  delete = "",
			},
		},
})

vim.keymap.set("n", "<leader>md", function()
  require("mini.diff").toggle_overlay()
end, { desc = "Toggle minidiff overlay" })

vim.keymap.set("n", "]h", function()
  require("mini.diff").goto_hunk("next")
end, { desc = "Go to next save change"})

vim.keymap.set("n", "[h", function()
  require("mini.diff").goto_hunk("prev")
end, { desc = "Go to previous save change"})
