# Neovim Reference

**Leader**: `Space`

## Core Keybindings

### Navigation & Search
- `<leader>ff` - Find files
- `<leader>fg` - Live grep (search in files)
- `<leader>fb` - List buffers
- `<leader>fh` - Search help
- `<Esc>` - Clear search highlights

### File Explorer (Oil)
- `<leader>o` - Open Oil
- `-` - Parent directory
- `<CR>` - Open file/directory
- `g.` - Toggle hidden files

### LSP (when attached)
- `gd` - Go to definition
- `gr` - List references
- `K` - Hover documentation
- `<leader>rn` - Rename
- `<leader>ca` - Code actions
- `<leader>f` - Format
- `[d` / `]d` - Previous/next diagnostic

### Git (Gitsigns)
- `<leader>gp` - Preview hunk
- `<leader>gb` - Toggle line blame

## Plugins
- **lazy.nvim**: Plugin manager (`:Lazy`)
- **Telescope**: Fuzzy finder
- **LSP**: pyright, lua_ls, jsonls
- **Oil**: Buffer-based file explorer
- **Catppuccin Macchiato**: Theme

## Settings
- Tab width: 2 spaces
- Clipboard: Synced with system
- Auto-highlights yanked text
- Inactive splits dimmed
