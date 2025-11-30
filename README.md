# Dotfiles

Personal configuration files for ghostty, nvim, and tmux.

## Structure

```
~/dotfiles/
├── ghostty/          # Ghostty terminal configuration
│   └── config        # Main config file
├── nvim/             # Neovim configuration
│   ├── init.lua      # Entry point
│   └── lua/          # Lua config modules
├── tmux/             # Tmux configuration
│   ├── tmux.conf     # Main config file
│   └── plugins/      # TPM plugins (gitignored)
└── .gitignore        # Ignore plugin directories
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
   ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
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

### Updating

Pull the latest changes:
```bash
cd ~/dotfiles
git pull
```

For plugin updates, use the respective plugin managers.

## Tools

### Neovim
- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)
- Plugins are defined in `nvim/lua/core/plugins.lua`
- Plugin data stored in `~/.local/share/nvim/lazy/` (gitignored)

### Tmux
- Plugin manager: [TPM](https://github.com/tmux-plugins/tpm)
- Plugins defined in `tmux/tmux.conf`
- Plugins installed in `tmux/plugins/` (gitignored)

### Ghostty
- Configuration: `ghostty/config`
- Customize terminal appearance, fonts, themes, etc.

## Notes

- Plugin directories are gitignored to keep the repo clean
- Each tool's plugins will need to be installed on a fresh setup
- Symlinks allow tools to find configs in their expected locations
