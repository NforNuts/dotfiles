# Zshがインタラクティブシェルとして起動しているか確認
# if [[ $- == *i* ]]; then
#   # インタラクティブシェルの場合のみnushellを起動
#   exec nu
# fi

eval "$(/opt/homebrew/bin/brew shellenv)"

export VI_MODE_SET_CURSOR=true

path=(
  ~/.cargo/bin
  ~/.local/bin
  $(/opt/homebrew/bin/go env GOBIN)
  $path
  )
. "$HOME/.cargo/env"

bindkey -e

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

FPATH=~/.local/share/zsh:$FPATH

export FZF_CTRL_R_OPTS="--height=40% --reverse --border"
export FZF_CTRL_T_OPTS="--height=40% --preview 'bat --color=always --style=header,grid --line-range :100 {}' --reverse --border --walker-skip Library,.git,node_modules,target,.cache"
export FZF_DEFAULT_OPTS="--height=40% --reverse --border"

export EDITOR=nvim

autoload -Uz compinit && compinit

nfz() {
  nvim $(rg -l $1 | fzf)
}
nfzh() {
  nvim $(rg -.l $1 | fzf)
}

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
