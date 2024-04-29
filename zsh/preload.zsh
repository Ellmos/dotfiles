autoload -U colors && colors

# completions
zstyle ':completion:*' menu select
autoload -U compinit && compinit

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Edit line in vim with ctrl-e:
autoload edit-command-line
zle -N edit-command-line
