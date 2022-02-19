#!/bin/sh

set -e

echo "**"
echo "** Update, install basics"
echo "**"

apt -y update
apt -y upgrade

apt -y install \
	gcc \
	zsh \
	make \
	vim \
	curl \
	wget \
	git \
	gnupg-agent \
	ca-certificates \
	apt-transport-https \
	build-essential \
	software-properties-common \
	apt-transport-https \
	dkms \
	gnome-tweak-tool

echo "**"
echo "** Install Oh My Zsh"
echo "**"

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
	&& cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
	&& find /home -mindepth 1 -maxdepth 1 -type d -exec cp -rf ~/.oh-my-zsh {} \; \
	&& find /home -mindepth 1 -maxdepth 1 -type d -exec cp ~/.oh-my-zsh/templates/zshrc.zsh-template {}/.zshrc \; \
	&& find /home -mindepth 1 -maxdepth 1 -exec basename {} \; | xargs -n1 chsh -s $(which zsh)

echo "**"
echo "** Install KeePass 2"
echo "**"

apt-add-repository -y ppa:jtaylor/keepass \
	&& apt -y update \
	&& apt -y install keepass2

echo "**"
echo "** Install NordVPN"
echo "**"

cd /tmp \
	&& wget -qnc https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb \
	&& dpkg -i /tmp/nordvpn-release_1.0.0_all.deb \
	&& apt -y update \
	&& wget https://repo.nordvpn.com/gpg/nordvpn_public.asc -O - | sudo apt-key add - \
	&& apt -y install nordvpn

echo "**"
echo "** Install Docker"
echo "**"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
	&& apt-key fingerprint 0EBFCD88 \
	&& add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
	&& apt -y update \
	&& ip link add name docker0 type bridge \
	&& ip addr add dev docker0 172.17.0.1/16 \
	&& apt -y install docker-ce docker-ce-cli containerd.io

echo "**"
echo "** Install VS Code"
echo "**"

wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add - \
	&& add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" \
	&& apt -y update \
	&& apt -y install code

echo "**"
echo "** Install USB Wifi adapter (rtl88x2BU) driver"
echo "**"

cd /tmp \
	&& git clone https://github.com/cilynx/rtl88x2BU_WiFi_linux_v5.3.1_27678.20180430_COEX20180427-5959.git \
	&& cd /tmp/rtl88x2BU_WiFi_linux_v5.3.1_27678.20180430_COEX20180427-5959 \
	&& VER=$(sed -n 's/\PACKAGE_VERSION="\(.*\)"/\1/p' dkms.conf) \
	&& rsync -rvhP ./ /usr/src/rtl88x2bu-${VER} \
	&& dkms add -m rtl88x2bu -v ${VER} \
	&& dkms build -m rtl88x2bu -v ${VER} \
	&& dkms install -m rtl88x2bu -v ${VER} \
	&& modprobe 88x2bu

echo "**"
echo "** Install Brave"
echo "**"

curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - \
	&& sh -c 'echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com `lsb_release -sc` main" >> /etc/apt/sources.list.d/brave.list' \
	&& apt -y update \
	&& apt -y install brave-browser brave-keyring

echo "**"
echo "** Clean dependencies"
echo "**"

apt -y autoremove

