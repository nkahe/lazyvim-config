
-- if true then return {} end  -- Uncomment to disable

-- Switch automatically to correct Obsidian workspace. Doesn't work if included in
-- specs config -function.

-- Track the last workspace to avoid redundant switches

-- epwalsh/obsidian.nvim: Obsidian 🤝 Neovim https://github.com/epwalsh/obsidian.nvim
return {
  "obsidian-nvim/obsidian.nvim",
  -- "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  -- lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  init = function()
    -- Switch automatically to correct Obsidian workspace if .md file is part
    -- of known workspace.

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
  end,

  opts = {
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
  keys = {
    { "<Leader>sO", "<cmd>Obsidian search<CR>", mode = "n", desc = "Obsidian search" },
    { "<Leader>Nn", "<cmd>Obsidian new<CR>", mode = "n", desc = "🆕 New note" },
    { "<Leader>No", "<cmd>Obsidian open<CR>", mode = "n", desc = "Open in Obsidian app" },
    { "<Leader>Nr", "<cmd>Obsidian rename<CR>", mode = "n", desc = "Rename note" },
    { "<Leader>Ns", "<cmd>Obsidian search<CR>", mode = "n", desc = "Search note" },
    { "<Leader>Nq", "<cmd>Obsidian quick_switch<CR>", mode = "n", desc = "Quick switch" },
    { "<Leader>Nw", "<cmd>Obsidian workspace<CR>", mode = "n", desc = "Change workspace" },
  },

  -- config = function(_, opts)
  --   -- Switch automatically to correct Obsidian workspace
  --
  --   -- Track the last workspace to avoid redundant switches
  --   local last_workspace = nil
  --
  --   local function get_workspace_for_path(filepath)
  --     local workspaces = {
  --       { name = "notes", path = vim.fn.expand("~/Nextcloud/notes") },
  --       { name = "local", path = vim.fn.expand("~/Documents/local_notes") },
  --     }
  --
  --     for _, ws in ipairs(workspaces) do
  --       if filepath:find(vim.fn.escape(ws.path, ".*"), 1, true) == 1 then
  --         return ws.name
  --       end
  --     end
  --     return nil
  --   end
  --
  --   vim.api.nvim_create_autocmd("BufEnter", {
  --     pattern = "*.md",
  --     callback = function()
  --       local filepath = vim.fn.expand("%:p")
  --       local workspace = get_workspace_for_path(filepath)
  --       if workspace and workspace ~= last_workspace then
  --         vim.cmd("Obsidian workspace " .. workspace)
  --         last_workspace = workspace
  --       end
  --     end,
  --   })
  -- end -- config

}
