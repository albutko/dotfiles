return {
  { -- add more treesitter parsers
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "rust",
        "python",
        "json",
        "jq",
        "bicep",
        "markdown",
        "bash",
      })
    end,
  },
}
