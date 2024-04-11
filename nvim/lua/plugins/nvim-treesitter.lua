return {
  { -- add more treesitter parsers
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "rust",
        "python",
        "json",
        "jq",
        "bicep",
        "markdown",
      })
    end,
  },
}
