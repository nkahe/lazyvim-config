

-- if true then return {} end

-- Mofiqul/vscode.nvim: Neovim/Vim color scheme inspired by Dark+ and Light+
-- theme in Visual Studio Code - https://github.com/Mofiqul/vscode.nvim

return {
    "Mofiqul/vscode.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme vscode]])
    end,
    opts = {
      -- NOTE: mini.hipatterns doesn't hilight these but still works.
      color_overrides = {

        -- Normal & signcolumn bg
        vscBack = '#1b1b1b',

        -- Cursorline, vertical ColorColumn
        vscCursorDarkDark = "#1f1f1f",

        -- Floating windowws, terminals etc.
        vscPopupBack = '#262626',
      },

      group_overrides = {
        RenderMarkdownH1Bg = { bg = '#22263a' },
        RenderMarkdownH2Bg = { bg = '#2c272b' },
        RenderMarkdownH3Bg = { bg = '#242b2b' },
        RenderMarkdownH4Bg = { bg = '#172830' },

        -- By default Snacks Explorer tree and directory names are too dark.
        -- Make them same as other background.
        SnacksPickerTree = {
          bg = '#252525',
        },
        SnacksPickerDirectory = {
          bg ='#252525'
        },
        SnacksPickerCol = {
          bg ='#252525'
        },

      -- Define a highlight group for terminal background. These are used
        -- in autocmds.lua
      TermBackground = { bg = "#010b0d" },
      TermCursorLine = { bg = "#010b0d" },
      }
    }
}

    -- opts = function()
      -- local c = require("").get_colors()
      -- require("vscode").setup({
      --   transparent = true,
      --   italic_comments = true,
      --   underline_links = true,
      --   disable_nvimtree_bg = true,
      --   group_overrides = {
      --   },
      -- })


