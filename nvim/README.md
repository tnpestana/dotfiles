# Neovim Configuration

Personal Neovim config with LSP, fuzzy finding, and file management.

## Features

- **LSP Support** - Python, JSON, Lua language servers via Mason
- **File Explorer** - Neo-tree with git status
- **Fuzzy Finder** - Telescope with live grep
- **Status Line** - Lualine with diagnostics
- **Theme** - Catppuccin colorscheme

## Prerequisites

- Neovim 0.9+
- Git, ripgrep, fd
- Nerd Font (for icons)

## Installation

```sh
git clone <your-repo-url> ~/.config/nvim
```

Start Neovim - plugins install automatically.

## LSP Servers

Automatically installed via Mason:
- **pyright** - Python
- **jsonls** - JSON  
- **lua_ls** - Lua (configured via `.luarc.json`)
