
-- Lazyvim specific keymaps

local map = vim.keymap.set

-- Restore some default mappings
pcall(vim.keymap.del, "n", "H")
pcall(vim.keymap.del, "n", "L")
pcall(vim.keymap.del, "n", "s")
pcall(vim.keymap.del, "n", "S")

-- By defeault nvim-lspconfig uses this. Disabled in it's settings.
map({'n', 'v'}, "gy", '"+y',  { desc = "Yank to clipboard" })
