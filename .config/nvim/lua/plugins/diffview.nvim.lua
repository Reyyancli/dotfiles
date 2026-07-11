return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewFileHistory",
  },
  keys = {
    {
      "<leader>gd",
      "<cmd>DiffviewOpen<cr>",
      desc = "Open Diffview",
    },
    {
      "<leader>gh",
      "<cmd>DiffviewFileHistory %<cr>",
      desc = "File history",
    },
    {
      "<leader>gq",
      "<cmd>DiffviewClose<cr>",
      desc = "Close Diffview",
    },
  },
  config = function()
    require("diffview").setup({
      enhanced_diff_hl = true,
    })
  end,
}
