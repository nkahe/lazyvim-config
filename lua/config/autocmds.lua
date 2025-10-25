-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Get Neovim's config home directory
-- local config_dir = vim.fn.stdpath("config") .. "/lua/config/"

-- These autocmds should be usable in different configs.

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- Disable relative numbers in Insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    command = "set norelativenumber",
})
-- Enable relative numbers when leaving Insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "set relativenumber",
})

-- Disable spell check in LazyVim.
pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_wrap_spell")


-- Set background color for terminal
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
      -- Set a black background only for terminal buffers. These are defined
      -- in colorscheme settings.
      vim.opt_local.winhighlight = "Normal:TermBackground,CursorLine:TermCursorLine"
      vim.cmd("startinsert")
    end,
})

-- Dynamic tab title change for Yakuake -------------------

-- Function to update the Yakuake terminal tab title
local function update_yakuake_title()
  -- Get the current buffer name (just the file name, not the full path)
  local buffer_name = vim.fn.expand('%:t')

  -- If no file is open, we just set the title to "Neovim" or similar
  if buffer_name == "" then
    buffer_name = "Neovim"
  end

  -- Set the Yakuake tab title using the session_id and buffer_name
  local qdbus_cmd = "qdbus org.kde.yakuake /yakuake/tabs setTabTitle %s \"%s\""
  vim.fn.system(string.format(qdbus_cmd, Session_id, buffer_name))
end

-- Get the current Yakuake session id using qdbus
Session_id = vim.fn.system("qdbus org.kde.yakuake /yakuake/sessions org.kde.yakuake.activeSessionId")

-- Trim any extra whitespace
Session_id = vim.fn.trim(Session_id)

-- If using Yakuake
if Session_id ~= "" then
  -- Autocmd to update Yakuake title on buffer changed
  vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {
    callback = update_yakuake_title
  })
end

-- Always open QuickFix windows below current window
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "[^l]*", -- Applies to Quickfix commands, not location list
  callback = function()
    vim.cmd("botright copen")
  end,
})

-- Open location list after search
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "lgrep",
  callback = function()
    vim.cmd("lopen") -- Open the location list
  end,
})

-- File formats -----------------------------------------

-- Obsidian.nvim - Switch automatically to correct Obsidian workspace

-- Track the last workspace to avoid redundant switches
local last_workspace = nil

local function get_workspace_for_path(filepath)
  local workspaces = {
    { name = "notes", path = vim.fn.expand("~/Nextcloud/notes") },
    { name = "local", path = vim.fn.expand("~/Documents/local_notes") },
  }

  for _, ws in ipairs(workspaces) do
    if filepath:find(vim.fn.escape(ws.path, ".*"), 1, true) == 1 then
      return ws.name
    end
  end
  return nil
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function()
    local filepath = vim.fn.expand("%:p")
    local workspace = get_workspace_for_path(filepath)
    if workspace and workspace ~= last_workspace then
      vim.cmd("ObsidianWorkspace " .. workspace)
      last_workspace = workspace
    end
  end,
})
