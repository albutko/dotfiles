-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Change Escape Key to JJ
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

--  Paging
vim.keymap.set("n", "<C-u>", "<C-u> M", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d> M", { silent = true })

-- Copy buffers path to clipboard
vim.keymap.set("n", "cp", ":let @+ = expand('%')<CR>", { silent = true })
