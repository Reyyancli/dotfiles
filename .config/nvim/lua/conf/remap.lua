vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pf", vim.cmd.Ex)

vim.keymap.set("n", "j", "h", { noremap = true })
vim.keymap.set("n", "k", "j", { noremap = true })
vim.keymap.set("n", "l", "k", { noremap = true })
vim.keymap.set("n", ";", "l", { noremap = true })
vim.keymap.set("v", "j", "h", { noremap = true })
vim.keymap.set("v", "k", "j", { noremap = true })
vim.keymap.set("v", "l", "k", { noremap = true })
vim.keymap.set("v", ";", "l", { noremap = true })

vim.keymap.set("n", "<A-o>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-i>", ":m .-2<CR>==")

-- Remaps for switching windows
vim.keymap.set("n", "<M-j>", "<C-w>h")
vim.keymap.set("n", "<M-k>", "<C-w>j")
vim.keymap.set("n", "<M-l>", "<C-w>k")
vim.keymap.set("n", "<M-;>", "<C-w>l")

-- Remaps for buffers
vim.keymap.set("n", "<leader>n", ":bnext<CR>")
vim.keymap.set("n", "<leader>p", ":bprev<CR>")
vim.keymap.set("n", "<leader>d", ":bd<CR>")

-- Remaps for tabs
vim.keymap.set("n", "<leader>tn", ":tabn<CR>")
vim.keymap.set("n", "<leader>tp", ":tabp<CR>")
vim.keymap.set("n", "<leader>td", ":tabclose<CR>")

vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-H>", "<C-w>")

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
