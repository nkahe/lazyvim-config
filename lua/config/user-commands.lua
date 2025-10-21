
-- User commands for command mode

-- Accept some typos.
vim.keymap.set("ca", "W", "w")
vim.keymap.set("ca", "Wq", "wq")
vim.keymap.set("ca", "WQ", "wq")

local create_cmd = vim.api.nvim_create_user_command

-- Change cwd to match current buffer's directory
create_cmd('Cdb', function()
  vim.cmd('cd ' .. vim.fn.expand('%:p:h'))
  vim.cmd('pwd')
end, { desc = "Change cwd to match current buffer's directory" })

-- Trim trailing whitespace from the buffer
create_cmd('Trim', function()
  local save_cursor = vim.fn.getpos(".")
  -- Save view state for visual mode users
  local save_view = vim.fn.winsaveview()
  -- Perform the substitution to trim trailing whitespace
  vim.cmd([[keeppatterns %s/\v\s+$//e]])
  -- Restore cursor position and view state
  vim.fn.setpos(".", save_cursor)
  vim.fn.winrestview(save_view)
end, { desc = "Trim trailing whitespace from the buffer" })

-- Source keymaps.lua and options.lua, and show a notification
create_cmd("Reload", function()
  local success_keymaps, success_options, success_autocmds  = false, false, false
  local basepath = vim.fn.stdpath("config") .. "/lua/config"

  local keymaps_path = basepath .. "/keymaps.lua"
  success_keymaps = pcall(dofile, keymaps_path)

  local options_path = basepath .. "/options.lua"
  success_options = pcall(dofile, options_path)

  local autocmds_path = basepath .. "/autocmds.lua"
  success_autocmds = pcall(dofile, autocmds_path)

  -- Check results and display a message
  if success_keymaps and success_options and success_autocmds then
    vim.notify("Sourced keymaps.lua, options.lua, autocmds.lua", vim.log.levels.INFO)
  elseif not success_keymaps then
    vim.notify("Failed to source keymaps.lua", vim.log.levels.ERROR)
  elseif not success_options then
    vim.notify("Failed to source options.lua", vim.log.levels.ERROR)
  elseif not success_autocmds then
    vim.notify("Failed to source autocmds.lua", vim.log.levels.ERROR)
  end
end, { desc = "Reload settings" })

