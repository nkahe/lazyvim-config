return {
  "dstein64/nvim-scrollview",
  enabled = false,
  opts = {
    excluded_filetypes = { "neotree" },
    current_only = true,
    base = "right",
    column = 1,
    signs_on_startup = { "all" },
    diagnostics_severities = { vim.diagnostic.severity.ERROR },
  },
  config = function(_, opts)
    require("scrollview").setup(opts)
    -- Scrollbar handle
    vim.cmd("highlight ScrollView ctermbg=23 guibg=#36363c")
  end,
}
