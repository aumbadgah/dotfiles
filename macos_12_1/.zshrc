plugins=(
  copybuffer
  copydir
  copyfile
  dirhistory
  git
  history
  jsontools
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-vi-mode
)

bindkey -v

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$(echo $HOME)/.oh-my-zsh"

# ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

if [ ! -d $ZSH/themes/powerlevel10k ]; then
	git clone --single-branch https://github.com/romkatv/powerlevel10k.git $ZSH/themes/powerlevel10k
fi

export PATH="/usr/local/sbin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
