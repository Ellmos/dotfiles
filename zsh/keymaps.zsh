bindkey '^e' edit-command-line

bindkey "\033[1;3C" forward-word  # Alt + Right Arrow
bindkey "\033[1;3D" backward-word # Alt + Left Arrow
bindkey "^[[1;5C" forward-word     # Ctrl + Right Arrow
bindkey "^[[1;5D" backward-word    # Ctrl + Left Arrow

bindkey "\033\177" backward-kill-word # Alt + Backspace
bindkey "\u0017" backward-kill-word # Unicode Private Use Area (alacritty config mapped ctrl-backspace to this)

bindkey "\033[A" up-line-or-beginning-search   # Up Arrow
bindkey "\033[B" down-line-or-beginning-search # Down Arrow
