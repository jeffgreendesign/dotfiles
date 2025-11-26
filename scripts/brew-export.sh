#!/usr/bin/env bash
# Export current Homebrew packages to Brewfile

set -e

# Determine script directory and set Brewfile path relative to repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/../packages/Brewfile"

if ! command -v brew &> /dev/null; then
  echo "Homebrew is not installed"
  exit 1
fi

# Backup existing Brewfile if it exists
if [ -f "$BREWFILE" ]; then
  BACKUP_FILE="${BREWFILE}.backup-$(date +%Y%m%d-%H%M%S)"
  echo "Backing up existing Brewfile to $BACKUP_FILE"
  cp "$BREWFILE" "$BACKUP_FILE"
fi

echo "Exporting Homebrew packages to $BREWFILE"
brew bundle dump --force --file="$BREWFILE"

echo "Brewfile updated successfully!"
echo ""
echo "Contents:"
cat "$BREWFILE"
