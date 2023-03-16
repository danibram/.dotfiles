#!/bin/sh

cdd() {
  cd "$(ls -d -- */ | fzf)" || echo "Invalid directory"
}

dots_update() {
 cd "$DOTFILES_PATH" || exit
  git pull
  git submodule init
  git submodule update
  git submodule status

  for submodule in "$DOTFILES_PATH/modules/"*; do git submodule update --init --recursive --remote --merge "$submodule"; done
  echo "[submodules] Updated!"

  echo "[dots] Updated!"
}

ports() {
  lsof -iTCP -sTCP:LISTEN -i -n -P | grep LISTEN | fzf
}

gch() {
  git checkout "$(git branch | fzf| tr -d '[:space:]')"
}