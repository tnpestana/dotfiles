# Ghostty Terminal Cheatsheet

## About Ghostty
Ghostty is a fast, feature-rich terminal emulator written in Zig. It emphasizes performance and native feel on each platform.

## Configuration File
Location: `~/.config/ghostty/config`

## Current Configuration
The config is currently using default settings (all options commented out).

## Available Configuration Options

### Font Settings
```conf
font-family = "JetBrains Mono"
font-size = 13
```

### Theme
```conf
theme = dark
# Or use: light, or specific color schemes
```

### Window Appearance
```conf
window-padding-x = 4
window-padding-y = 4
```

### Shell Integration
```conf
shell-integration = true
```
Enables enhanced features like directory tracking, prompt marking, etc.

## Default Keybindings

### Tab Management
- `Cmd+T` - New tab
- `Cmd+W` - Close tab
- `Cmd+Shift+[` - Previous tab
- `Cmd+Shift+]` - Next tab
- `Cmd+1-9` - Switch to tab number

### Window Management
- `Cmd+N` - New window
- `Cmd+Shift+N` - New window (duplicate environment)
- `Cmd+Q` - Quit Ghostty

### Pane Management (Splits)
- `Cmd+D` - Split right (vertical split)
- `Cmd+Shift+D` - Split down (horizontal split)
- `Cmd+[` - Focus previous split
- `Cmd+]` - Focus next split
- `Cmd+Opt+Arrow` - Resize split

### Text & Selection
- `Cmd+C` - Copy
- `Cmd+V` - Paste
- `Cmd+F` - Find/Search
- `Cmd+K` - Clear screen
- `Cmd++` - Increase font size
- `Cmd+-` - Decrease font size
- `Cmd+0` - Reset font size

### Scrollback
- `Shift+Page Up/Down` - Scroll by page
- `Cmd+Up/Down` - Scroll to top/bottom
- Mouse scroll wheel - Scroll naturally

### Other
- `Cmd+,` - Open configuration file
- `Cmd+Shift+K` - Clear scrollback
- `Cmd+Option+I` - Inspector (debug tool)

## Shell Integration Features

When `shell-integration = true` is enabled:
- **Directory tracking**: Terminal knows current directory
- **Prompt marking**: Can jump between prompts
- **Command tracking**: Terminal knows when commands start/end
- **Auto-updates**: Title bar shows current directory

## Tips

1. **Performance**: Ghostty is built for speed - native GPU acceleration
2. **True color**: Full 24-bit color support works out of the box
3. **Ligatures**: Font ligatures are supported if the font has them
4. **Tmux integration**: Works great with tmux
5. **macOS native**: Ghostty feels native on macOS with proper keyboard shortcuts

## Useful Configuration Additions

### Enable Better Shell Integration
```conf
shell-integration = true
shell-integration-features = cursor,sudo,title
```

### Custom Font
```conf
font-family = "JetBrains Mono"
font-size = 13
font-feature = -calt  # Disable ligatures if desired
```

### Theme Matching
```conf
# To match the tmux Catppuccin Frappe theme
theme = catppuccin-frappe
```

### Window Appearance
```conf
window-padding-x = 8
window-padding-y = 8
window-decoration = true
macos-titlebar-style = tabs
```

### Cursor
```conf
cursor-style = block
cursor-style-blink = true
```

## Dotfiles Integration

This setup uses:
- **Ghostty** as terminal emulator
- **Tmux** for session/window management
- **Neovim** as editor
- **Zsh** as shell with Starship prompt

**Recommended workflow**:
1. Ghostty provides the terminal window
2. Tmux manages sessions and splits
3. Use Ghostty tabs sparingly (let tmux handle organization)
4. Keep Ghostty config minimal for performance

## Documentation
Full documentation: https://ghostty.org/docs
