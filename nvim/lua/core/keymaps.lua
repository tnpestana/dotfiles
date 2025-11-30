vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2

-- spaces for tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Show number
vim.o.number = true

-- Diagnostic
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Forward search
vim.keymap.set("n", "<leader>s", "/", { noremap = true })

-- Backward search
vim.keymap.set("n", "<leader>r", "?", { noremap = true })

-- Neo Tree
vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus<CR>", { desc = "NeoTree focus" })
