return {
	{
		"Saghen/blink.cmp",
		version = "*",

		dependencies = {
			"rafamadriz/friendly-snippets",
		},

		opts = {
			keymap = {
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				documentation = {
					auto_show = true,
				},
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
	},
}
