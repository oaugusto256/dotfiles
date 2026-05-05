# 🧰 Dotfiles

Personal development environment setup for macOS (Apple Silicon).

> Fast, reproducible and CLI-first.

---

## 🚀 Quick Start

```bash
git clone git@github.com:YOUR_USERNAME/dotfiles.git
cd dotfiles
./install.sh
```

Restart your terminal after installation.

---

## 🧠 Philosophy

* Keep it fast ⚡
* Prefer CLI over GUI 🖥️
* Deterministic environments 🔒
* Minimal magic, maximum control

---

## 🧱 What This Sets Up

### Core

* Homebrew
* Git
* fnm
* corepack

### Terminal

* Zsh + Zinit
* Spaceship prompt
* FZF
* Zoxide

### CLI Tools

* bat, eza, ripgrep, fd
* htop, lazygit

### Apps

* iTerm2
* Visual Studio Code
* OrbStack
* Fira Code

---

## ⚙️ Structure

```
dotfiles/
├── zsh/
├── git/
├── install.sh
└── README.md
```

---

## 🧠 Node Strategy

Uses fixed version for consistency.

```bash
fnm install 24
fnm default 24
```

Per project:

```bash
echo "24" > .node-version
fnm use
```

---

## 🔗 Symlinks

Managed automatically:

* ~/.zshrc
* ~/.gitconfig

---

## 🔄 Updating

```bash
git pull
./install.sh
```

---

## 🧪 Verify

```bash
node -v
pnpm -v
git --version
docker ps
```

---

## 🖼️ Preview

*(optional: add screenshots here later)*

---

## 🚀 Roadmap

* [ ] Brewfile support
* [ ] VSCode extensions auto-install
* [ ] Stow integration
* [ ] Project templates

---

## 👨‍💻 Author

Otavio Augusto

