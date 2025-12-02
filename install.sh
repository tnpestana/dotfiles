#!/usr/bin/env bash

# Dotfiles installation script
# This script will backup existing configs and create symlinks to dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo -e "${BLUE}=== Dotfiles Installation ===${NC}"
echo -e "Dotfiles directory: ${GREEN}$DOTFILES_DIR${NC}"
echo ""

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Function to backup a file or directory
backup_if_exists() {
    local path=$1
    local name=$2

    if [ -e "$path" ]; then
        if [ -L "$path" ]; then
            print_info "Removing existing symlink: $path"
            rm "$path"
        else
            mkdir -p "$BACKUP_DIR"
            print_warning "Backing up existing $name to: $BACKUP_DIR/"
            mv "$path" "$BACKUP_DIR/"
        fi
        return 0
    fi
    return 1
}

# Function to create symlink
create_symlink() {
    local source=$1
    local target=$2
    local name=$3

    if [ -e "$target" ]; then
        print_error "$name already exists at $target"
        return 1
    fi

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"

    ln -s "$source" "$target"
    print_success "Created symlink: $target -> $source"
}

echo -e "${BLUE}Step 0: Migrating existing .zshrc${NC}"
echo "-------------------------------------------"

# Check if .zshrc exists and is not a symlink
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    print_info "Found existing .zshrc file"

    # Check if .zshrc.local already exists
    if [ -f "$HOME/.zshrc.local" ]; then
        print_warning ".zshrc.local already exists, skipping migration"
    else
        echo ""
        read -p "Migrate existing .zshrc to .zshrc.local for machine-specific configs? (y/n) " -n 1 -r
        echo ""

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cp "$HOME/.zshrc" "$HOME/.zshrc.local"
            print_success "Migrated .zshrc to .zshrc.local"
            print_info "Your existing configs are now in .zshrc.local (not tracked in git)"
        else
            print_info "Skipping migration. Your .zshrc will be backed up."
        fi
    fi
else
    print_info "No existing .zshrc to migrate, or already a symlink"
fi

echo ""
echo -e "${BLUE}Step 1: Backing up existing configurations${NC}"
echo "-------------------------------------------"

# Backup existing configs
backup_if_exists "$HOME/.config/nvim" "nvim config"
backup_if_exists "$HOME/.config/tmux" "tmux config"
backup_if_exists "$HOME/.config/ghostty" "ghostty config"
backup_if_exists "$HOME/.config/starship.toml" "starship config"
backup_if_exists "$HOME/.tmux.conf" ".tmux.conf"
backup_if_exists "$HOME/.zshrc" ".zshrc"

if [ -d "$BACKUP_DIR" ]; then
    print_success "Backups saved to: $BACKUP_DIR"
else
    print_info "No existing configs found to backup"
fi

echo ""
echo -e "${BLUE}Step 2: Creating symlinks${NC}"
echo "-------------------------------------------"

# Create symlinks
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim" "nvim"
create_symlink "$DOTFILES_DIR/tmux" "$HOME/.config/tmux" "tmux"
create_symlink "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty" "ghostty"
create_symlink "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml" "starship"
create_symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf" ".tmux.conf"
create_symlink "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc" ".zshrc"

echo ""
echo -e "${BLUE}Step 3: Installing plugin managers${NC}"
echo "-------------------------------------------"

# Install TPM for tmux if not already installed
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    print_info "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    print_success "TPM installed. Press 'prefix + I' in tmux to install plugins"
else
    print_info "TPM already installed"
fi

# Neovim plugins (lazy.nvim auto-installs on first launch)
print_info "Neovim plugins will auto-install on first launch (lazy.nvim)"

echo ""
echo -e "${GREEN}=== Installation Complete! ===${NC}"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: exec \$SHELL"
echo "  2. Open nvim - plugins will auto-install"
echo "  3. Open tmux and press 'prefix + I' to install tmux plugins"
echo ""
if [ -d "$BACKUP_DIR" ]; then
    echo -e "Your old configs are backed up in: ${YELLOW}$BACKUP_DIR${NC}"
    echo "You can delete this backup once you've verified everything works."
fi
