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

# Error handling
trap 'handle_error $?' ERR
trap 'handle_exit' EXIT

INSTALLATION_FAILED=false
BACKUP_DIR=""

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Check for rollback flag
if [ "$1" = "--rollback" ]; then
    rollback_installation
    exit 0
fi

echo -e "${BLUE}=== Dotfiles Installation ===${NC}"
echo -e "Dotfiles directory: ${GREEN}$DOTFILES_DIR${NC}"
echo ""

# Dependency management functions
check_homebrew() {
    if ! command -v brew >/dev/null 2>&1; then
        print_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for current session
        if [ "$(uname -m)" = "arm64" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        print_success "Homebrew installed"
    else
        print_success "Homebrew already installed"
    fi
}

install_package() {
    local package=$1
    local cask=$2
    
    if [ "$cask" = "true" ]; then
        if brew list --cask "$package" >/dev/null 2>&1; then
            print_success "$package (cask) already installed"
        else
            print_info "Installing $package (cask)..."
            brew install --cask "$package"
        fi
    else
        if brew list "$package" >/dev/null 2>&1; then
            print_success "$package already installed"
        else
            print_info "Installing $package..."
            brew install "$package"
        fi
    fi
}

check_dependencies() {
    echo -e "${BLUE}Step 0: Checking Dependencies${NC}"
    echo "-------------------------------------------"
    
    # Check and install Homebrew
    check_homebrew
    
    # Define required packages and their types
    declare -A packages=(
        ["git"]="false"
        ["zsh"]="false"
        ["neovim"]="false"
        ["tmux"]="false"
        ["starship"]="false"
        ["ghostty"]="true"
    )
    
    local missing=()
    local to_install_cask=()
    local to_install_brew=()
    
    # Check each package
    for package in "${!packages[@]}"; do
        is_cask=${packages[$package]}
        
        case $package in
            "git")
                if ! command -v git >/dev/null 2>&1; then
                    to_install_brew+=("$package")
                else
                    print_success "git already installed"
                fi
                ;;
            "zsh")
                if ! command -v zsh >/dev/null 2>&1; then
                    to_install_brew+=("$package")
                else
                    print_success "zsh already installed"
                fi
                ;;
            "neovim")
                if ! command -v nvim >/dev/null 2>&1; then
                    to_install_brew+=("neovim")
                else
                    print_success "nvim already installed"
                fi
                ;;
            "tmux")
                if ! command -v tmux >/dev/null 2>&1; then
                    to_install_brew+=("$package")
                else
                    print_success "tmux already installed"
                fi
                ;;
            "starship")
                if ! command -v starship >/dev/null 2>&1; then
                    to_install_brew+=("$package")
                else
                    print_success "starship already installed"
                fi
                ;;
            "ghostty")
                if ! command -v ghostty >/dev/null 2>&1; then
                    to_install_cask+=("$package")
                else
                    print_success "ghostty already installed"
                fi
                ;;
        esac
    done
    
    # Install missing packages
    if [ ${#to_install_brew[@]} -gt 0 ] || [ ${#to_install_cask[@]} -gt 0 ]; then
        print_info "Updating Homebrew..."
        brew update
        
        for package in "${to_install_brew[@]}"; do
            install_package "$package" "false"
        done
        
        for package in "${to_install_cask[@]}"; do
            install_package "$package" "true"
        done
        
        # Update PATH for newly installed tools
        eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null)"
    fi
    
    print_success "All dependencies are installed"
    echo ""
}

rollback_installation() {
    echo -e "${BLUE}=== Rolling Back Installation ===${NC}"
    
    # Find most recent backup
    local latest_backup=$(ls -1t "$HOME"/.dotfiles_backup_* 2>/dev/null | head -1)
    
    if [ -z "$latest_backup" ]; then
        print_warning "No backup found to rollback from"
        return 0
    fi
    
    print_info "Rolling back from: $latest_backup"
    
    # Remove symlinks and restore from backup
    local symlinks=(
        "$HOME/.config/nvim"
        "$HOME/.config/tmux"
        "$HOME/.config/ghostty"
        "$HOME/.config/starship.toml"
        "$HOME/.tmux.conf"
        "$HOME/.zshrc"
    )
    
    for target in "${symlinks[@]}"; do
        if [ -L "$target" ]; then
            print_info "Removing symlink: $target"
            rm "$target"
        fi
    done
    
    # Restore from backup
    if [ -d "$latest_backup" ]; then
        cp -r "$latest_backup"/. "$HOME/"
        print_success "Files restored from backup"
    fi
    
    print_warning "Backup directory kept: $latest_backup"
    print_info "You can delete it manually once you've verified everything works"
}

# Enhanced symlink creation with validation
create_symlink_with_validation() {
    local source=$1
    local target=$2
    local name=$3
    
    create_symlink "$source" "$target" "$name"
    
    # Validate symlink was created correctly
    if [ ! -L "$target" ]; then
        print_error "Failed to create symlink for $name"
        return 1
    fi
    
    local actual_source=$(readlink "$target")
    if [ "$actual_source" != "$source" ]; then
        print_error "Symlink points to wrong location for $name"
        print_error "Expected: $source"
        print_error "Actual: $actual_source"
        return 1
    fi
    
    return 0
}

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

# Error handling functions
handle_error() {
    local exit_code=$1
    INSTALLATION_FAILED=true
    print_error "Installation failed at line $LINENO (exit code: $exit_code)"
    
    if [ -n "$BACKUP_DIR" ] && [ -d "$BACKUP_DIR" ]; then
        echo ""
        print_warning "A backup was created at: $BACKUP_DIR"
        print_info "You can manually restore from this backup if needed"
    fi
    
    echo ""
    print_info "To rollback changes, run:"
    echo "  cd $DOTFILES_DIR"
    echo "  ./install.sh --rollback"
}

handle_exit() {
    if [ "$INSTALLATION_FAILED" = false ]; then
        echo ""
        print_success "Installation completed successfully!"
    fi
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

check_dependencies

echo -e "${BLUE}Step 1: Migrating existing .zshrc${NC}"
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
echo -e "${BLUE}Step 2: Backing up existing configurations${NC}"
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
echo -e "${BLUE}Step 3: Creating symlinks${NC}"
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
