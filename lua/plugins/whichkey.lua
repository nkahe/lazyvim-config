
-- if true then return {} end

return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    -- extend your existing spec
    opts.spec = vim.list_extend(opts.spec or {}, {
      {
        { "<Leader>N", group = "Notes (Obsidian)" },
        { "<Leader>t", group = "Terminal" },
        { "gr", group = "LSP" },
        -- 👇 global WhichKey
        { "<Leader>?", "<cmd>WhichKey<cr>", desc = "WhichKey (global)" },

        -- eAltGr mappings
        { "ð", '"_d', desc = "Delete without yanking" },
        { "Ð", '"_D', desc = "Delete line without yanking" },

        -- Restore default Neovim keys
        { "s", 's', desc = "Substitute character" },
        { "S", 'S', desc = "Substitute line" },

        -- Mapped to s/S by default in LazyVim.
        { "ö", mode = { "n", "x", "o" }, function() require("flash").jump() end,
          desc = "Flash" },
        { "Ö", mode = { "n", "o", "x" }, function() require("flash").treesitter() end,
          desc = "Flash Treesitter" },
      },
    })

    -- extend key replacements
    opts.replace = opts.replace or {}
    opts.replace.key = vim.list_extend(opts.replace.key or {}, {
      { "ð", "AltGr-d" },
      { "Ð", "AltGr-D" },
      -- { "š", "AltGr-s" },
    })

    return opts
  end,
}

-- in normal file could be done like this

-- local wk = require("which-key")
-- wk.add({
--   { "<Leader>i", group = "insert" },
-- })
