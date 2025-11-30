# Tmux Session Management Guide

## Understanding the Tmux Server

When you run `tmux` for the first time, it starts a **tmux server** (background process) that manages all your sessions. This server keeps running until:
- You explicitly kill it, OR
- All sessions are closed

```
Tmux Server (one per user)
 ├── Session: "work"
 ├── Session: "personal"
 └── Session: "myproject"
```

## Core Workflow

### The Basic Cycle
```bash
# 1. Start a session (creates server if needed)
ts myproject                 # or: tmux new -s myproject

# 2. Do your work inside tmux
# ... split panes, run commands, etc ...

# 3. Detach (Ctrl+S, d) - session keeps running!
# You're back to normal terminal, but tmux server is still running

# 4. Later, reattach
ta myproject                 # or: tmux attach -t myproject

# 5. When truly done, kill the session
tkss myproject               # or: tmux kill-session -t myproject
```

### Key Insight: Detach vs Kill
- **Detach** (`Ctrl+S, d`): Leave the session, but everything keeps running
  - All your programs continue
  - All your panes/windows remain
  - Think: "minimize to background"

- **Kill** (`tmux kill-session`): Permanently close the session
  - All programs in that session are terminated
  - Think: "close and quit"

## Windows vs Sessions: Choosing Your Workflow

### Use Windows When:
✅ You're working on multiple related projects or tasks
✅ You want everything visible in one status bar
✅ You frequently switch between contexts
✅ You prefer simplicity and quick access

**Example: One session with multiple windows**
```bash
ts work                      # or: tmux new -s work

# Inside tmux, create windows (Ctrl+S, c):
Window 0: dotfiles    → Config files
Window 1: backend     → API development
Window 2: frontend    → UI work
Window 3: scripts     → General terminal
```

**Benefits:**
- All projects visible in one glance
- Quick switching with Ctrl+S then 0-9 or mouse clicks
- Simpler mental model
- Window names persist (configured to not auto-change)

### Use Multiple Sessions When:

### Use Case 1: Completely Separate Contexts
```bash
tmux new -s work       # Work projects
tmux new -s personal   # Personal projects
tmux new -s learning   # Tutorials/experiments
```

**Why?** Complete separation between life contexts

### Use Case 2: Remote Servers (SSH)
```bash
# On remote server
ssh user@server.com
tmux new -s deployment
```

**Why?** Sessions persist even if SSH connection drops!

### Use Case 3: Long-Running Tasks
```bash
tmux new -s monitoring
# Inside: start a log monitoring script
# Detach and let it run

tmux new -s main
# Your normal work
```

**Why?** Keep long-running processes separate from your active work.

### Real Example Workflow
```bash
# Monday morning
ts api-development           # or: tmux new -s api-development

# Inside tmux:
# Pane 1: code editor (vim/nvim)
# Pane 2: running dev server
# Pane 3: running tests in watch mode
# Pane 4: database client

# Lunch time - detach (Ctrl+S, d)
# Everything keeps running!

# After lunch - reattach
ta api-development           # or: tmux attach -t api-development

# Friday evening - still working on feature
# Just detach, come back Monday

# Feature complete and deployed - kill it
tkss api-development         # or: tmux kill-session -t api-development
```

## When to Keep Server Running vs Kill It

### Keep Running When:
✅ You're actively working on something (obvious)
✅ You have long-running processes (servers, logs, builds)
✅ You'll return to the work soon (same day/week)
✅ You want to preserve your terminal layout/state
✅ On a remote server (SSH) - this is tmux's killer feature!

### Kill Session When:
❌ Project is completely done
❌ You won't need that context for weeks/months
❌ You need to free up system resources
❌ You're reorganizing your workflow

### Kill Entire Server When:
❌ No sessions are useful anymore
❌ Tmux is behaving strangely (rare, but can happen)
❌ You're rebooting your machine anyway

```bash
# Kill specific session
tmux kill-session -t myproject

# Kill ALL sessions and server
tmux kill-server

# List what's running
tmux ls
```

## SSH Use Case (tmux's superpower!)

```bash
# On remote server
ssh user@myserver.com
tmux new -s deployment

# Start a long deployment
./deploy.sh  # takes 30 minutes

# Oh no! Your internet cuts out...
# BUT: tmux session keeps running on server!

# Reconnect and reattach
ssh user@myserver.com
tmux attach -t deployment

# Your deployment kept running! 🎉
```

## Common Patterns

### Pattern 1: One Session Per Project
```bash
tmux new -s project-alpha
# Detach when switching projects
tmux new -s project-beta
# Switch between them
tmux attach -t project-alpha
```

### Pattern 2: Persistent "Work" Session
```bash
# Every day
tmux attach -t work || tmux new -s work
# If "work" exists, attach; otherwise create it
```

