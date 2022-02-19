#!/bin/sh

set -ev
set +o noclobber

if [ ! brew ]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update || brew update
brew upgrade
brew install \
	curl \
	git \
	jq \
	libpng \
	node \
	nvm \
	openssl \
	pyenv \
	telnet \
	tig \
	tmux \
	yarn \
	zlib \
	zsh \
	zsh-syntax-highlighting | true
brew cask install iterm2

curl https://raw.githubusercontent.com/aumbadgah/dotfiles/master/macos_10_15_1/.vimrc > ~/.vimrc
curl https://raw.githubusercontent.com/aumbadgah/dotfiles/master/macos_10_15_1/.tmux.conf > ~/.tmux.conf
curl https://raw.githubusercontent.com/aumbadgah/dotfiles/master/macos_10_15_1/.zshrc > ~/.zshrc

curl https://raw.githubusercontent.com/aumbadgah/dotfiles/master/macos_10_15_1/bin/reload-configs > /usr/local/bin/reload-configs
chmod +x /usr/local/bin/reload-configs

