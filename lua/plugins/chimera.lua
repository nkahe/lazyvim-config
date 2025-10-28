-- Tris / nvim-chimera · GitLab - https://gitlab.com/Biggybi/nvim-chimera
-- An easy way to create a commented version of a set of lines.

if true then return {} end

return {
  "https://gitlab.com/Biggybi/nvim-chimera.git",
  dependencies = {
    -- pick one or none
    -- "tpope/vim-commentary"
    -- "numToStr/Comment.nvim",
  },
  opts = {
    -- set to 'false' to disable all
    keymaps = {
      normal_line = "yc",
      visual_line = "gyc",
      normal_block = "yC",
      visual_block = "gyC",
    },
  },
}
