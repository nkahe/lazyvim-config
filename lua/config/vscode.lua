
-- This file is sourced only if run in embedded VSCode instance.

-- vim.keymap.set({ 'n', 'x' }, '<Space>', function()
--     vim.fn.VSCodeNotify('whichkey.show')
--   end, { silent = true, desc = "Show WhichKey" })

vim.keymap.set('n', '<leader><leader>', function()
    vim.fn.VSCodeNotify('workbench.action.quickOpen')
  end, { desc = 'QuickOpen' })

vim.keymap.set({ 'n', 'x' }, '<Space>e', function()
    vim.fn.VSCodeNotify('workbench.action.toggleSidebarVisibility')
  end, { silent = true, desc = "Toggle Sidebar Visibility" })

vim.keymap.set({ 'n', 'x' }, '<Space>fr', function()
    vim.fn.VSCodeNotify('workbench.action.openRecent')
  end, { silent = true, desc = "Recent files" })

vim.keymap.set({ 'n', 'x' }, '<Space>fn', function()
    vim.fn.VSCodeNotify('welcome.showNewFileEntries')
  end, { silent = true, desc = "New file" })
