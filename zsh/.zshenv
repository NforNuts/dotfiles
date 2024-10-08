export LANG=ja_JP.UTF-8
export GOENV=$HOME/.config/go/env

eval "$(/opt/homebrew/bin/brew shellenv)"

path=(
  ~/.cargo/bin
  ~/.local/bin
  $(/opt/homebrew/bin/go env GOBIN)
  $path
  )
. "$HOME/.cargo/env"
