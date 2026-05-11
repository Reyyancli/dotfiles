local ts = require("nvim-treesitter")
vim.g.syntax_on = false

-- install parsers
ts.install({
  "lua",
  "vim",
  "vimdoc",
  "bash",
  "markdown",
  "markdown_inline",
  "json",
  "yaml",
  "toml",
  "html",
  "css",
  "javascript",
  "typescript",
  "tsx",
  "rust",
  "go",
  "python",
})

-- enable treesitter automatically
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})
