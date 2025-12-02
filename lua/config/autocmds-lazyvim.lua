
-- LazyVim specific autocommands. This is sourced from init.lua.

pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_wrap_spell")

-- Helper to set autogroup with prefix.
local function augroup(name)
  return vim.api.nvim_create_augroup("Custom_" .. name, { clear = true })
end

-- Source additional config files.
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = augroup("source_custom_configs"),
  callback = function()
    require("config.keymaps-lazyvim")
    require("config.user-commands")

    if vim.g.vscode then
      require("config.vscode")
    else
      -- Start server so can open files in terminal with Neovim without having to open
      -- them in different process.
      if not vim.v.servername or vim.v.servername == '' then
        vim.fn.serverstart(string.format("/tmp/nvim.%d", vim.fn.getpid()))
      end

    end

  end,
})
