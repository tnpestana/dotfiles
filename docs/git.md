# Git Aliases Reference

## Status & Info
- `gs` - git status
- `gss` - git status -s (short)
- `glo` - git log --oneline
- `glg` - git log --graph
- `glog` - git log (formatted)

## Add & Commit
- `ga <file>` - git add
- `gaa` - git add --all
- `gap` - git add --patch
- `gc` - git commit
- `gcm "msg"` - git commit -m
- `gca` - git commit --amend
- `gcane` - git commit --amend --no-edit

## Branching
- `gb` - git branch
- `gba` - git branch -a (all)
- `gbd <branch>` - git branch -d (delete)
- `gbD <branch>` - git branch -D (force delete)
- `gco <branch>` - git checkout
- `gcb <branch>` - git checkout -b (create)
- `gsw <branch>` - git switch
- `gswc <branch>` - git switch -c (create)

## Remote Operations
- `gf` - git fetch
- `gfa` - git fetch --all
- `gl` - git pull
- `gp` - git push
- `gpf` - git push --force-with-lease
- `gpu` - git push -u origin HEAD

## Diff & Merge
- `gd` - git diff
- `gds` - git diff --staged
- `gdc` - git diff --cached
- `gm` - git merge

## Rebase
- `grb` - git rebase
- `grbi` - git rebase -i
- `grbc` - git rebase --continue
- `grba` - git rebase --abort

## Stash
- `gsta` - git stash
- `gstaa` - git stash apply
- `gstp` - git stash pop
- `gstl` - git stash list
- `gstd` - git stash drop

## Remote Management
- `gr` - git remote
- `grv` - git remote -v
- `gra` - git remote add

## Workflow Shortcuts
- `gwip` - Quick WIP commit (add -u && commit)
- `gundo` - Undo last commit (keep changes)
- `gunstage` - Unstage files
