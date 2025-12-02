# Starship
eval "$(starship init zsh)"
alias starship-reload='eval "$(starship init $SHELL)"'

# Zoxide
eval "$(zoxide init zsh)"

# Tmux session management
# Smart tmux: attach to existing session or create new one
function t() {
  if command tmux has-session 2>/dev/null; then
    command tmux attach
  else
    command tmux new-session -s main
  fi
}

# Make 'tmux' command also use smart behavior
alias tmux='t'

alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Smart attach: switches if inside tmux, attaches if outside
function ta() {
  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$1"
  else
    tmux attach -t "$1"
  fi
}

# Git aliases
# Status
alias gs='git status'
alias gss='git status -s'

# Add
alias ga='git add'
alias gaa='git add --all'
alias gap='git add --patch'

# Commit
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcane='git commit --amend --no-edit'

# Branch
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'

# Checkout/Switch
alias gco='git checkout'
alias gcb='git checkout -b'
alias gsw='git switch'
alias gswc='git switch -c'

# Pull/Push/Fetch
alias gf='git fetch'
alias gfa='git fetch --all'
alias gl='git pull'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpu='git push -u origin HEAD'

# Log
alias glo='git log --oneline'
alias glg='git log --graph --oneline --all'
alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Diff
alias gd='git diff'
alias gds='git diff --staged'
alias gdc='git diff --cached'

# Merge/Rebase
alias gm='git merge'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

# Stash
alias gsta='git stash'
alias gstaa='git stash apply'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'

# Remote
alias gr='git remote'
alias grv='git remote -v'
alias gra='git remote add'

# Workflow shortcuts
alias gwip='git add -u && git commit -m "WIP"'
alias gundo='git reset --soft HEAD~1'
alias gunstage='git reset HEAD --'

# Disable automatic title updates in tmux (must be at the end, after starship/zoxide)
if [ -n "$TMUX" ]; then
  # Override precmd to prevent title updates
  precmd_functions=()
  preexec_functions=()

  # Set a static prompt command that doesn't update the title
  precmd() { : }
  preexec() { : }
fi

# Machine-specific configuration
# This file is not tracked in git and should contain machine-specific settings:
# - PATH additions (brew, nvm, pyenv, google-cloud-sdk, etc.)
# - Tool-specific configs (ollama, LM Studio, etc.)
# - Work-specific aliases and functions
# - Any other local customizations
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
