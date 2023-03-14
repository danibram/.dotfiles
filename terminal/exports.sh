#!/bin/sh

export ANDROID_HOME=$HOME/Library/Android/sdk
export CODE_TSJS=1
export DENO_INSTALL="$HOME/.deno"
export EDITOR="code --wait"

paths=(
  "$HOME/.yarn/bin"
  "node_modules/.bin"
  "/bin"
  "/usr/local/bin"
  "/usr/bin"
  "/usr/local/sbin"
  "/usr/sbin"
  "/sbin"
  "$ANDROID_HOME/emulator"
  "$ANDROID_HOME/tools"
  "$ANDROID_HOME/tools/bin"
  "$ANDROID_HOME/platform-tools"
  "$DENO_INSTALL/bin"
  "$HOME/.fnm"
  "$HOME/.zsh/bin",
  "$HOME/.cargo/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "/opt/homebrew/opt/python/libexec/bin"
  "$HOME/.cargo/env"
)

PATH=$(
  IFS=":"
  echo "${paths[*]}"
)

# remove duplicate entries from PATH
[ -n "$ZSH_VERSION" ] && typeset -U path

export PATH

# opam configuration
if [ -f "$HOME/.opam/opam-init/init.zsh" ]; then . $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null; fi


#########
# fnm (NodeJs Version Manager)
eval "$(fnm env)"

#########
# gcloud configuration
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.gcloud/path.zsh.inc" ]; then . "$HOME/.gcloud/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.gcloud/completion.zsh.inc" ]; then . "$HOME/.gcloud/completion.zsh.inc"; fi
