-- Show line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Sign column: min 1, max 2 (always show 1, expand to 2 when needed)
vim.o.signcolumn = "auto:1-2"

-- Distance at which the cursor starts scrolling the file
vim.o.scrolloff = 16

-- Copy text to system clipboard (enable copy/paste outside of nvim)
vim.api.nvim_set_option_value("clipboard", "unnamed", {})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Auto-reload files changed externally
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  desc = 'Reload file when changed externally',
  group = vim.api.nvim_create_augroup('auto-reload', { clear = true }),
  callback = function()
    vim.cmd('checktime')
  end,
})

-- Auto-save files
local save_timer = nil
local function auto_save()
  vim.schedule(function()
    if
      vim.bo.modified
      and vim.bo.modifiable
      and not vim.bo.readonly
      and vim.fn.bufname('%') ~= ''
      and not vim.tbl_contains({ 'neo-tree', 'lazy', 'mason' }, vim.bo.filetype)
    then
      vim.cmd('silent! write')
    end
  end)
end

local auto_save_group = vim.api.nvim_create_augroup('auto-save', { clear = true })

vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'Auto-save on leaving insert mode',
  group = auto_save_group,
  callback = function()
    auto_save()
  end,
})

vim.api.nvim_create_autocmd('TextChanged', {
  desc = 'Auto-save on text change (debounced)',
  group = auto_save_group,
  callback = function()
    if save_timer then
      save_timer:stop()
    end
    save_timer = vim.defer_fn(auto_save, 200)
  end,
})
