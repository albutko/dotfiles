-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Headless/SSH clipboard via OSC 52: copy lands on the *local* machine's
-- clipboard through the terminal, no xclip/xsel/X server needed. Paste falls
-- back to the last yank since terminals disable OSC 52 clipboard *reads* by
-- default (use the terminal's own paste, e.g. Ctrl+Shift+V, for outside text).
-- Picker root is the enclosing git repo, never the LSP client's root_dir: with
-- per-language servers (pyright, rust-analyzer) the LSP root follows whichever
-- subproject the current buffer belongs to, so the search scope would change as
-- you move between files.
vim.g.root_spec = { { ".git" }, "cwd" }

local osc52 = require("vim.ui.clipboard.osc52")
local function paste()
  return vim.split(vim.fn.getreg(""), "\n")
end
vim.g.clipboard = {
  name = "OSC 52",
  copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
  paste = { ["+"] = paste, ["*"] = paste },
}
