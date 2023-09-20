#!/usr/bin/env zsh
#
# Base dir as path relative to $HOME directory
DIR="${0:a:h}"

function msg() {
	case "$1" in
		ERROR) print -Pn '%F{red}' ;;
		SKIP) print -Pn '%F{yellow}' ;;
		OK) print -Pn '%F{green}' ;;
	esac

	[[ -n "$2" ]] && print -n "[$1: $2]" || print -n "[$1]"
	print -P %f
}


function symlink::link() {
  zmodload zsh/stat

	local error symlink
	local srcfile destfile

	srcfile=$1
	destfile=$2

	if [[ -h "$destfile" ]]; then
		symlink="$(zstat +link "$destfile")"
		if [[ "$symlink" == "$srcfile" ]]; then
			msg SKIP "file already symlinked"
			continue
		else
			echo -n "(old@ -> $symlink)"
		fi
	fi

	mkdir -p "${destfile:h}"
	if error="$(ln -nsf "$srcfile" "$destfile" 2>&1)"; then
		msg OK
	elif [[ -f "$destfile" ]]; then
		msg ERROR "destination already exists (file)"
	elif [[ -d "$destfile" ]]; then
		msg ERROR "destination already exists (dir)"
	else
		msg ERROR "$error"
	fi
}

# Files to be symlinked to home directory
local -A dotfiles
dotfiles=(
	terminal/zshrc              ".zshrc"
	modules/ohmytmux/.tmux.conf ".tmux.conf"
	cfg/tmux.conf.local         ".tmux.conf.local"
	cfg/gitignore_global        ".gitignore_global"
	cfg/gitconfig               ".gitconfig"
	cfg/hammerspoon.lua         ".hammerspoon/init.lua"
	cfg/starship.toml           ".config/starship.toml"
)


local file
for file (${(ko)dotfiles}); do
	echo -n "symlinking $file... "
	symlink::link "$DIR/$file" "$HOME/${dotfiles[$file]}"
done

if [[ $(uname -s) == "Darwin" ]]; then

  echo "Installing Command Line Developer Tools if not installed"
  if ! [ -d /Library/Developer/CommandLineTools ]; then
    echo "🙏 Please, click on Install & Agree to accept the Command Line Developer Tools License Agreement"
    sleep 1
    xcode-select --install
    read -rp "👀 Press enter once the installation finishes" not_needed_param
  else
    echo "✅ Command Line Developer Tools are already installed!"
  fi

  echo "⚡️ Installing brew if not installed"
  if ! [ -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  echo "⚡️ Install bun"
	curl -fsSL https://bun.sh/install | bash

  sh scripts/install-brew-apps.sh

  sh scripts/osx-defaults.sh

  echo "🧐 Fixing paths in order to handle all with \$PATH"
  sudo truncate -s 0 /etc/paths
fi

GIT_LOCAL="$HOME/.gitconfig_local"
if ! test -f "$GIT_LOCAL"; then
  touch $GIT_LOCAL
	echo "📝 Edit ~/.gitconfig_local to add name and email"
fi

# Force load by default
tmux source-file ~/.tmux.conf
