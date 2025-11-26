#!/usr/bin/env bash
# Export current Homebrew packages to Brewfile

set -e

BREWFILE="$HOME/dotfiles/packages/Brewfile"

if ! command -v brew &> /dev/null; then
  echo "Homebrew is not installed"
  exit 1
fi

echo "Exporting Homebrew packages to $BREWFILE"
brew bundle dump --force --file="$BREWFILE"

echo "Brewfile updated successfully!"
echo ""
echo "Contents:"
cat "$BREWFILE"
