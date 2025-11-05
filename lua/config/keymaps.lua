-- Keymaps are automatically loaded on the VeryLazy event
-- In Lazyvim default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Mappings that are only used when run embedded in VSCode.
if vim.g.vscode then
  require("config.vscode")
end

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

map({'n', 'v'}, "gy", '"+y',  { desc = "Yank to clipboard" })
map({'n', 'v'}, "gp", '"+p',  { desc = "Paste from clipboard" })
map({'n', 'v'}, "gP", '"+P',  { desc = "Paste from clipboard" })
-- Mapping cY doesn't work.
map({'n'}, 'gY', '"+y$', { desc = "Yank end of line to clipboard" , noremap = false})

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

-- Avoid accidentally pressing these.
map({ "x", "n" }, "<S-Down>", "j")
map({ "x", "n" }, "<S-Up>", "k")
map({ "x", "n" }, "<S-Right>", "l")
map({ "x", "n" }, "<S-Left>", "h")

--------------------------------------------------------------------------------
-- No VSCode compatible mappings after this
--------------------------------------------------------------------------------

if vim.g.vscode then
  return
end

-- C-g to show full path of a file instead of truncated one.
vim.keymap.set("n", "<C-g>", function()
  local file = vim.fn.expand("%:p") or "[No Name]"
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  vim.api.nvim_echo({ { string.format("%s  line %d col %d", file, line, col), "Normal" } }, false, {})
end, { desc = "Show full file path and cursor position" })

vim.api.nvim_set_keymap( "v", "<LocalLeader>W", ":!fmt -w 80<CR>",
  { desc = "Wrap text to 80 char", noremap = true, silent = true }
)

-- Alt mappings can sometimes trigger with <esc> when using in terminal.

-- Moving lines also with arrow keys.
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

-- Function to capture keypress and show its mapping.
-- Note: Many Neovim defaults keys are not mappings.
-- TODO: Work with multi-press keymaps and not only single keys.
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

-- Not all terminals support this keybindings.
map("t", "<C-`>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Tap C-\ twice to exit terminal mode. Default C-\ C-n.
map('t', [[<C-\><C-\>]], [[<C-\><C-n>]], { silent = true })

vim.keymap.set("n", "<leader>tv", function()
  vim.cmd("vsplit | terminal")
end, { desc = "◨ Open in vertical split" })

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
