#!/bin/bash

set -e

echo "🚀 Starting dotfiles setup..."

# =====================================
# Homebrew
# =====================================
if ! command -v brew &> /dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

brew update

# =====================================
# Packages
# =====================================
echo "📦 Installing packages..."

brew install \
  git \
  fnm \
  direnv \
  bat \
  eza \
  ripgrep \
  fd \
  htop \
  lazygit \
  fzf \
  zoxide

brew install --cask \
  iterm2 \
  visual-studio-code \
  font-fira-code \
  orbstack

# =====================================
# Node setup
# =====================================
echo "🧠 Setting up Node..."

corepack enable
fnm install --lts
fnm use lts

# =====================================
# Symlinks
# =====================================
echo "🔗 Linking dotfiles..."

ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

# =====================================
# Zinit
# =====================================
if [ ! -d "$HOME/.zinit" ]; then
  echo "⚡ Installing Zinit..."
  git clone https://github.com/zdharma/zinit ~/.zinit
fi

# =====================================
# Done
# =====================================
echo "✅ Setup complete!"
echo "👉 Restart your terminal"
