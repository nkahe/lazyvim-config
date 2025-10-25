
-- NOTE: spell check is defined in autocmds.lua to work with LazyVim.

-- vim.opt.textwidth = 90     -- Set the soft wrap column
vim.opt.colorcolumn = "90"
vim.cmd('Wrapwidth 90')

vim.cmd('setlocal nospell')

-- Disable diagnostics by default.
vim.diagnostic.enable(false)
