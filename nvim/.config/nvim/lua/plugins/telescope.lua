return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.0",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep Files" },
  },
}
