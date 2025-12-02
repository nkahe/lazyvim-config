-- bootstrap lazy.nvim, LazyVim and your plugins

-- Define config table to be able to pass data between scripts
_G.Config = {}

-- User in autocmd to set window title prefix before filename.
_G.Config.windowtitle = 'Lazyvim'

vim.opt.guifont = { "FiraCode Nerd Font", ":h10" }
require("config.lazy")

-- Other custom config are sourced lazily from this file.
require("config.autocmds-lazyvim")
