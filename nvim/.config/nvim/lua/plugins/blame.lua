return {
  "FabijanZulj/blame.nvim",
  config = function()
    require("blame").setup()
  end,
  keys = {
    { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Show git blame" },
  },
}
