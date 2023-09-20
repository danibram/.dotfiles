#!/bin/sh

export ANDROID_HOME=$HOME/Library/Android/sdk
export CODE_TSJS=1
export DENO_INSTALL="$HOME/.deno"
export EDITOR="code --wait"
export LC_ALL=es_ES.UTF-8

paths=(
  $HOME/.yarn/bin
  $HOME/.config/yarn/global/node_modules/.bin
  node_modules/.bin
  /bin
  /sbin
  /usr/bin
  /usr/sbin
  /usr/local/bin
  /usr/local/sbin
  $ANDROID_HOME/emulator
  $ANDROID_HOME/tools
  $ANDROID_HOME/tools/bin
  $ANDROID_HOME/platform-tools
  $DENO_INSTALL/bin
  $HOME/.fnm
  $HOME/.zsh/bin,
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /opt/homebrew/opt/python/libexec/bin
  /opt/homebrew/opt/python@3.9/libexec/bin
  $HOME/.cargo/bin
  $HOME/.cargo/env
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
eval "$(fnm env --use-on-cd)"

#########
# gcloud configuration
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.gcloud/path.zsh.inc" ]; then . "$HOME/.gcloud/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.gcloud/completion.zsh.inc" ]; then . "$HOME/.gcloud/completion.zsh.inc"; fi
