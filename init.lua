-- bootstrap lazy.nvim, LazyVim and your plugins

-- Define config table to be able to pass data between scripts
_G.Config = {}

-- User in autocmd to set window title prefix before filename.
_G.Config.windowtitle = 'Lazyvim'

vim.opt.guifont = { "FiraCode Nerd Font", ":h10" }

-- base46 themes: put this in your main init.lua file ( before lazy setup )
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

require("config.lazy")

-- (method 2, for non lazyloaders) to load all highlights at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end

-- Other custom config are sourced lazily from this file.
require("config.autocmds-lazyvim")
