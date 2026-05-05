# =====================================
# BASIC ENV
# =====================================
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# =====================================
# LOAD ZI (ZINIT)
# =====================================
if [[ -f "$HOME/.zinit/zi.zsh" ]]; then
  source "$HOME/.zinit/zi.zsh"
else
  echo "Zi not installed. Run:"
  echo "git clone https://github.com/zdharma/zinit ~/.zinit"
  return
fi

# =====================================
# COMPLETIONS
# =====================================
autoload -Uz compinit
compinit

# =====================================
# PLUGINS
# =====================================
zi light zdharma/fast-syntax-highlighting
zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-completions

# =====================================
# PROMPT (SPACESHIP)
# =====================================
zi ice depth=1
zi light spaceship-prompt/spaceship-prompt

SPACESHIP_PROMPT_ORDER=(
  user
  dir
  git
  exec_time
  line_sep
  char
)

SPACESHIP_USER_SHOW=always
SPACESHIP_DIR_TRUNC=3
SPACESHIP_PROMPT_ADD_NEWLINE=false

SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

# =====================================
# FZF (fuzzy finder)
# =====================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# =====================================
# ZOXIDE (smart cd)
# =====================================
eval "$(zoxide init zsh)"
alias cd="z"

# =====================================
# EZA (better ls)
# =====================================
alias ls="eza --icons"
alias ll="eza -lah --icons --git"
alias tree="eza --tree --level=2 --icons"

# =====================================
# NVM (Node)
# =====================================
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# =====================================
# SDKMAN
# =====================================
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# =====================================
# HISTORY
# =====================================
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# =====================================
# KEY BINDINGS
# =====================================
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# =====================================
# ALIASES
# =====================================
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias g="git"
alias gst="git status"
alias gaa="git add ."
alias gcm="git commit -m"
alias gco="git checkout"
alias gcb="git checkout -b"

alias reload="source ~/.zshrc"

eval "$(fnm env)"

# aliases úteis
alias ls="eza --icons"
alias cat="bat"
alias grep="rg"

# navegação inteligente
eval "$(zoxide init zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"

