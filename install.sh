#!/bin/bash

set -e

# =====================================
# LOGGING
# =====================================
log() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}

warn() {
  echo -e "\033[1;33m[WARN]\033[0m $1"
}

error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
}

# =====================================
# CHECK COMMAND
# =====================================
exists() {
  command -v "$1" >/dev/null 2>&1
}

# =====================================
# START
# =====================================
log "Starting setup..."

# =====================================
# HOMEBREW
# =====================================
if ! exists brew; then
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  log "Homebrew already installed"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

brew update

# =====================================
# PACKAGES
# =====================================
log "Installing CLI tools..."

brew install git fnm direnv bat eza ripgrep fd htop lazygit fzf zoxide || true

log "Installing apps..."

brew install --cask iterm2 visual-studio-code font-fira-code orbstack || true

# =====================================
# NODE SETUP
# =====================================
log "Setting up Node..."

if ! fnm list | grep -q "v24"; then
  log "Installing Node 24..."
  fnm install 24
else
  log "Node 24 already installed"
fi

fnm default 24 || true
fnm use 24 || true

# =====================================
# COREPACK
# =====================================
if exists corepack; then
  log "Enabling corepack..."
  corepack enable || true
else
  warn "Corepack not found (will be available after Node restart)"
fi

# =====================================
# ZINIT
# =====================================
if [ ! -d "$HOME/.zinit" ]; then
  log "Installing Zinit..."
  git clone https://github.com/zdharma/zinit ~/.zinit
else
  log "Zinit already installed"
fi

# =====================================
# SYMLINKS
# =====================================
log "Linking dotfiles..."

ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

# =====================================
# DONE
# =====================================
log "Setup complete!"
log "Restart your terminal 🚀"
