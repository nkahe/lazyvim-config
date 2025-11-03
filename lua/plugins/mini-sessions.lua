return {
  "nvim-mini/mini.sessions",
  version = false,
  config = function()
    require("mini.sessions").setup()

    -- helper for <leader> mappings
    local function nmap_leader(lhs, rhs, desc)
      vim.keymap.set("n", "<leader>" .. lhs, rhs, { desc = desc })
    end

    -- define <leader>q mappings
    local session_new = 'MiniSessions.write(vim.fn.input("New session name: "))'
    nmap_leader('qd', '<Cmd>lua MiniSessions.select("delete")<CR>', 'Delete session')
    nmap_leader('qn', '<Cmd>lua ' .. session_new .. '<CR>',         'New session')
    nmap_leader('qr', '<Cmd>lua MiniSessions.select("read")<CR>',   'Read session')
    nmap_leader('qw', '<Cmd>lua MiniSessions.write()<CR>',          'Write current session')
  end,
}
