# Zsh Reference

## Shell Enhancements

### Starship
- Fast, customizable prompt
- Shows git status, directory, etc.
- Config: `~/.config/starship.toml`

### Zoxide
Smart directory jumping (learns frequently visited directories):
- `z <dir>` - Jump to directory
- `zi` - Interactive selection

### Tmux Aliases
- `t` / `tmux` - Smart attach/create
- `ts <name>` - New session
- `ta <name>` - Attach/switch
- `tl` - List sessions
- `tkss <name>` - Kill session
- `tksv` - Kill server

## Configuration
- **Your `.zshrc`**: Your original file — dotfiles are sourced at the top via `source ~/.zshrc.dotfiles`
- **Shared**: `~/dotfiles/zsh/zshrc` (installed as `~/.zshrc.dotfiles`, tracked in git)
- **Machine-specific**: Goes in your `~/.zshrc` below the dotfiles block to override defaults

## Features
- Git aliases (see git.md)
- Prevents tmux window title auto-updates
- System clipboard integration
