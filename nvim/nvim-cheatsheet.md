# Neovim Cheatsheet

## Leader Key
`Space` - Leader key for custom commands

## Basic Settings
- **Tab width**: 2 spaces (expandtab enabled)
- **Line numbers**: Enabled
- **Clipboard**: Synced with system clipboard (copy/paste works outside nvim)
- **Sign column**: Auto-adjusts (1-2 columns for diagnostics/git)

## Core Keybindings

### Search & Navigation
- `<leader>s` - Forward search (same as `/`)
- `<leader>r` - Backward search (same as `?`)
- `<Esc>` - Clear search highlights

### Diagnostics
- `<leader>e` - Show diagnostic error message (floating window)

### File Explorer (Oil.nvim)
Oil provides a buffer-based file explorer where you edit the filesystem like text:
- `-` - Open parent directory
- `<CR>` - Open file/directory
- `<C-s>` - Open in vertical split
- `<C-h>` - Open in horizontal split
- `<C-t>` - Open in new tab
- `<C-p>` - Preview file
- `<C-c>` - Close oil buffer
- `<C-l>` - Refresh
- `_` - Open current working directory
- `` ` `` - Change directory (cd)
- `~` - Change directory for tab
- `g?` - Show help
- `gs` - Change sort order
- `gx` - Open file with external program
- `g.` - Toggle hidden files
- `g\` - Toggle trash view

**Note**: Oil opens automatically when editing a directory (e.g., `nvim .`)

### NeoTree
- `<leader>o` - Focus NeoTree sidebar

## Fuzzy Finding (Telescope)

### File Operations
- `<leader>ff` - Find files in project
- `<leader>fg` - Live grep (search text in files)
- `<leader>fb` - List open buffers
- `<leader>fh` - Search help tags

## LSP (Language Server Protocol)

These keybindings work when an LSP server is attached to the buffer:

### Navigation
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - List all references
- `K` - Show hover documentation

### Code Actions
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions (fix issues, refactor, etc.)
- `<leader>f` - Format buffer

### Diagnostics Navigation
- `[d` - Jump to previous diagnostic
- `]d` - Jump to next diagnostic

### Configured LSP Servers
- **Python**: pyright
- **Lua**: lua_ls (with vim globals configured)
- **JSON**: jsonls

## Git Integration (Gitsigns)

- `<leader>gp` - Preview hunk inline (show git changes)
- `<leader>gb` - Toggle current line blame

## Plugin Manager (Lazy.nvim)

- `:Lazy` - Open Lazy.nvim UI to manage plugins
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install missing plugins and update existing ones

## Useful Vim Motions

### Basic Movement
- `h/j/k/l` - Left/Down/Up/Right
- `w` - Next word
- `b` - Previous word
- `e` - End of word
- `0` - Start of line
- `$` - End of line
- `gg` - Top of file
- `G` - Bottom of file

### Copy/Paste (Yank/Put)
- `yy` - Yank (copy) line
- `yap` - Yank paragraph (triggers highlight animation)
- `dd` - Delete (cut) line
- `p` - Put (paste) after cursor
- `P` - Put before cursor

**Note**: Yanked text is automatically copied to system clipboard

### Visual Mode
- `v` - Enter visual mode (character selection)
- `V` - Enter visual line mode
- `<C-v>` - Enter visual block mode

### Undo/Redo
- `u` - Undo
- `<C-r>` - Redo

### Search & Replace
- `/pattern` - Search forward
- `?pattern` - Search backward
- `n` - Next match
- `N` - Previous match
- `:%s/old/new/g` - Replace all occurrences in file
- `:%s/old/new/gc` - Replace all with confirmation

## Window Management

### Splits
- `:split` or `:sp` - Horizontal split
- `:vsplit` or `:vs` - Vertical split
- `<C-w>h/j/k/l` - Navigate between splits
- `<C-w>q` - Close current split
- `<C-w>=` - Make splits equal size

### Tabs
- `:tabnew` - New tab
- `gt` - Next tab
- `gT` - Previous tab
- `:tabclose` - Close tab

## Buffer Management

- `:bn` - Next buffer
- `:bp` - Previous buffer
- `:bd` - Delete buffer
- `<leader>fb` - List buffers (Telescope)

## Colorscheme

Uses **Catppuccin** theme (matching the Ghostty terminal)

## Quick Tips

1. **Auto-formatting**: Use `<leader>f` to format code when LSP is active
2. **Code completion**: LSP provides automatic completion suggestions
3. **File navigation**: Use `<leader>ff` to quickly jump to any file
4. **Search in files**: Use `<leader>fg` to search text across the project
5. **Yank highlighting**: When copying text, it briefly highlights for visual feedback
6. **Oil workflow**: Edit filesystem like a buffer - make changes, then save with `:w`
