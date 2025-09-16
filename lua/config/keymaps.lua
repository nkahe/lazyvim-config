-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Mappings that are only used when run embedded in VSCode.
if vim.g.vscode then
  require("config.vscode")
end

require("config.user-commands")

-- NOTE: For mappings "{ noremap = true }" is the default so no need to add that.

-- Registers ----------------------------------------------

-- Deleting without yanking

-- AltGr + d in nordic layout
map({'n', 'v'}, "ð", '"_d', { desc = "Delete without yanking" })
map({'n', 'v'}, "Ð", '"_d', { desc = "AltGr-D Delete to end of line without yanking" })
-- map("x", "<Leader>p", '"_dP', { desc = "Paste" })

map({'n', 'v'}, "<Del>", '"_x', { desc = "which_key_ignore" })
map({'n', 'v'}, "<BS>", '"_X', { desc = "which_key_ignore" })
map({'n', 'v'}, "x", '"_x', { desc = "which_key_ignore" })
map({'n', 'v'}, "X", '"_X', { desc = "which_key_ignore" })

-- Clipboard operators
map({'n', 'v'}, "cp", '"+p',  { desc = "Paste from clipboard" })
map({'n', 'v'}, "cP", '"+P',  { desc = "Paste from clipboard" })
map({'n', 'v'}, "cd", '"+d',  { desc = "Delete to clipboard" })
map({'n', 'v'}, "cD", '"+D',  { desc = "Delete end of line to clipboard" })
map({'n', 'v'}, "cy", '"+y',  { desc = "Yank to clipboard" })
map({'n', 'v'}, "cY", '"+Y',  { desc = "Yank end of line to clipboard" })

-- GUI style insert mappings
map({'n', 'v'}, '<S-Insert>', '"*P', { desc = "Paste selection" })
map('i', '<S-Insert>', '<C-o>"*P')
map('t', '<S-Insert>', '<C-\\><C-n>"*Pi')
map('c', '<S-Insert>', '<C-R>*')

map('x', '<C-Insert>', '"+y')

-- For GUI only is in section at end part of file.

-- Misc ---------------------------------------------------

-- Easier to type.
map("", "gh", '^', { desc = "To the first non-blank character of the line" })
map("", "gl", '$', { desc = "To the end of the line" })

-- Focus previous / next buffer
map({"n", "i"}, "<M-Right>", "<cmd>bnext<CR>", { silent = true })
map({"n", "i"}, "<M-Left>", "<cmd>bprevious<CR>", { silent = true })

-- Search word under cursor and change it. n to go next and . to repeat.
vim.keymap.set("n", "c*", "g*Ncgn", { noremap = true })

-- Help pages: <CR> to open links in addition to C-]
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<C-]>", { silent = true })
  end,
})

vim.keymap.set({'n', 'v'}, '<up>',    '<nop>')
vim.keymap.set({'n', 'v'}, '<down>',  '<nop>')
vim.keymap.set({'n', 'v'}, '<left>',  '<nop>')
vim.keymap.set({'n', 'v'}, '<right>', '<nop>')


-- Restore some default mappings ------------------------------

vim.schedule(function()
  -- Check if the mappings exist before deleting them
  if vim.fn.maparg("H", "n") ~= "" then
    vim.keymap.del("n", "H")
  end
  if vim.fn.maparg("L", "n") ~= "" then
    vim.keymap.del("n", "L")
  end
  if vim.fn.maparg("s", "n") ~= "" then
    vim.keymap.del("n", "s")
  end
  if vim.fn.maparg("S", "n") ~= "" then
    vim.keymap.del("n", "S")
  end
end)

--------------------------------------------------------------------------------
-- No VSCode compatible mappings after this
--------------------------------------------------------------------------------

if vim.g.vscode then
  return
end

vim.api.nvim_set_keymap(
  "v",
  "<LocalLeader>w",
  ":!fmt -w 80<CR>",
  { desc = "Wrap text to 80 char", noremap = true, silent = true }
)

-- Alt mappings can sometimes trigger with <esc> when using in terminal.

-- Moving lines
map("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-Up>",   "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-Up>",   "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-Down>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move down" })
vim.keymap.set("v", "<A-Up>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move up" })

map("n", "<M-l>", "<cmd>bnext<CR>", { silent = true })
map("n", "<M-h>", "<cmd>bprevious<CR>", { silent = true })

-- Add common shortcuts from GUI apps.
map("i", '<C-BS>', '<C-w>', { silent = true })
map("i", '<C-Del>', '<C-o>dw', { silent = true })

-- Function to capture keypress and show its mapping
function Capture_keypress()
  -- Wait for the next key press
  local key = vim.fn.getchar()

  -- Convert the key to a string representation
  local key_str = vim.fn.nr2char(key)

  -- Show what the key does
  vim.cmd('verbose map ' .. key_str)
end

-- Create a key mapping tuhat calls the function
vim.api.nvim_set_keymap('n', '<leader>k', ':lua Capture_keypress()<CR>',
  { desc = "Show mapping of key", noremap = true, silent = true })

-- Terminal ------------------------------------------------

map("n", "<Leader>tb", "<CMD>terminal<CR>", { desc = "Open in new buffer" })

-- Not all terminals support this.
map("t", "<C-`>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Tap C-\ twice to exit terminal mode
map('t', [[<C-\><C-\>]], [[<C-\><C-n>]], { silent = true })

vim.keymap.set("n", "<leader>tv", function()
  vim.cmd("vsplit | terminal")
end, { desc = "◨ Open in vertical split" })

-- WhichKey descriptions --------------------------------------

-- Neovim 0.11.0 added these but aren't yet included in Lazyvim.

-- lua/config/keymaps.lua
local wk = require("which-key")

wk.add({
  -- Normal mode LSP keys
  { "grn", vim.lsp.buf.rename, desc = "Rename" },
  { "grr", vim.lsp.buf.references, desc = "References" },
  { "gri", vim.lsp.buf.implementation, desc = "Implementation" },
  { "grt", vim.lsp.buf.type_definition, desc = "Type definition" },
  { "gO", vim.lsp.buf.document_symbol, desc = "Document Symbols" },
  { "gra", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } }
})

-- GUI --------------------------------------------------

-- Neovide
if vim.g.neovide then
  -- Clipboard commands similar to terminals.

  -- Paste main clipboard
  map({'n', 'v'}, '<C-S-v>', '"+P', { desc = "Paste from clipboard" })
  map('i', '<C-S-v>', '<C-o>"+P')
  map('t', '<C-S-v>', '<C-\\><C-n>"+Pi')
  vim.keymap.set('c', '<C-S-v>', '<C-R>+')

  -- Copy
  map('v', '<C-S-c>', '"+y')
end

-- Minor tweaks ------------------------------------------

-- Accidentally press on Shift+{arrow} to just move cursor.
map({ "x", "n" }, "<S-Down>", "j")
map({ "x", "n" }, "<S-Up>", "k")
map({ "x", "n" }, "<S-Right>", "l")
map({ "x", "n" }, "<S-Left>", "h")

