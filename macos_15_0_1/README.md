# macos 15.0.1

## Description

Basic setup for macOS

- Homebrew
- Oh My Zsh, zsh-autosuggestions, Powerlevel10k
- Node.js, Nvm, Yarn
- iTerm2
- other useful packages

## Install

```
curl -s -L https://raw.githubusercontent.com/aumbadgah/dotfiles/refs/heads/master/macos_15_0_1/install.sh | bash
```

## tmux short-keys

    prefix Ctrl+x

    prefix+. split new pane vertically

    prefix+/ split new pane horizontally

    prefix+hjkl move to pane

    prefix+r reload ~/.tmux.conf and ~/.zshrc in all panes

## zsh plugins

### copy buffer

copy text currently on the command line

```
CTRL + o
```

### copy path

copies the path of given directory or file to the system clipboard.

```
copypath
```

### copy file

```
copyfile ~/.zshrc
```

### history

print history

```
h
```

search history with grep

```
hs [searchterm]
```

search history with grep, case insensitive

```
hsi [serachterm]
```

### json tools

pretty json

```
curl https://api.chucknorris.io/jokes/random | pp_json
```

### sudo

hit Escape twice to repeat the previous command with `sudo`

```
Esc + Esc
```
