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

curl https://raw.githubusercontent.com/aumbadgah/configs/master/workstation/macos.10.15.1/.vimrc > ~/.vimrc
curl https://raw.githubusercontent.com/aumbadgah/configs/master/workstation/macos.10.15.1/.tmux.conf > ~/.tmux.conf
curl https://raw.githubusercontent.com/aumbadgah/configs/master/workstation/macos.10.15.1/.zshrc > ~/.zshrc

curl https://raw.githubusercontent.com/aumbadgah/configs/master/workstation/macos.10.15.1/bin/configs-install > /usr/local/bin/configs-install
chmod +x /usr/local/bin/configs-install
curl https://raw.githubusercontent.com/aumbadgah/configs/master/workstation/macos.10.15.1/bin/configs-reload > /usr/local/bin/configs-reload
chmod +x /usr/local/bin/configs-reload

