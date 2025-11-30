# Tmux Cheatsheet

## Session Management

### Full Commands
```bash
tmux                          # Start new session
tmux new -s mysession         # Start named session
tmux ls                       # List sessions
tmux attach -t mysession      # Attach to session
tmux kill-session -t mysession # Kill session
tmux kill-server              # Kill all sessions
```

### Zsh Shortcuts (from your .zshrc)
```bash
t                    # Same as 'tmux'
ts mysession         # Start new named session
tl                   # List sessions
ta mysession         # Smart attach (switches if inside tmux, attaches if outside)
tad mysession        # Attach and detach others
tkss mysession       # Kill specific session
tksv                 # Kill tmux server (all sessions)
```

## Inside tmux (prefix = Ctrl+S in your config)
Press `Ctrl+S` then release, then press the command key.

### Sessions
- `Ctrl+S` then `d` - Detach from session (keeps running in background)
- `Ctrl+S` then `s` - List/switch sessions

### Windows (like tabs)
- `Ctrl+S` then `c` - Create new window
- `Ctrl+S` then `n` - Next window
- `Ctrl+S` then `p` - Previous window
- `Ctrl+S` then `0-9` - Switch to window number
- `Ctrl+S` then `,` - Rename window (names persist, won't change automatically)
- `Ctrl+S` then `<` - Move window left (repeatable)
- `Ctrl+S` then `>` - Move window right (repeatable)
- `Ctrl+S` then `X` - Kill window

### Panes (split screen)
- `Ctrl+S` then `v` - Split vertical (side-by-side)
- `Ctrl+S` then `s` - Split horizontal (top-bottom)
- `Ctrl+S` then `x` - Kill pane

**Navigate panes (vim-style):**
- `Ctrl+S` then `h` - Move to left pane
- `Ctrl+S` then `j` - Move to bottom pane
- `Ctrl+S` then `k` - Move to top pane
- `Ctrl+S` then `l` - Move to right pane

**Resize panes (vim-style, repeatable):**
- `Ctrl+S` then `H` - Resize left
- `Ctrl+S` then `J` - Resize down
- `Ctrl+S` then `K` - Resize up
- `Ctrl+S` then `L` - Resize right

**Swap panes:**
- `Ctrl+S` then `u` - Swap with previous pane
- `Ctrl+S` then `d` - Swap with next pane

### Other
- `Ctrl+S` then `r` - Reload tmux config
- `Ctrl+S` then `?` - List all key bindings
- `Ctrl+S` then `[` - Enter scroll mode (use arrow keys, press `q` to exit)

## Mouse Support
Your config enables mouse support, so you can:
- Click panes to switch between them
- Click and drag pane borders to resize
- Scroll with mouse wheel
- Click window tabs to switch windows

## Using Windows for Project Organization

Your config is optimized for using **windows** (not sessions) for different projects:
- Each window can represent a different project or task
- Window names persist and won't change automatically
- All windows are visible in the status bar with rounded tabs
- Easy to switch between projects with `Ctrl+S` then `0-9` or by clicking

**Example setup:**
```
Window 0: dotfiles    → Configuration files
Window 1: backend     → API development
Window 2: frontend    → UI work
Window 3: scripts     → General terminal
```

**Tip:** Name your windows immediately after creating them with `Ctrl+S` then `,`

## Theme & Status Bar

Your tmux uses the **Catppuccin Frappe** theme (matching your Ghostty terminal):
- Rounded window tabs in the status bar
- Status bar shows: application, session name, user, host, date/time
- True color support for better appearance
- Window names are always displayed (not process names)

## Example Workflow
```bash
# Start a named session
tmux new -s work

# Create windows for different projects
# Ctrl+S, c  (create new window)
# Ctrl+S, ,  (rename to "backend")

# Create another window
# Ctrl+S, c
# Ctrl+S, ,  (rename to "frontend")

# Inside each window: split into panes
# Ctrl+S, v  (split vertically)
# Ctrl+S, s  (split horizontally)

# Navigate between windows
# Ctrl+S, 0-9  (jump to window number)
# Or click the window tabs

# Navigate between panes with vim keys
# Ctrl+S, h/j/k/l

# Reorder windows as needed
# Ctrl+S, <  or  >

# Detach (keeps everything running)
# Ctrl+S, d

# Later, reattach
tmux attach -t work
```
