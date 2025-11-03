
-- TODO: Add lazy loading.

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    -- "nvim-telescope/telescope.nvim", -- optional
    -- "ibhagwan/fzf-lua",              -- optional
    -- "nvim-mini/mini.pick",           -- optional
    "folke/snacks.nvim",             -- optional
  },
  opts = {
    graph_style = "unicode", -- or "ascii", "none"
  },
  keys = {
    { "<Leader>gg", "<cmd>Neogit kind=floating<CR>",  mode = "n", desc = 'Toggle Neogit' },
  }
}
