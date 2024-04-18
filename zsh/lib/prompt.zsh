#!/bin/sh

autoload -Uz vcs_info

# enable only git 
zstyle ':vcs_info:*' enable git 

# setup a hook that runs before every ptompt (slows down zsh on epita computers)
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# add a function to check for untracked files in the directory.
# from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# 
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        # This will show the marker if there are any untracked files in repo.
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})"



# Timer on right side of terminal
# function preexec() {
#   timer=${timer:-$SECONDS}
# }
#
# function precmd() {
#   if [ $timer ]; then
#     timer_show=$(($SECONDS - $timer))
#     export RPROMPT="%F{cyan}${timer_show}s %{$reset_color%}"
#     unset timer
#   fi
# }

# Prompt with user@hostname
# PROMPT="
# %B%{$fg[blue]%}╭─[%{$fg[green]%}%n@%m%{$fg[blue]%}]-%{$fg[blue]%}[%{$fg[green]%}%~%{$fg[blue]%}]%{$reset_color%}\$vcs_info_msg_0_
# %B%{$fg[blue]%}╰──╼ %{$reset_color%}"

# Prompt with user
# PROMPT="
# %B%{$fg[blue]%}╭─[%{$fg[green]%}%n%{$fg[blue]%}]-%{$fg[blue]%}[%{$fg[green]%}%~%{$fg[blue]%}]%{$reset_color%}\$vcs_info_msg_0_
# %B%{$fg[blue]%}╰──╼ %{$reset_color%}"


# Prompt without user@hostname
PROMPT="
%B%{$fg[blue]%}╭─%{$fg[blue]%}[%{$fg[green]%}%~%{$fg[blue]%}]%{$reset_color%}\$vcs_info_msg_0_
%B%{$fg[blue]%}╰──%(?:%{$fg[blue]%}╼:%{$fg[red]%}╼) %{$reset_color%}"


