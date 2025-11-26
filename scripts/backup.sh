#!/usr/bin/env bash
# Backup existing dotfiles before installation
# Note: VS Code and Cursor backup paths are macOS-specific

set -e

if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "Warning: This script is optimized for macOS. Some backups may not work on other platforms."
fi

BACKUP_DIR="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

echo "Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# List of files to backup
FILES=(
  "$HOME/.gitconfig"
  "$HOME/.gitignore_global"
  "$HOME/.zshrc"
  "$HOME/.bashrc"
  "$HOME/.bash_profile"
  "$HOME/.hyper.js"
)

for file in "${FILES[@]}"; do
  if [ -f "$file" ] || [ -L "$file" ]; then
    echo "Backing up: $file"
    cp -P "$file" "$BACKUP_DIR/" || echo "Could not backup $file"
  fi
done

# Backup VS Code settings
if [ -d "$HOME/Library/Application Support/Code/User" ]; then
  echo "Backing up VS Code settings..."
  mkdir -p "$BACKUP_DIR/vscode"
  cp "$HOME/Library/Application Support/Code/User/settings.json" "$BACKUP_DIR/vscode/" 2>/dev/null || true
fi

# Backup Cursor settings
if [ -d "$HOME/Library/Application Support/Cursor/User" ]; then
  echo "Backing up Cursor settings..."
  mkdir -p "$BACKUP_DIR/cursor"
  shopt -s nullglob
  for file in "$HOME/Library/Application Support/Cursor/User/"*.txt; do
    [ -e "$file" ] && cp "$file" "$BACKUP_DIR/cursor/" 2>/dev/null || true
  done
  shopt -u nullglob
fi

echo "Backup complete: $BACKUP_DIR"
