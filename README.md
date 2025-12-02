# Dotfiles

Personal configuration files for ghostty, nvim, tmux, and starship.

## Structure

```
~/dotfiles/
├── ghostty/                    # Ghostty terminal configuration
│   ├── config                  # Main config file
│   └── ghostty-cheatsheet.md   # Keybindings and configuration reference
├── nvim/                       # Neovim configuration
│   ├── init.lua                # Entry point
│   ├── nvim-cheatsheet.md      # Keybindings and plugin reference
│   └── lua/                    # Lua config modules
│       ├── core/               # Core configuration
│       │   ├── keymaps.lua     # Centralized keybindings
│       │   ├── settings.lua    # Editor settings
│       │   └── plugins.lua     # Plugin manager setup
│       └── plugins/            # Plugin configurations
├── tmux/                       # Tmux configuration
│   ├── tmux.conf               # Main config file
│   ├── tmux-cheatsheet.md      # Keybindings and usage reference
│   ├── session-management-guide.md  # Advanced session management
│   └── plugins/                # TPM plugins (gitignored)
├── starship.toml               # Starship prompt configuration (minimal)
├── zshrc                       # Zsh configuration with aliases (shared)
├── zshrc.local.template        # Template for machine-specific zsh config
├── zsh-cheatsheet.md           # Shell aliases and tool reference
├── git-cheatsheet.md           # Git commands and aliases reference
├── install.sh                  # Automated installation script
└── .gitignore                  # Ignore plugin directories
```

## Installation

### Quick Install (Recommended)

1. Clone this repository:
   ```bash
   git clone https://github.com/tnpestana/dotfiles.git ~/dotfiles
   ```

2. Run the installation script:
   ```bash
   cd ~/dotfiles
   ./install.sh
   ```

The script will:
- Automatically backup any existing configs with timestamps
- Remove old symlinks
- Create new symlinks to the dotfiles repo
- Install TPM (Tmux Plugin Manager)
- Guide you through the remaining steps

### Manual Installation

If you prefer to install manually:

1. Clone this repository:
   ```bash
   git clone https://github.com/tnpestana/dotfiles.git ~/dotfiles
   ```

2. Create symlinks to config locations:
   ```bash
   ln -s ~/dotfiles/nvim ~/.config/nvim
   ln -s ~/dotfiles/tmux ~/.config/tmux
   ln -s ~/dotfiles/ghostty ~/.config/ghostty
   ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
   ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
   ln -s ~/dotfiles/zshrc ~/.zshrc
   ```

3. Install plugins:

   **Neovim** (lazy.nvim):
   ```bash
   nvim
   # Plugins will auto-install on first launch
   ```

   **Tmux** (TPM):
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
   # In tmux, press: prefix + I (capital i) to install plugins
   ```

### Machine-Specific Configuration

After installation, create `~/.zshrc.local` for machine-specific settings:

```bash
cp ~/dotfiles/zshrc.local.template ~/.zshrc.local
# Edit ~/.zshrc.local with your machine-specific configs
```

This file should contain:
- PATH additions specific to this machine
- Tool configs (nvm, pyenv, gcloud, etc.)
- Work-specific aliases and functions
- Any settings you don't want to share across machines

**Important**: `~/.zshrc.local` is not tracked in git and won't be overwritten.

### Updating

Pull the latest changes:
```bash
cd ~/dotfiles
git pull
```

For plugin updates, use the respective plugin managers.

## Cheatsheets

Comprehensive cheatsheets are included for quick reference:

- **[nvim-cheatsheet.md](nvim/nvim-cheatsheet.md)** - Neovim keybindings, LSP commands, Telescope, plugins, and Vim motions
- **[tmux-cheatsheet.md](tmux/tmux-cheatsheet.md)** - Tmux keybindings, session management, and window organization
- **[ghostty-cheatsheet.md](ghostty/ghostty-cheatsheet.md)** - Ghostty terminal keybindings and configuration options
- **[git-cheatsheet.md](git-cheatsheet.md)** - Git commands, shell aliases, and common workflows
- **[zsh-cheatsheet.md](zsh-cheatsheet.md)** - Shell aliases, Zoxide navigation, and tool integration

These cheatsheets document the current configuration and are designed to be portable and shareable.

## Tools

### Neovim
- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)
- Plugins are defined in `nvim/lua/core/plugins.lua`
- Keybindings are centralized in `nvim/lua/core/keymaps.lua`
- Plugin data stored in `~/.local/share/nvim/lazy/` (gitignored)

### Tmux
- Plugin manager: [TPM](https://github.com/tmux-plugins/tpm)
- Plugins: catppuccin theme, tmux-resurrect, tmux-continuum
- Plugins defined in `tmux/tmux.conf`
- Plugins installed in `tmux/plugins/` (gitignored)
- **Session persistence**: Auto-saves every 15 minutes, auto-restores on start
- **Predefined layouts**: `prefix + a` applies standard 3-pane working layout

### Ghostty
- Configuration: `ghostty/config`
- Customize terminal appearance, fonts, themes, etc.

### Zsh
- Configuration: `zshrc` (shared) + `~/.zshrc.local` (machine-specific)
- Shell enhancements: Starship prompt, Zoxide navigation
- Tmux session management aliases and smart attach function
- Comprehensive git aliases (40+ shortcuts)
- **Machine-specific configs**: The `zshrc` sources `~/.zshrc.local` for machine-specific settings (PATH additions, work configs, personal tools). This file is not tracked in git.
- See [zsh-cheatsheet.md](zsh-cheatsheet.md) and [git-cheatsheet.md](git-cheatsheet.md) for all aliases

## Notes

- Plugin directories are gitignored to keep the repo clean
- Each tool's plugins will need to be installed on a fresh setup
- Symlinks allow tools to find configs in their expected locations
