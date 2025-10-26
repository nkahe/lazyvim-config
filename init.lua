-- bootstrap lazy.nvim, LazyVim and your plugins

vim.opt.guifont = { "FiraCode Nerd Font", ":h10" }
require("config.lazy")

require("config.autocmds-lazyvim")
