# dotfiles

Personal development environment configuration and setup automation.

## Quick Start

### Fresh Machine Setup

```bash
# 1. Clone this repository
git clone https://github.com/jeffgreendesign/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Run the complete restoration script
./scripts/restore.sh
```

This will install Homebrew, all packages, Oh My Zsh, create symlinks, and optionally set macOS defaults.

### Existing Machine Setup

```bash
# 1. Backup existing dotfiles (recommended)
./scripts/backup.sh

# 2. Install symlinks only
./scripts/install.sh

# 3. Restart your terminal
```

## Repository Structure

```text
dotfiles/
├── editors/              # Editor configurations
│   ├── vscode/          # Visual Studio Code
│   │   ├── settings.json
│   │   └── extensions.txt
│   └── cursor/          # Cursor AI editor
│       ├── extensions.txt
│       ├── user-rules-01.txt
│       └── user-rules-02.txt
├── git/                 # Git configuration
│   ├── gitconfig        # Global git config (symlinked to ~/.gitconfig)
│   ├── gitignore        # Project-level ignores
│   └── gitignore_global # Global ignore patterns
├── shell/               # Shell configuration
│   ├── zshrc            # Zsh configuration (symlinked to ~/.zshrc)
│   ├── aliases.sh       # Command aliases
│   └── functions.sh     # Custom shell functions
├── terminal/            # Terminal emulator configs
│   └── hyper.js         # Hyper terminal config
├── ai-prompts/          # AI coding assistant prompts
│   └── react-native-expo.txt
├── packages/            # Package manifests
│   ├── Brewfile         # Homebrew packages
│   └── npm-global.txt   # Global npm packages
├── scripts/             # Automation scripts
│   ├── install.sh       # Create symlinks
│   ├── backup.sh        # Backup existing configs
│   ├── restore.sh       # Complete setup for new machine
│   ├── setup-macos.sh   # macOS system defaults
│   ├── brew-export.sh   # Export Brewfile
│   └── vscode-export.sh # Export editor extensions
└── README.md
```

## Scripts

### `restore.sh` - Complete Machine Setup

Full installation script for setting up a new machine from scratch.

```bash
./scripts/restore.sh
```

**This script will:**
- Install Homebrew (if not present)
- Install packages from Brewfile
- Install Oh My Zsh with plugins
- Create symlinks for all configs
- Install VS Code/Cursor extensions
- Optionally set macOS defaults

### `install.sh` - Create Symlinks

Creates symbolic links from dotfiles to their expected locations.

```bash
./scripts/install.sh
```

**Creates symlinks for:**
- Git config → `~/.gitconfig`
- Global gitignore → `~/.gitignore_global`
- Zsh config → `~/.zshrc`
- Hyper terminal → `~/.hyper.js`
- VS Code settings → `~/Library/Application Support/Code/User/`
- Cursor settings → `~/Library/Application Support/Cursor/User/`

### `backup.sh` - Backup Existing Files

Backs up your current dotfiles before installation.

```bash
./scripts/backup.sh
```

Creates timestamped backup directory with existing configs.

### `setup-macos.sh` - macOS System Preferences

Automates macOS system settings and preferences.

```bash
./scripts/setup-macos.sh
```

**Configures:**
- Finder: Column view, show extensions, show hidden files
- Screenshots: Naming convention, format, location
- Dock: Size, auto-hide, animation speed
- Safari: Developer tools, privacy settings
- And more...

### `brew-export.sh` - Export Homebrew Packages

Generates Brewfile from currently installed packages.

```bash
./scripts/brew-export.sh
```

Run this after installing new Homebrew packages to keep Brewfile updated.

### `vscode-export.sh` - Export Editor Extensions

Updates extension lists for VS Code and Cursor.

```bash
./scripts/vscode-export.sh
```

Run this after installing new extensions to keep lists current.

## Configuration Files

### Shell (Zsh)

**Location:** `shell/zshrc`
**Symlinks to:** `~/.zshrc`

Includes:
- Oh My Zsh configuration
- Plugin management
- Path configuration for Homebrew (Intel & Apple Silicon)
- Sources aliases and functions

**Customize:**
- Edit `shell/aliases.sh` for command shortcuts
- Edit `shell/functions.sh` for custom shell functions
- Update Oh My Zsh theme and plugins in `shell/zshrc`

### Git

**Locations:**
- `git/gitconfig` → `~/.gitconfig`
- `git/gitignore_global` → `~/.gitignore_global`

**Before first use:**

