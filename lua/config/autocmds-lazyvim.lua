
-- LazyVim specific autocommands. This is sourced from init.lua.

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local filename = vim.fn.expand("%:t") ~= "" and vim.fn.expand("%:t") or "[No Name]"
    vim.o.titlestring = "Lazyvim - " .. filename
  end,
})

-- Autosource --------------------------------------------

-- Watches for saves specifically in the `lua/config/keymaps.lua` and `lua/config/options.lua` files
local config_path = vim.fn.stdpath("config") .. "/lua/config/"

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { config_path .. "keymaps.lua", config_path .. "options.lua" },
  callback = function(args)
    vim.cmd("source " .. args.file)
    print("Sourced " .. args.file)
  end,
})

local function get_terminal_name()
  if vim.g.neovide then
    terminalName = "Neovide"
  end
  return terminalName
end

-- Source additional config files.
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.keymaps-lazyvim")
    require("config.user-commands")
  end,
})
