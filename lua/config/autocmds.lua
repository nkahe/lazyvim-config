-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Get Neovim's config home directory
-- local config_dir = vim.fn.stdpath("config") .. "/lua/config/"

-- Automatic file marks.
-- Converted from https://gist.github.com/romainl/3e0cb99343c72d04e9bc10f6d76ebbef
local automatic_marks = vim.api.nvim_create_augroup("AutomaticMarks", { clear = true })

local mappings = {
    { pattern = { "*.css", "*.scss" }, command = "normal! mC" },
    { pattern = { ".env*"  }, command = "normal! mE" },
    { pattern = { "*.html" }, command = "normal! mH" },
    { pattern = { "*.js", "*.ts" }, command = "normal! mJ" },
    { pattern = { "*.lua" }, command = "normal! mL" },
    { pattern = { "*.md"  }, command = "normal! mM" },
    { pattern = { "*.sh"  }, command = "normal! mS" },
    { pattern = { "*.vue" }, command = "normal! mV" },
    { pattern = { "*.yml", "*.yaml" }, command = "normal! mY" },
    { pattern = { "*.zsh" }, command = "normal! mZ" },
}

for _, map in ipairs(mappings) do
    vim.api.nvim_create_autocmd("BufLeave", {
        group = automatic_marks,
        pattern = map.pattern,
        command = map.command,
    })
end


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

-- Disable diagnostics for these type by default
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

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

-- Trim any extra whitespace from the session_id
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

-- Overwrite Lazy default. If this is put to ftplugin or set globally it doesn't work.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "txt" },
  callback = function()
    vim.opt_local.spell = false
  end,
})


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
      vim.cmd("Obsidian workspace " .. workspace)
      last_workspace = workspace
    end
  end,
})
