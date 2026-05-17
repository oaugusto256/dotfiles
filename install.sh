#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# =====================================
# LOGGING
# =====================================
log()   { echo -e "\033[1;32m[INFO]\033[0m $1"; }
warn()  { echo -e "\033[1;33m[WARN]\033[0m $1"; }
error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; }

exists() { command -v "$1" >/dev/null 2>&1; }

log "Starting setup from $DOTFILES_DIR..."

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
brew install --cask iterm2 visual-studio-code orbstack || true

# =====================================
# FIRA CODE FONT
# =====================================
FIRA_VERSION=$(curl -fsSL "https://api.github.com/repos/tonsky/FiraCode/releases/latest" \
  | grep '"tag_name"' \
  | sed 's/.*"tag_name": "\(.*\)".*/\1/')
FONTS_DIR="$HOME/Library/Fonts"

if ls "$FONTS_DIR"/FiraCode* >/dev/null 2>&1; then
  log "Fira Code already installed"
else
  log "Installing Fira Code $FIRA_VERSION..."
  curl -fLo /tmp/FiraCode.zip \
    "https://github.com/tonsky/FiraCode/releases/download/${FIRA_VERSION}/Fira_Code_v${FIRA_VERSION}.zip"
  unzip -qo /tmp/FiraCode.zip "ttf/*" -d /tmp/FiraCode
  cp /tmp/FiraCode/ttf/*.ttf "$FONTS_DIR/"
  rm -rf /tmp/FiraCode /tmp/FiraCode.zip
  log "Fira Code installed"
fi

# =====================================
# NODE SETUP
# =====================================
log "Setting up Node..."

# first eval wires fnm into PATH; second (after fnm use) activates the chosen node
eval "$(fnm env)"

if ! fnm list | grep -q "v24"; then
  log "Installing Node 24..."
  fnm install 24
else
  log "Node 24 already installed"
fi

fnm default 24 || true
fnm use 24 || true

eval "$(fnm env)"

# =====================================
# PNPM (via corepack)
# =====================================
if exists corepack; then
  log "Enabling corepack and activating pnpm..."
  corepack enable
  corepack prepare pnpm@latest --activate
else
  warn "Corepack not found — run after restarting terminal: corepack enable && corepack prepare pnpm@latest --activate"
fi

# =====================================
# ZINIT
# =====================================
if [ ! -d "$HOME/.zinit" ]; then
  log "Installing Zinit..."
  git clone https://github.com/zdharma-continuum/zinit ~/.zinit
else
  log "Zinit already installed"
fi

# =====================================
# SYMLINKS
# =====================================
log "Linking dotfiles..."

mkdir -p ~/.ssh
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/ssh/config" ~/.ssh/config
chmod 600 "$DOTFILES_DIR/ssh/config"

log "Symlinks created:"
log "  ~/.zshrc -> $DOTFILES_DIR/zsh/.zshrc"
log "  ~/.gitconfig -> $DOTFILES_DIR/git/.gitconfig"
log "  ~/.ssh/config -> $DOTFILES_DIR/ssh/config"

# =====================================
# ORBSTACK (Docker)
# =====================================
if [ -d "/Applications/OrbStack.app" ]; then
  log "Launching OrbStack to initialize Docker CLI..."
  open -a OrbStack
  warn "Complete OrbStack's first-run setup in the UI to enable the 'docker' command"
fi

# =====================================
# VERIFY
# =====================================
log "Verifying installation..."

verify() {
  if exists "$1"; then
    log "  ✓ $1"
  else
    warn "  ✗ $1 (may require terminal restart)"
  fi
}

verify git
verify brew
verify node
verify pnpm
verify docker
verify fnm
verify direnv

# =====================================
# DONE
# =====================================
log "Setup complete! Restart your terminal to apply all changes."
