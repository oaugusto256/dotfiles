# =====================================
# BASIC ENV
# =====================================
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# =====================================
# FNM (Node)
# =====================================
eval "$(fnm env --use-on-cd)"

# =====================================
# LOAD ZINIT
# =====================================
if [[ -f "$HOME/.zinit/zinit.zsh" ]]; then
  source "$HOME/.zinit/zinit.zsh"
else
  echo "[warn] Zinit not installed. Run: git clone https://github.com/zdharma-continuum/zinit ~/.zinit"
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
zi light zdharma-continuum/fast-syntax-highlighting
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
alias ls="eza --icons"
alias ll="eza -lah --icons --git"
alias tree="eza --tree --level=2 --icons"
alias cat="bat"
alias grep="rg"

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

# =====================================
# TOOLS
# =====================================
eval "$(zoxide init zsh)"
alias cd="z"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"
