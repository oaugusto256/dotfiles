# Dotfiles

Personal development environment setup for macOS (Apple Silicon).

> Fast, reproducible and CLI-first.

---

## Prerequisites

- macOS Tahoe (Apple Silicon)
- An internet connection

### Bootstrap (fresh machine)

On a fresh Mac you won't have Git yet. Install Homebrew first — it brings Git along:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then clone and run the setup script:

```bash
git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Restart your terminal after installation.

---

## Philosophy

- Keep it fast
- Prefer CLI over GUI
- Deterministic environments
- Minimal magic, maximum control

---

## What This Sets Up

### Core

- Homebrew
- Git
- fnm + Node 24
- pnpm (via corepack)

### Terminal

- Zsh + Zinit
- Spaceship prompt
- FZF
- Zoxide

### CLI Tools

- bat, eza, ripgrep, fd
- htop, lazygit, direnv

### Apps

- iTerm2
- Visual Studio Code
- OrbStack (Docker)
- Fira Code font

---

## Structure

```
dotfiles/
├── zsh/
│   └── .zshrc
├── git/
│   └── .gitconfig
├── install.sh
└── README.md
```

---

## Node Strategy

Uses a fixed version for consistency.

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

## Symlinks

Managed automatically by `install.sh`, relative to wherever the repo is cloned:

- `~/.zshrc`
- `~/.gitconfig`

---

## Docker

OrbStack is installed automatically, but the `docker` CLI requires completing OrbStack's first-run setup in its UI. The install script will open OrbStack — follow the prompts, then `docker ps` will work.

---

## Updating

```bash
git pull
./install.sh
```

---

## Verify

```bash
git --version
node -v
pnpm -v
docker ps
```

> **Note:** `pnpm` and `docker` may require a terminal restart after first install.

---

## Roadmap

- [ ] Brewfile support
- [ ] VSCode extensions auto-install
- [ ] Stow integration
- [ ] Project templates

---

## Author

Otavio Augusto
