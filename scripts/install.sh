#!/usr/bin/env bash
# Dotfiles installation script
# This script creates symlinks from the home directory to dotfiles in ~/dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

echo -e "${GREEN}Installing dotfiles...${NC}"

# Function to create symlink
create_symlink() {
  local source=$1
  local target=$2

  if [ -L "$target" ]; then
    echo -e "${YELLOW}Symlink already exists: $target${NC}"
  elif [ -f "$target" ] || [ -d "$target" ]; then
    echo -e "${YELLOW}Backing up existing file: $target${NC}"
    mv "$target" "${target}.backup"
    ln -sf "$source" "$target"
    echo -e "${GREEN}Created symlink: $target -> $source${NC}"
  else
    ln -sf "$source" "$target"
    echo -e "${GREEN}Created symlink: $target -> $source${NC}"
  fi
}

# Git configuration
create_symlink "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

# Shell configuration
create_symlink "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"

# Terminal configuration
create_symlink "$DOTFILES_DIR/terminal/hyper.js" "$HOME/.hyper.js"

# VS Code settings (if VS Code is installed)
if [ -d "$HOME/Library/Application Support/Code/User" ]; then
  VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
  create_symlink "$DOTFILES_DIR/editors/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
  echo -e "${GREEN}VS Code settings linked${NC}"
fi

# Cursor settings (if Cursor is installed)
if [ -d "$HOME/Library/Application Support/Cursor/User" ]; then
  CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
  create_symlink "$DOTFILES_DIR/editors/cursor/user-rules-01.txt" "$CURSOR_USER_DIR/user-rules-01.txt"
  create_symlink "$DOTFILES_DIR/editors/cursor/user-rules-02.txt" "$CURSOR_USER_DIR/user-rules-02.txt"
  echo -e "${GREEN}Cursor settings linked${NC}"
fi

echo -e "${GREEN}Dotfiles installation complete!${NC}"
echo -e "${YELLOW}Please restart your terminal for changes to take effect.${NC}"
