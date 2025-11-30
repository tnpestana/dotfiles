# Zsh Configuration Cheatsheet

## Shell Enhancements

### Starship Prompt
A fast, customizable prompt written in Rust.
- Automatically shows git status, current directory, and more
- Configuration file: `~/.config/starship.toml`

**Commands**:
```bash
starship-reload    # Reload starship configuration
```

### Zoxide
A smarter `cd` command that learns most-used directories.

**Basic usage**:
```bash
z <directory>      # Jump to a directory (fuzzy matching)
z foo              # Jumps to most frequent directory matching "foo"
zi                 # Interactive directory selection
```

**Examples**:
```bash
z dotfiles         # Jumps to ~/dotfiles (if frequently visited)
z doc              # Could jump to ~/Documents based on frequency
zi                 # Opens interactive picker
```

**How it learns**:
- Tracks directories visited with `cd`
- Ranks by "frecency" (frequency + recency)
- No need to type full paths

## Tmux Session Management

### Basic Aliases
```bash
t                  # Start tmux
ts mysession       # Start new named session
tl                 # List all sessions
tad mysession      # Attach and detach others from session
tksv               # Kill tmux server (all sessions)
tkss mysession     # Kill specific session
```

### Smart Attach Function
```bash
ta mysession       # Smart attach/switch
```
- If **inside tmux**: switches to the session
- If **outside tmux**: attaches to the session

## Git Aliases

Comprehensive git shortcuts for faster workflow. See **[git-cheatsheet.md](git-cheatsheet.md)** for complete reference.

### Status & Information
```bash
gs                   # git status
gss                  # git status -s (short format)
```

### Common Workflow
```bash
ga <file>            # git add
gaa                  # git add --all
gcm "message"        # git commit -m "message"
gp                   # git push
gl                   # git pull
```

### Branching
```bash
gb                   # git branch (list)
gco <branch>         # git checkout
gcb <branch>         # git checkout -b (create and checkout)
gsw <branch>         # git switch (newer)
gbd <branch>         # git branch -d (delete)
```

### Logging & Diffing
```bash
glo                  # git log --oneline
glg                  # git log --graph --oneline --all
gd                   # git diff
gds                  # git diff --staged
```

### Useful Shortcuts
```bash
gwip                 # Quick WIP commit
gundo                # Undo last commit (keep changes)
gunstage             # Unstage files
gca                  # Amend last commit
gpf                  # Push force with lease (safer)
```

**Note**: For complete git reference including rebase, stash, merge, and workflows, see **[git-cheatsheet.md](git-cheatsheet.md)**

## Application Aliases

### Love2D Game Engine
```bash
love               # Launches Love2D (macOS app)
love .             # Run Love2D game in current directory
```

## Environment Configuration

### PATH Additions
The PATH includes:
- `~/.npm-global/bin` - Global npm packages
- `~/google-cloud-sdk/bin` - Google Cloud SDK
- `~/.lmstudio/bin` - LM Studio CLI tools

## Tmux Integration

### Automatic Behavior
The zshrc includes special tmux integration:
- **Disables automatic title updates** when inside tmux
- Preserves manually set window names
- Prevents Starship/Zoxide from overwriting tmux window titles

**How it works**:
```bash
# Only active when inside tmux (TMUX environment variable is set)
precmd_functions=()   # Cleared to prevent title updates
preexec_functions=()  # Cleared to prevent title updates
```

**Why this matters**:
- Window names set with `Ctrl+S ,` will persist
- Terminal won't auto-update names based on current command
- Keeps the tmux workspace organized

## Quick Reference

### Navigation
```bash
z <dir>            # Smart cd (zoxide)
cd <dir>           # Traditional cd
pwd                # Print working directory
ls                 # List files
```

### Tmux Workflow
```bash
# Start a new project session
ts myproject

# Work in tmux...

# Detach: Ctrl+S, d

# Later, re-attach smartly
ta myproject

# List all sessions to see what's running
tl

# Kill a session when done
tkss myproject
```

### Development Tools
```bash
love .             # Run Love2D game
npm install -g pkg # Install global npm package (goes to ~/.npm-global)
gcloud ...         # Google Cloud SDK commands
lms ...            # LM Studio CLI commands
```

## Customization

### Adding Custom Aliases
Edit `~/.zshrc` and add:
```bash
alias myalias='command'
```

Then reload:
```bash
source ~/.zshrc
```

### Useful Aliases to Consider Adding
```bash
# Quick navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'

# List aliases
alias ll='ls -lah'
alias la='ls -A'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# System
alias reload='source ~/.zshrc'
alias zshconfig='nvim ~/.zshrc'
```

**Note**: Git aliases are already configured - see the Git Aliases section above.

## Tool Documentation

### Learn More
- **Starship**: https://starship.rs/
- **Zoxide**: https://github.com/ajeetdsouza/zoxide
- **Zsh**: https://zsh.sourceforge.io/
- **Love2D**: https://love2d.org/

## Tips

1. **Zoxide learning**: Visit directories with `cd` first to build the database
2. **Tmux windows**: This setup is optimized for window-based organization
3. **Starship**: Customize prompt in `~/.config/starship.toml`
4. **Tab completion**: Zsh has powerful tab completion - try it everywhere!
5. **History search**: Use `Ctrl+R` to search command history

## Integrated Workflow Example

```bash
# Navigate to project using zoxide
z myproject

# Start a tmux session for this project
ts myproject

# Create windows for different tasks
# Ctrl+S, c  (new window)
# Ctrl+S, ,  (rename to "backend")

# Open nvim
nvim .

# Use telescope to find files: Space + ff
# Use LSP features: gd, gr, K, etc.

# When done, detach from tmux
# Ctrl+S, d

# Later, jump back
z myproject && ta myproject
```
