#!/bin/sh
export ZDOTDIR=$HOME/.config/zsh
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP


# completions
autoload -Uz compinit
zstyle ':completion:*' menu select

# Git completion
zstyle ':completion:*:*:git:*' script ~/.config/zsh//git-completion.bash
fpath=(~/.config/zsh $fpath)
autoload -Uz compinit && compinit

# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist


# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line

# Environment variables set everywhere
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"

# For QT Themes
export QT_QPA_PLATFORMTHEME=qt5ct

# ------------------------------ALIASES--------------------------------
alias ls='ls --color=auto'
alias la='ls -A --color=auto'
alias c='clear'
alias nv='nvim'
alias dz='cd /snap/deezer-unofficial-player/current && ./deezer-unofficial-player &'
alias ocr='cd ~/Desktop/ocr-epita/'
alias shut='sudo shutdown now'

neofetch
