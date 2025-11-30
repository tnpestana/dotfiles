# Git Cheatsheet

## Shell Aliases (from .zshrc)

### Status & Information
```bash
gs                   # git status
gss                  # git status -s (short format)
```

### Adding Files
```bash
ga <file>            # git add <file>
gaa                  # git add --all (stage all changes)
gap                  # git add --patch (interactive staging)
```

### Committing
```bash
gc                   # git commit (opens editor)
gcm "message"        # git commit -m "message"
gca                  # git commit --amend (modify last commit)
gcane                # git commit --amend --no-edit (amend without changing message)
```

### Branching
```bash
gb                   # git branch (list branches)
gba                  # git branch -a (list all branches, including remote)
gbd <branch>         # git branch -d <branch> (delete branch)
gbD <branch>         # git branch -D <branch> (force delete branch)
```

### Checkout/Switch
```bash
gco <branch>         # git checkout <branch>
gcb <branch>         # git checkout -b <branch> (create and checkout)
gsw <branch>         # git switch <branch> (newer alternative)
gswc <branch>        # git switch -c <branch> (create and switch)
```

### Pull/Push/Fetch
```bash
gf                   # git fetch
gfa                  # git fetch --all
gl                   # git pull
gp                   # git push
gpf                  # git push --force-with-lease (safer force push)
gpu                  # git push -u origin HEAD (push and set upstream)
```

### Logging
```bash
glo                  # git log --oneline
glg                  # git log --graph --oneline --all
glog                 # Pretty formatted log with graph
```

### Diffing
```bash
gd                   # git diff (unstaged changes)
gds                  # git diff --staged (staged changes)
gdc                  # git diff --cached (same as staged)
```

### Merge/Rebase
```bash
gm <branch>          # git merge <branch>
grb <branch>         # git rebase <branch>
grbi <commit>        # git rebase -i <commit> (interactive rebase)
grbc                 # git rebase --continue
grba                 # git rebase --abort
```

### Stashing
```bash
gsta                 # git stash (save uncommitted changes)
gstaa                # git stash apply (apply without removing from stash)
gstp                 # git stash pop (apply and remove from stash)
gstl                 # git stash list (show all stashes)
gstd                 # git stash drop (delete a stash)
```

### Remote
```bash
gr                   # git remote (list remotes)
grv                  # git remote -v (list with URLs)
gra <name> <url>     # git remote add <name> <url>
```

### Workflow Shortcuts
```bash
gwip                 # git add -u && git commit -m "WIP"
gundo                # git reset --soft HEAD~1 (undo last commit, keep changes)
gunstage             # git reset HEAD -- (unstage files)
```

## Essential Git Commands

### Repository Setup
```bash
git init                              # Initialize new repository
git clone <url>                       # Clone remote repository
git clone <url> <directory>           # Clone into specific directory
```

### Configuration
```bash
git config --global user.name "Name"           # Set your name
git config --global user.email "email@example.com"  # Set your email
git config --list                              # List all config
git config --global core.editor nvim           # Set default editor
```

### Working with Changes

#### Staging & Committing
```bash
git add <file>                        # Stage specific file
git add .                             # Stage all in current directory
git add -A                            # Stage all changes (including deletions)
git add -p                            # Interactive staging (choose hunks)

git commit -m "message"               # Commit with message
git commit -am "message"              # Add all tracked files and commit
git commit --amend                    # Modify last commit
git commit --amend --no-edit          # Amend without changing message
```

#### Viewing Changes
```bash
git status                            # Show working tree status
git status -s                         # Short status format
git diff                              # Show unstaged changes
git diff --staged                     # Show staged changes
git diff HEAD                         # Show all changes since last commit
git diff <branch1>..<branch2>         # Compare two branches
```

### Branching & Merging

#### Branch Operations
```bash
git branch                            # List local branches
git branch -a                         # List all branches (local + remote)
git branch -r                         # List remote branches
git branch <name>                     # Create new branch
git branch -d <name>                  # Delete branch (safe)
git branch -D <name>                  # Force delete branch
git branch -m <old> <new>             # Rename branch
```

#### Switching Branches
```bash
git checkout <branch>                 # Switch to branch
git checkout -b <branch>              # Create and switch to new branch
git switch <branch>                   # Switch to branch (newer)
git switch -c <branch>                # Create and switch (newer)
git checkout -                        # Switch to previous branch
```

#### Merging
```bash
git merge <branch>                    # Merge branch into current branch
git merge --no-ff <branch>            # Merge with merge commit (no fast-forward)
git merge --squash <branch>           # Squash commits and merge
git merge --abort                     # Abort merge in case of conflicts
```

### Remote Operations

#### Remote Management
```bash
git remote                            # List remotes
git remote -v                         # List remotes with URLs
git remote add <name> <url>           # Add remote
git remote remove <name>              # Remove remote
git remote rename <old> <new>         # Rename remote
git remote set-url <name> <url>       # Change remote URL
```

#### Fetch/Pull/Push
```bash
git fetch                             # Fetch from default remote
git fetch <remote>                    # Fetch from specific remote
git fetch --all                       # Fetch from all remotes

git pull                              # Fetch and merge
git pull --rebase                     # Fetch and rebase instead of merge

git push                              # Push to default remote/branch
git push -u origin <branch>           # Push and set upstream
git push origin <branch>              # Push to specific branch
git push --force-with-lease           # Safer force push
git push --all                        # Push all branches
git push --tags                       # Push all tags
```

### History & Logs

