
if true then return {} end

vim.keymap.set('n', "<LocalLeader>r", "<cmd>Neotree reveal_force_cwd<CR>",
  { desc = "Reveal in Neotree" })

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    sources = { "filesystem", "buffers", "git_status" },
    source_selector = {
      winbar = true,
      content_layout = "center",
    },

    default_component_configs = {
      symlink_target = {
        enabled = true,
      },
    },
    filesystem = {
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false, -- Optional: Determines whether to close other directories when following
        },
        filtered_items = {
            hide_dotfiles = false, -- Adjust other filtering options as needed
            hide_by_name = { ".git", "node_modules" }, -- Example filters
        },
    },
    search_command = "fd -L", -- Follow symlinks while searching
    hijack_netrw_behavior = "open_default", -- Relevant for symlink resolution
  }
}


