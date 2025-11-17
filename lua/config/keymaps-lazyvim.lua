-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Get Neovim's config home directory
-- local config_dir = vim.fn.stdpath("config") .. "/lua/config/"

-- Lazyvim specific keymaps

local map = vim.keymap.set

-- Restore some default mappings
-- pcall(vim.keymap.del, "n", "H")
-- pcall(vim.keymap.del, "n", "L")
pcall(vim.keymap.del, "n", "s")
pcall(vim.keymap.del, "n", "S")

-- By defeault nvim-lspconfig uses this. Disabled in it's settings.
map({'n', 'v'}, "gy", '"+y',  { desc = "Yank to clipboard" })
