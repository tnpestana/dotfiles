# Tmux Reference

**Prefix**: `Ctrl+S`

## Session Management

### Shell Aliases
- `t` / `tmux` - Smart attach (creates "main" if none exist)
- `ts <name>` - New session
- `ta <name>` - Attach/switch
- `tl` - List sessions
- `tkss <name>` - Kill session

### Inside tmux
- `prefix d` - Detach
- `prefix s` - List/switch sessions

## Windows & Panes

### Windows
- `prefix c` - New window
- `prefix ,` - Rename window
- `prefix n/p` - Next/previous
- `prefix 0-9` - Switch to window
- `prefix </>`- Move window left/right
- `prefix X` - Kill window

### Panes
- `prefix v` - Split vertical
- `prefix s` - Split horizontal
- `prefix h/j/k/l` - Navigate (vim-style)
- `prefix H/J/K/L` - Resize (repeatable)
- `prefix a` - Apply 3-pane layout
- `prefix x` - Kill pane

## Features
- **Mouse**: Enabled (click, drag, scroll)
- **Persistence**: Auto-saves every 15 min
- **Theme**: Catppuccin Macchiato
- **Config reload**: `prefix r`
