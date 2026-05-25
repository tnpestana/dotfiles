# Dotfiles

Personal configuration files for ghostty, nvim, tmux, and starship.

## Structure

```
~/dotfiles/
├── docs/                       # Concise reference documentation
│   ├── nvim.md                 # Neovim keybindings & plugins
│   ├── tmux.md                 # Tmux commands & shortcuts
│   ├── ghostty.md              # Ghostty keybindings
│   ├── zsh.md                  # Shell enhancements & config
│   └── git.md                  # Git aliases
├── ghostty/                    # Ghostty terminal configuration
│   └── config                  # Main config file
├── nvim/                       # Neovim configuration
│   ├── init.lua                # Entry point
│   └── lua/                    # Lua config modules
│       ├── core/               # Core configuration
│       │   ├── keymaps.lua     # Centralized keybindings
│       │   ├── settings.lua    # Editor settings
│       │   └── plugins.lua     # Plugin manager setup
│       └── plugins/            # Plugin configurations
├── tmux/                       # Tmux configuration
│   ├── tmux.conf               # Main config file
│   └── plugins/                # TPM plugins (gitignored)
├── zsh/                        # Zsh configuration
│   └── zshrc                   # Main config (shared across machines)
├── starship/                   # Starship prompt configuration
│   └── starship.toml           # Minimal config (disables gcloud, username, hostname)
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
- **Integrate** with your existing `.zshrc` by adding a source line (backs up original)
- Create `~/.zshrc.dotfiles` symlink to the dotfiles shared config
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
   ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
   ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
   ln -s ~/dotfiles/zsh/zshrc ~/.zshrc.dotfiles
   ```

3. Add this line to your `~/.zshrc`:
   ```bash
   source ~/.zshrc.dotfiles
   ```

4. Install plugins:

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

### Updating

Pull the latest changes:
```bash
cd ~/dotfiles
git pull
```

For plugin updates, use the respective plugin managers.

## Documentation

Concise reference docs in `docs/` folder:

- **[nvim.md](docs/nvim.md)** - Neovim keybindings & plugins
- **[tmux.md](docs/tmux.md)** - Tmux commands & shortcuts
- **[ghostty.md](docs/ghostty.md)** - Ghostty keybindings
- **[git.md](docs/git.md)** - Git aliases
- **[zsh.md](docs/zsh.md)** - Shell enhancements & config

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
- Configuration: `zsh/zshrc` (shared, installed as `~/.zshrc.dotfiles`)
- Your original `~/.zshrc` stays untouched — dotfiles are sourced at the top
- Your config below the dotfiles block can override any dotfiles defaults
- Shell enhancements: Starship prompt, Zoxide navigation
- Tmux session management aliases and smart attach function
- Comprehensive git aliases (40+ shortcuts)
- See [zsh.md](docs/zsh.md) and [git.md](docs/git.md) for aliases

## Notes

- Plugin directories are gitignored to keep the repo clean
- Each tool's plugins will need to be installed on a fresh setup
- Symlinks allow tools to find configs in their expected locations
