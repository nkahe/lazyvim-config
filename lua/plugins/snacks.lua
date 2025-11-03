
return {
  "folke/snacks.nvim",
  opts = {
    notifier = {
      enabled = true,
      -- Timeout for notifications longer so can actually read them.
      timeout = 6000,
    },
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Load latest session",
            action = function()
              local MiniSessions = require("mini.sessions")
              local latest = MiniSessions.get_latest()
              if latest then
                MiniSessions.read(latest)
              else
                vim.notify("No sessions found", vim.log.levels.WARN)
              end
            end,
          },
          -- Defaults
          -- { icon = " ", key = "s", desc = "Restore last session", action = function() require("persistence").load({ last = true }) end },
          -- { icon = " ", key = "S", desc = "Select session", action = function() require("persistence").select() end },
          { icon = " ", key = "S", desc = "Select session", action = function() require("mini.sessions").select("read") end, },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },

    picker = {
      enabled = true,
      layout = {
        preset = "ivy",
        preview = false
      },
      sources = {
        files = {
          hidden = true
        },
        explorer = {
          diagnostics = false
        },
      },
      win = {
        preview = {
          wo = {
            wrap = true,
            linebreak = true,
            list = false
          }
        }
      }
    }

  },
}
