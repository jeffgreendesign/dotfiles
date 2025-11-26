#!/usr/bin/env bash
# Complete setup script for new machine
# Run this on a fresh macOS installation

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

DOTFILES_DIR="$HOME/dotfiles"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Dotfiles Restoration Script${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

###############################################################################
# 1. Install Homebrew                                                         #
###############################################################################

if ! command -v brew &> /dev/null; then
  echo -e "${YELLOW}Installing Homebrew...${NC}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for Apple Silicon Macs
  if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo -e "${GREEN}Homebrew already installed${NC}"
fi

###############################################################################
# 2. Install packages from Brewfile                                          #
###############################################################################

if [ -f "$DOTFILES_DIR/packages/Brewfile" ]; then
  echo -e "${YELLOW}Installing packages from Brewfile...${NC}"
  brew bundle --file="$DOTFILES_DIR/packages/Brewfile"
else
  echo -e "${RED}Brewfile not found. Skipping package installation.${NC}"
fi

###############################################################################
# 3. Install Oh My Zsh                                                        #
###############################################################################

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo -e "${YELLOW}Installing Oh My Zsh...${NC}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  # Install zsh-autosuggestions plugin
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  # Install zsh-syntax-highlighting plugin
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  echo -e "${GREEN}Oh My Zsh already installed${NC}"
fi

###############################################################################
# 4. Create symlinks                                                          #
###############################################################################

echo -e "${YELLOW}Creating symlinks...${NC}"
bash "$DOTFILES_DIR/scripts/install.sh"

###############################################################################
# 5. Install VS Code extensions                                              #
###############################################################################

if command -v code &> /dev/null && [ -f "$DOTFILES_DIR/editors/vscode/extensions.txt" ]; then
  echo -e "${YELLOW}Installing VS Code extensions...${NC}"
  while IFS= read -r extension; do
    code --install-extension "$extension" --force
  done < "$DOTFILES_DIR/editors/vscode/extensions.txt"
else
  echo -e "${YELLOW}Skipping VS Code extensions (code CLI not found or extensions.txt missing)${NC}"
fi

###############################################################################
# 6. Install Cursor extensions                                               #
###############################################################################

if command -v cursor &> /dev/null && [ -f "$DOTFILES_DIR/editors/cursor/extensions.txt" ]; then
  echo -e "${YELLOW}Installing Cursor extensions...${NC}"
  while IFS= read -r extension; do
    cursor --install-extension "$extension" --force
  done < "$DOTFILES_DIR/editors/cursor/extensions.txt"
else
  echo -e "${YELLOW}Skipping Cursor extensions (cursor CLI not found or extensions.txt missing)${NC}"
fi

###############################################################################
# 7. Set macOS defaults                                                       #
###############################################################################

echo ""
read -p "Would you like to set macOS defaults? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  bash "$DOTFILES_DIR/scripts/setup-macos.sh"
fi

###############################################################################
# Done!                                                                       #
###############################################################################

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Restoration complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Update git/gitconfig with your name and email"
echo "2. Restart your terminal"
echo "3. Configure any application-specific settings"
echo "4. Set up SSH keys if needed"
echo ""
echo -e "${BLUE}Happy coding!${NC}"
