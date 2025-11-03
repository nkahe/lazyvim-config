
return {
  "folke/noice.nvim",
    enabled = false,
  opts = {
    cmdline = {
      view = "cmdline_popup", -- Use the popup view
    },
    views = {
      cmdline_popup = {
        position = {
          row = "90%", -- Position near the bottom (90% of screen height)
          col = "50%", -- Centered horizontally
        },
        size = {
          width = 70,  -- Width of the popup
          height = "auto", -- Adjust height automatically
        },
        border = {
          style = "rounded", -- Optional: "none", "single", "double", "rounded"
          padding = { 0, 1 },
        },
      },
    },
  },
}

