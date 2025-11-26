#!/usr/bin/env bash
# macOS system defaults configuration
# Automates the settings mentioned in the README

set -e

echo "This script will modify system settings and may require administrator privileges."
echo "You may be prompted for your password."
echo ""

echo "Setting macOS defaults..."

# Close System Preferences to prevent conflicts
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (prompt for user input)
# sudo scutil --set ComputerName "Your Computer Name"
# sudo scutil --set HostName "Your-Computer-Name"
# sudo scutil --set LocalHostName "Your-Computer-Name"

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Use column view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

###############################################################################
# Screenshots                                                                 #
###############################################################################

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Change screenshot naming convention
# Format: Screenshot 2024-01-01 at 10.30.45 AM.png
defaults write com.apple.screencapture "include-date" -bool true

###############################################################################
# Dock & Dashboard                                                            #
###############################################################################

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 48

# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don't send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################

echo "macOS defaults set successfully!"
echo "Note: Some changes require a logout/restart to take effect."
echo ""
read -p "Would you like to restart now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Restarting in 10 seconds... Press Ctrl+C to cancel."
  sleep 10
  sudo shutdown -r now
fi
