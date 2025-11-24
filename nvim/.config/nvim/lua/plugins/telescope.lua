return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep Files" },
  },
}
