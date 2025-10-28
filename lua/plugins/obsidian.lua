
-- if true then return {} end

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
  }
}
