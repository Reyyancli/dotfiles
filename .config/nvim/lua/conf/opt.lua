vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.mouse = 'a'
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- Plugins stuff
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = "base16_material_darker"
vim.g.syntax_on = false
vim.cmd.colorscheme("rose-pine")

-- Built in vim stuff
vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open)
