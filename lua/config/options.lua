-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local g = vim.g

-- No format on save.
g.autoformat = false

-- g.maplocalleader = '\'

-- Use Linux primary, selection clipboard by default. Problem with LazyVim's
-- default "unnamedplus", is that it pollutes the main clipboard history with
-- unnecessary clutter.
opt.clipboard = "unnamed"

-- comma-separated list of screen columns that are highlighted with
-- ColorColumn hl-ColorColumn. Useful to align text.
opt.colorcolumn = "80"

-- When on, the ":substitute" flag 'g' is default on.  This means that
-- all matches in a line are substituted instead of one.
opt.gdefault = true

opt.guifont = { "FiraCode Nerd Font", ":h12" }

-- This is a comma-separated list of words, which specifies when to start
-- Select mode instead of Visual mode, when a selection is started.
-- Possible values:
--    mouse when using the mouse
--    key   when using shifted special keys
--    cmd   when using "v", "V" or CTRL-V
opt.selectmode = "key"

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 7

-- Spellcheck
opt.spell = false

-- When on, the title of the window will be set to the value of
-- 'titlestring' (if it is not empty), or to: filename [+=-] (path) - NVIM
opt.title = true

-- Cursor can go paste last character and after block
opt.virtualedit:append("block,onemore")

-- Optionally you can use an autocommand to automatically open floating diagnostics for LSP errors
-- vim.cmd([[
--   autocmd CursorHold * lua vim.diagnostic.open_float({scope="line"})
-- ]])

-- vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = '#73c991' })


-- GUI ------------------------------------------

if g.neovide then
  -- Make Neovide animations a lot faster and less distracting.
  g.neovide_cursor_animation_length = 0.03
  g.neovide_cursor_trail_size = 0.08
end
