export ZSH="$(echo $HOME)/.oh-my-zsh"

# ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

if [ ! -d $ZSH/themes/powerlevel10k ]; then
	git clone --single-branch https://github.com/romkatv/powerlevel10k.git $ZSH/themes/powerlevel10k
fi

export PATH="/usr/local/sbin:$PATH"

if [ nvm ]; then
	export NVM_DIR="$HOME/.nvm"
	. "/usr/local/opt/nvm/nvm.sh"

	# place this after nvm initialization!
	autoload -U add-zsh-hook
	load-nvmrc() {
  		if [[ -f .nvmrc && -r .nvmrc ]]; then
    			nvm use
  		elif [[ $(nvm version) != $(nvm version default)  ]]; then
    			echo "Reverting to nvm default version"
    			nvm use default
  		fi
	}
	add-zsh-hook chpwd load-nvmrc
	load-nvmrc
fi

if [ -d '/usr/local/opt/zlib' ]; then
	export LDFLAGS="${LDFLAGS} -L/usr/local/opt/zlib/lib"
	export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/zlib/include"
	export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig"
fi

if [ -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
	POWERLEVEL9K_MODE="awesome-patched"
fi

if [ -d "$ZSH_CUSTOM/themes/powerlevel9k" ] || [ -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
	POWERLEVEL9K_PROMPT_ON_NEWLINE=true
	POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
	local user_symbol="$"
	if [[ $(print -P "%#") =~ "#" ]]; then
    		user_symbol = "#"
	fi
	POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"
	POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
fi

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
