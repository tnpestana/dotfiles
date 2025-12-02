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
- **Shared**: `~/dotfiles/zshrc` (tracked in git)
- **Machine-specific**: `~/.zshrc.local` (not tracked)

Machine-specific file should contain:
- PATH additions (brew, nvm, gcloud, etc.)
- Tool configs
- Work-specific aliases

## Features
- Git aliases (see git.md)
- Prevents tmux window title auto-updates
- System clipboard integration
