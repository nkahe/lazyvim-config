return {
  {
  "neovim/nvim-lspconfig",
  opts =  {
    diagnostics = {
      underline = true,
      update_in_insert = false,
        -- CHANGED: Disable virtual text
      virtual_text = false,
          -- {
        -- spacing = 4,
        -- source = "if_many",
        -- prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      -- },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
        },
      },
    },

    -- map({'n'}, "<Leader>ct", function() Snacks.picker.lsp_type_definitions() end, { desc =  "Goto T[y]pe Definition" })
  servers = {
    ["*"] = {
      keys = {
        -- Disable. Used for copy to clipboard.
        { "gy", false },
        -- Use this instead.
        { "<leader>ct", function() Snacks.picker.lsp_type_definitions() end, mode = { "n" }, desc =  "Goto T[y]pe Definition" },
      },
    },
  },
  },
},

  {
    "mason-org/mason.nvim",
    opts = {
      install_root_dir = vim.fn.expand("~/.local/share/nvim/mason"),
    },
  }

}


