
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/tiagopestana/.lmstudio/bin"
# End of LM Studio CLI section

export PATH=~/.npm-global/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
export PATH="$HOME/google-cloud-sdk/bin:$PATH"

# Starship
eval "$(starship init zsh)"
alias starship-reload='eval "$(starship init $SHELL)"'

# Zoxide
eval "$(zoxide init zsh)"

# Love2D
alias love="/Applications/love.app/Contents/MacOS/love"

# Tmux session management
alias t='tmux'
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

# Disable automatic title updates in tmux (must be at the end, after starship/zoxide)
if [ -n "$TMUX" ]; then
  # Override precmd to prevent title updates
  precmd_functions=()
  preexec_functions=()

  # Set a static prompt command that doesn't update the title
  precmd() { : }
  preexec() { : }
fi
