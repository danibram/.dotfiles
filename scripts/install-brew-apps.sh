#!/usr/bin/env sh

echo "📦 Installing brew apps"
brew bundle --file="$DOTFILES_PATH/cfg/Brewfile"
