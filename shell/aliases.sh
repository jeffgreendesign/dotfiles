# Shell aliases
# Sourced by .zshrc

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# ls aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# Git shortcuts (in addition to git aliases)
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'

# Common shortcuts
alias c='clear'
alias h='history'

# VS Code
alias code.='code .'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Directory listing with colors
alias ls='ls -G'  # macOS
# alias ls='ls --color=auto'  # Linux

# Network
alias ip='curl ifconfig.me'
alias localip='ipconfig getifaddr en0'  # macOS

# System
alias reload='source ~/.zshrc'

# Developer tools
alias npmg='npm list -g --depth=0'  # List global npm packages
alias brewup='brew update && brew upgrade && brew cleanup'

# TODO: Add your custom aliases
