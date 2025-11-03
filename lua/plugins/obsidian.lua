
-- Obsidian.nvim https://github.com/obsidian-nvim/obsidian.nvim

return {
  "obsidian-nvim/obsidian.nvim",
  -- "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  -- lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre " .. vim.fn.expand("~/Nextcloud/notes/**/*.md"),
  --   "BufNewFile " .. vim.fn.expand("~/Nextcloud/notes/**/*.md"),
  -- },
  lazy = true,
  -- ft = "markdown",
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    -- "BufReadPre path/to/my-vault/*.md",
    -- "BufNewFile path/to/my-vault/*.md",
    "BufReadPre " .. vim.fn.expand "~" .. "/Nextcloud/notes/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Documents/local_notes/*.md"
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  init = function()
    -- Switch automatically to correct Obsidian workspace. (doesn't work if
    -- placed to config -function).

    -- Switch automatically to correct Obsidian workspace if .md file is part
    -- of known workspace. Track the last workspace to avoid redundant switches.
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

    local map = vim.keymap.set
    local function nmap(lhs, rhs, desc)
      map("n", lhs, rhs, { desc = desc, silent = true, noremap = true })
    end

    nmap("<Leader>sO", "<cmd>Obsidian search<CR>", "Obsidian search")
    nmap("<Leader>on", "<cmd>Obsidian new<CR>", "🆕 New note")
    nmap("<Leader>oo", "<cmd>Obsidian open<CR>", "Open in Obsidian app")
    nmap("<Leader>or", "<cmd>Obsidian rename<CR>", "Rename note")
    nmap("<Leader>os", "<cmd>Obsidian search<CR>", "Search note")
    nmap("<Leader>oq", "<cmd>Obsidian quick_switch<CR>", "Quick switch")
    nmap("<Leader>ow", "<cmd>Obsidian workspace<CR>", "Change workspace")
  end,
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "notes",
        path = "~/Nextcloud/notes",
      },
      {
        name = "local",
        path = "~/Documents/local_notes",
      },
    },
    "use_alias_only",
    checkbox = {
      order = { " ", "x"}
    },
    -- Both this plugin and render-markdown offer rendering of markdown files.
    -- It's not recommended to have both enabled so let's disable it.
    ui = {
      enable = false,
    }
  },
}
