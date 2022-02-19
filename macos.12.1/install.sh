#!/bin/sh

set -ev
set +o noclobber

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew update || brew update
brew upgrade
brew install \
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
	zsh-syntax-highlighting
# iterm2
brew install --cask iterm2

# ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

curl https://raw.githubusercontent.com/aumbadgah/configs/master/workstation/macos.12.1/.zshrc > ~/.zshrc
curl https://raw.githubusercontent.com/aumbadgah/configs/master/workstation/macos.12.1/.zprofile > ~/.zprofile
curl https://raw.githubusercontent.com/aumbadgah/configs/master/workstation/macos.12.1/.vimrc > ~/.vimrc
curl https://raw.githubusercontent.com/aumbadgah/configs/master/workstation/macos.12.1/.tmux.conf > ~/.tmux.conf

sudo bash -c "curl https://raw.githubusercontent.com/aumbadgah/configs/master/workstation/macos.12.1/bin/configs-reload > /usr/local/bin/configs-reload"
sudo chmod +x /usr/local/bin/configs-reload

ssh-keygen -t rsa
