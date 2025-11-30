-- Sign column: min 1, max 2 (always show 1, expand to 2 when needed)
vim.opt.signcolumn = "auto:1-2"

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
