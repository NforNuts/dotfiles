# starship initialization
eval "$(starship init zsh)"

# zoxide initialization
eval "$(zoxide init zsh)"

# zabrze initialization
eval "$(zabrze init --bind-keys)"

source <(fzf --zsh)

# nvm initialization
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

export FZF_CTRL_R_OPTS="--height=40% --reverse --border"
export FZF_CTRL_T_OPTS="--height=40% --preview 'bat --color=always --style=header,grid --line-range :100 {}' --reverse --border"

autoload -Uz compinit && compinit

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt share_history
setopt inc_append_history

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

setopt auto_cd

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