```bash
# Update with your information
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

**Includes:**
- Useful git aliases (gs, gco, gp, etc.)
- Diff and merge configurations
- Color settings
- Global ignore patterns

### VS Code

**Location:** `editors/vscode/`

**Manual installation of extensions:**

```bash
while IFS= read -r ext; do code --install-extension "$ext"; done < editors/vscode/extensions.txt
```

**Settings sync:**
- Settings are symlinked automatically by `install.sh`
- Export new settings: Copy from `~/Library/Application Support/Code/User/settings.json`

### Cursor

**Location:** `editors/cursor/`

User rules define AI behavior and coding standards:
- `user-rules-01.txt` - General coding practices
- `user-rules-02.txt` - Additional guidelines

### Homebrew Packages

**Location:** `packages/Brewfile`

**Install packages:**

```bash
brew bundle --file="$DOTFILES_DIR/packages/Brewfile"
```

**Update Brewfile:**

```bash
./scripts/brew-export.sh
```

## Maintenance

### Keep Dotfiles Updated

```bash
# Export current Homebrew packages
./scripts/brew-export.sh

# Export current editor extensions
./scripts/vscode-export.sh

# Commit changes
git add .
git commit -m "Update package lists"
git push
```

### Update System Packages

```bash
# Update Homebrew packages
brew update && brew upgrade && brew cleanup

# Update global npm packages
npm update -g

# Update Oh My Zsh
omz update
```

## Programs

### Essential Applications

**Installed via Homebrew (see `packages/Brewfile`):**
- Git
- Visual Studio Code
- Hyper Terminal
- Chrome, Firefox
- Android Studio
- Google Drive
- DisplayLink Manager
- Zoom

**Manual Installation Required:**
- Adobe Creative Cloud
- Password Manager (1Password, LastPass, etc.)
- VPN Client
- Xcode (from Mac App Store)

**Utilities:**
- Amphetamine - Keep computer awake
- ColorSlurp - Color picker

### Development Tools

**Shell:**
- Oh My Zsh - Zsh framework
- zsh-autosuggestions - Command suggestions
- zsh-syntax-highlighting - Syntax highlighting

**CLI Tools:**
- bat - Better `cat`
- exa - Better `ls`
- fzf - Fuzzy finder
- ripgrep - Better `grep`
- tldr - Simplified man pages

## MCP Servers

AI-powered development tools:

- [GitHub MCP Server](https://github.com/github/github-mcp-server)
- [Shopify Dev MCP Server](https://github.com/Shopify/dev-mcp)

## Troubleshooting

### Symlinks Not Working

```bash
# Remove broken symlinks
rm ~/.zshrc ~/.gitconfig ~/.hyper.js

# Re-run install
./scripts/install.sh
```

### VS Code Extensions Not Installing

```bash
# Ensure VS Code CLI is in PATH
code --version

# Install manually
while IFS= read -r ext; do
  code --install-extension "$ext" --force
done < editors/vscode/extensions.txt
```

### Oh My Zsh Plugin Issues

```bash
# Reinstall plugins
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Clone again
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Homebrew Permission Issues

```bash
# Fix permissions
sudo chown -R $(whoami) /usr/local/share/zsh /usr/local/share/zsh/site-functions
chmod u+w /usr/local/share/zsh /usr/local/share/zsh/site-functions
```

## macOS Setup Checklist

- [ ] Run `./scripts/restore.sh` for complete setup
- [ ] Update `git/gitconfig` with your name and email
- [ ] Install manual applications (Adobe CC, password manager, VPN)
- [ ] Set up SSH keys (`ssh-keygen -t ed25519 -C "your.email@example.com"`)
- [ ] Configure file type associations
- [ ] Sign in to all applications
- [ ] Set up browser profiles and sync
- [ ] Configure System Preferences not covered by scripts

## Contributing

This is a personal dotfiles repository, but feel free to fork and adapt for your own use!

### Adding New Configurations

1. Add config file to appropriate directory
2. Update `scripts/install.sh` to create symlink
3. Update this README with instructions
4. Commit and push

### Workflow

```bash
# Make changes to dotfiles
vim ~/dotfiles/shell/zshrc

# Changes take effect immediately (symlinked)
source ~/.zshrc

# Commit when satisfied
cd ~/dotfiles
git add .
git commit -m "Update zsh configuration"
git push
```

## Resources

- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [GitHub Dotfiles](https://dotfiles.github.io/)
- [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle)
- [Oh My Zsh](https://ohmyz.sh/)
- [macOS Defaults](https://macos-defaults.com/)

## License

MIT License - See [LICENSE](LICENSE) file for details.
