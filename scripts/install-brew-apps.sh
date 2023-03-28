#!/usr/bin/env sh

echo "📦 Installing brew apps"
# All apps (This line is repeated because there are dependencies between brew cask and brew)
brew bundle --file="$DOTFILES_PATH/cfg/Brewfile" || true

echo "😅 Installing brew apps again because it might fail the first time because of dependencies."
echo "☝️ Check in MacOS Security & Privacy settings if MacOS is not allowing to install any third party software"
brew bundle --file="$DOTFILES_PATH/cfg/Brewfile"