### Pattern 3: Temporary Experiments
```bash
tmux new -s experiment
# Try something risky
# If it works, detach and save
# If it fails, just kill session
tmux kill-session -t experiment
```

## Things to Worry About

### 1. Orphaned Sessions
**Problem:** You forget about detached sessions, they accumulate.

**Solution:**
```bash
# Check regularly
tmux ls

# Clean up old sessions
tmux kill-session -t old-project
```

### 2. Resource Usage
**Problem:** Running servers/processes in detached sessions use CPU/memory.

**Solution:** Kill sessions you're not using, especially ones with dev servers.

### 3. Terminal Size Conflicts
**Problem:** If you attach from different terminal sizes, tmux picks smallest.

**Solution:**
```bash
# Detach other clients when attaching
tmux attach -d -t mysession

# Or let tmux handle it (your config has this)
# setw -g aggressive-resize on
```

### 4. Config Changes
**Problem:** Config changes don't apply to existing sessions.

**Solution:**
```bash
# Inside tmux, reload config
# Ctrl+S, then type:
:source-file ~/.tmux.conf

# Or add this binding to your config:
# bind r source-file ~/.tmux.conf \; display "Config reloaded!"
```

### 5. Accidentally Exiting
**Problem:** Typing `exit` in last pane kills the session!

**Solution:** Get in habit of detaching (`Ctrl+S, d`) instead of exiting.

## Quick Reference

```bash
# Session management (full commands)
tmux ls                        # List sessions
tmux new -s name              # Create named session
tmux attach -t name           # Attach to session
tmux kill-session -t name     # Kill specific session
tmux kill-server              # Kill everything

# Session management (zsh shortcuts from .zshrc)
t                             # Start tmux
ts name                       # Create named session
tl                            # List sessions
ta name                       # Smart attach (switches if inside tmux)
tad name                      # Attach and detach others
tkss name                     # Kill specific session
tksv                          # Kill server

# Inside tmux - Sessions
Ctrl+S, d                     # Detach
Ctrl+S, s                     # Session selector (interactive)
Ctrl+S, $                     # Rename current session
Ctrl+S, (  /  )              # Previous/next session

# Inside tmux - Windows
Ctrl+S, c                     # Create new window
Ctrl+S, ,                     # Rename window (names persist!)
Ctrl+S, 0-9                   # Jump to window number
Ctrl+S, n / p                 # Next/previous window
Ctrl+S, < / >                 # Move window left/right (repeatable)
Ctrl+S, X                     # Kill window

# Inside tmux - Panes
Ctrl+S, v                     # Split vertical
Ctrl+S, s                     # Split horizontal
Ctrl+S, h/j/k/l               # Navigate panes (vim-style)
Ctrl+S, H/J/K/L               # Resize panes (vim-style, repeatable)
Ctrl+S, u / d                 # Swap pane up/down
Ctrl+S, x                     # Kill pane

# Other
Ctrl+S, r                     # Reload config
```

## Recommended Daily Workflow

### Window-Based Workflow (Simpler, Recommended)

```bash
# Morning: Check what's running
tl                           # or: tmux ls

# Attach to main work session, or create it
ta work || ts work           # or: tmux attach -t work || tmux new -s work

# Inside tmux: Create windows for different projects
Ctrl+S, c  # New window
Ctrl+S, ,  # Rename to "backend"

Ctrl+S, c  # Another window
Ctrl+S, ,  # Rename to "frontend"

# Switch between projects with Ctrl+S then number or click tabs
# Reorder windows: Ctrl+S, < or >

# End of day: Just detach, everything persists
Ctrl+S, d

# Next day: Reattach
ta work                      # or: tmux attach -t work
```

### Session-Based Workflow (For Separate Contexts)

```bash
# Morning: Check what's running
tl                           # or: tmux ls

# Different sessions for different contexts
ts work                      # or: tmux new -s work
ts personal                  # or: tmux new -s personal

# Switch between sessions
Ctrl+S, s                    # Interactive session switcher
# Or use: ta work            # Smart attach/switch

# End of day: Keep sessions running or kill completed ones
tkss personal                # or: tmux kill-session -t personal (if done)

# Weekend/vacation: Maybe kill server to free resources
tksv                         # or: tmux kill-server

# Or just leave it - tmux is lightweight!
```

## Mental Model

Think of tmux like an **office building**:

**Sessions** = Different offices/rooms
- Completely separate workspaces
- Walk in and out (attach/detach)
- The building (tmux server) stays open

**Windows** = Desks in your office
- Different projects on different desks
- All visible at once (tabs in status bar)
- Easy to switch between
- Names on each desk (window names)

**Panes** = Sections of your desk
- Split your workspace as needed
- Different tools visible simultaneously

**Your config optimizes for:**
- One main session (your office)
- Multiple windows for different projects (your desks)
- Window names that don't auto-change (labeled desks)
- Easy navigation and reordering
