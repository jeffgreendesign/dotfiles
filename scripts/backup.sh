#!/usr/bin/env bash
# Backup existing dotfiles before installation

set -e

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
  cp "$HOME/Library/Application Support/Cursor/User/"*.txt "$BACKUP_DIR/cursor/" 2>/dev/null || true
fi

echo "Backup complete: $BACKUP_DIR"
