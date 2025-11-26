#!/usr/bin/env bash
# Export VS Code and Cursor extensions

set -e

DOTFILES_DIR="$HOME/dotfiles"

# Export VS Code extensions
if command -v code &> /dev/null; then
  echo "Exporting VS Code extensions..."
  code --list-extensions > "$DOTFILES_DIR/editors/vscode/extensions.txt"
  echo "VS Code extensions exported to editors/vscode/extensions.txt"
else
  echo "VS Code CLI not found. Skipping VS Code export."
fi

# Export Cursor extensions (if cursor command exists)
if command -v cursor &> /dev/null; then
  echo "Exporting Cursor extensions..."
  cursor --list-extensions > "$DOTFILES_DIR/editors/cursor/extensions.txt"
  echo "Cursor extensions exported to editors/cursor/extensions.txt"
else
  echo "Cursor CLI not found. Skipping Cursor export."
fi

echo "Export complete!"