#### Viewing History
```bash
git log                               # Show commit history
git log --oneline                     # Compact one-line format
git log --graph                       # Show branch graph
git log --all                         # Show all branches
git log -n 5                          # Show last 5 commits
git log --since="2 weeks ago"         # Commits from last 2 weeks
git log --author="Name"               # Commits by specific author
git log --grep="keyword"              # Search commit messages
git log <file>                        # History of specific file
git log -p <file>                     # Show changes to file over time
```

#### Pretty Logs
```bash
git log --graph --oneline --all
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
```

### Undoing Changes

#### Working Directory
```bash
git checkout -- <file>                # Discard changes in working directory
git restore <file>                    # Discard changes (newer)
git restore --staged <file>           # Unstage file (newer)
git clean -n                          # Show what would be removed
git clean -fd                         # Remove untracked files and directories
```

#### Staging Area
```bash
git reset <file>                      # Unstage file
git reset                             # Unstage all files
git reset HEAD --                     # Unstage all (older syntax)
```

#### Commits
```bash
git reset --soft HEAD~1               # Undo last commit, keep changes staged
git reset --mixed HEAD~1              # Undo last commit, unstage changes
git reset --hard HEAD~1               # Undo last commit, discard changes
git revert <commit>                   # Create new commit that undoes changes
```

### Stashing

```bash
git stash                             # Stash uncommitted changes
git stash save "message"              # Stash with message
git stash -u                          # Include untracked files
git stash list                        # List all stashes
git stash show                        # Show latest stash changes
git stash show -p                     # Show latest stash diff
git stash apply                       # Apply latest stash
git stash apply stash@{n}             # Apply specific stash
git stash pop                         # Apply and remove latest stash
git stash drop                        # Delete latest stash
git stash drop stash@{n}              # Delete specific stash
git stash clear                       # Delete all stashes
```

### Rebasing

```bash
git rebase <branch>                   # Rebase current branch onto branch
git rebase -i HEAD~3                  # Interactive rebase last 3 commits
git rebase --continue                 # Continue after resolving conflicts
git rebase --skip                     # Skip current commit
git rebase --abort                    # Abort rebase
```

**Interactive rebase commands**:
- `pick` - Use commit
- `reword` - Use commit, edit message
- `edit` - Use commit, stop to amend
- `squash` - Meld into previous commit
- `fixup` - Like squash, discard message
- `drop` - Remove commit

### Tags

```bash
git tag                               # List tags
git tag <name>                        # Create lightweight tag
git tag -a <name> -m "message"        # Create annotated tag
git tag -d <name>                     # Delete tag
git push origin <tag>                 # Push specific tag
git push --tags                       # Push all tags
git push origin --delete <tag>        # Delete remote tag
```

### Useful Workflows

#### Quick Save Work
```bash
gwip                                  # Alias: Add tracked files and commit as "WIP"
gsta                                  # Alias: Stash changes
```

#### Fix Last Commit
```bash
# Fix commit message
gca                                   # Alias: Amend last commit

# Add forgotten files
ga <file>
gcane                                 # Alias: Amend without changing message
```

#### Undo Last Commit
```bash
gundo                                 # Alias: Undo commit, keep changes
git reset --hard HEAD~1               # Undo commit, discard changes
```

#### Update Feature Branch
```bash
gco main                              # Alias: Switch to main
gl                                    # Alias: Pull latest changes
gco feature-branch                    # Alias: Switch back to feature
grb main                              # Alias: Rebase onto main
```

#### Clean Up Branch History
```bash
grbi HEAD~5                           # Alias: Interactive rebase last 5 commits
# Then squash/reword as needed
```

#### Safe Force Push
```bash
gpf                                   # Alias: Force push with lease (checks remote)
```

### Tips & Best Practices

1. **Always use `--force-with-lease` instead of `--force`**
   - Prevents accidentally overwriting others' work

2. **Use `git pull --rebase` for cleaner history**
   - Avoids unnecessary merge commits

3. **Commit early and often**
   - Use `gwip` for work-in-progress commits
   - Clean up with interactive rebase before pushing

4. **Check status before committing**
   - `gs` to see what you're committing
   - `gd` to review changes

5. **Use descriptive commit messages**
   - First line: brief summary (50 chars or less)
   - Blank line
   - Detailed description if needed

6. **Branch naming conventions**
   - `feature/description`
   - `bugfix/description`
   - `hotfix/description`

7. **Keep main/master clean**
   - Never commit directly to main
   - Always use feature branches

8. **Review before pushing**
   - `glo` to check commit history
   - `gd` to review changes

## Common Scenarios

### Starting New Feature
```bash
gco main                              # Switch to main
gl                                    # Pull latest
gcb feature/new-feature               # Create feature branch
# ... make changes ...
gaa                                   # Stage all changes
gcm "Add new feature"                 # Commit
gpu                                   # Push and set upstream
```

### Fixing Merge Conflicts
```bash
gl                                    # Attempt pull (conflicts occur)
gs                                    # See conflicted files
# ... resolve conflicts in editor ...
ga <resolved-files>                   # Stage resolved files
gc                                    # Commit merge
gp                                    # Push
```

### Updating Feature Branch with Main
```bash
gco main                              # Switch to main
gl                                    # Pull latest
gco feature-branch                    # Switch to feature
grb main                              # Rebase onto main
# ... resolve conflicts if any ...
grbc                                  # Continue rebase
gpf                                   # Force push (updates remote)
```

### Recovering Lost Work
```bash
git reflog                            # See all HEAD movements
git checkout <commit-hash>            # Go to specific state
gcb recovery                          # Create branch from this state
```
