#!/bin/sh
export ZDOTDIR=$HOME/.config/zsh
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef     # Disable ctrl-s to freeze terminal.
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

# compinit
_comp_options+=(globdots)       # Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-prompt"
zsh_add_file "zsh-aliases"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# For QT Themes
export QT_QPA_PLATFORMTHEME=qt5ct

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word


fpath+=~/.zfunc
[ -f "/home/elmos/.ghcup/env" ] && source "/home/elmos/.ghcup/env" # ghcup-env

source "$ZDOTDIR/zsh_exports"

# neofetch
fastfetch
