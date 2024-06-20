-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- x键不复制内容
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })

-- split window
vim.keymap.set("n", "<leader>wh", "<cmd>split<cr>", { desc = "Split Window Below" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split Window Right" })

-- 数值增加 数值减少
vim.keymap.set("n", "+", "<C-a>", { silent = true, noremap = true })
vim.keymap.set("n", "-", "<C-x>", { silent = true, noremap = true })

vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")
vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd>KittyNavigateLeft<cr>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<cmd>KittyNavigateDown<cr>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd>KittyNavigateUp<cr>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<cmd>KittyNavigateRight<cr>")
