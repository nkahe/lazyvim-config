
return {
  -- EinfachToll/DidYouMean: Vim plugin which asks for the right file to open
  -- https://github.com/EinfachToll/DidYouMean
  {
    "EinfachToll/DidYouMean"
  },

  -- bagohart/Vim-Insert-Single-Character
  -- https://github.com/bagohart/vim-insert-append-single-character
  {
    "bagohart/vim-insert-append-single-character",
    -- For nordic and german keyboard layouts.
    keys = {
      { "ä", "<Plug>(ISC-insert-at-cursor)", mode = "n", desc = "Insert character before cursor" },
      { "Ä", "<Plug>(ISC-append-at-cursor)", mode = "n", desc = "Insert character after cursor" },
    },
    vscode = true
  },

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },

  -- lambdalisue/vim-suda: 🥪 An alternative sudo.vim for Vim and Neovim,
  -- limited support sudo in Windows - https://github.com/lambdalisue/vim-suda
  {
    'lambdalisue/vim-suda'
  },

  -- rickhowe/wrapwidth: Wraps long lines virtually at a specific column
  -- https://github.com/rickhowe/wrapwidth
  {
    "rickhowe/wrapwidth"
  }
}
