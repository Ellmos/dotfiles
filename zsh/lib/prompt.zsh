#!/bin/sh

autoload -Uz vcs_info

# enable only git 
zstyle ':vcs_info:*' enable git 

# setup a hook that runs before every prompt
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# Disable slow built-in check-for-changes, use custom fast version instead
zstyle ':vcs_info:git:*' check-for-changes false

# Custom fast hook using git plumbing commands (much faster than git status)
zstyle ':vcs_info:git*+set-message:*' hooks git-fast-status

+vi-git-fast-status() {
    # Only run in git repos
    [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == 'true' ]] || return

    local staged="" unstaged=""

    # Check for staged changes (uses git plumbing, very fast)
    # Exit code 1 = changes exist
    git diff-index --cached --quiet HEAD -- 2>/dev/null || staged="S"

    # Check for unstaged changes (uses git plumbing, very fast)
    git diff-files --quiet 2>/dev/null || unstaged="U"

    # Set the markers in hook_com
    hook_com[staged]+="$staged"
    hook_com[unstaged]+="$unstaged"
}

# Custom format for git info in prompt
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})"

# Prompt without user@hostname
PROMPT="
%B%{$fg[blue]%}╭─%{$fg[blue]%}[%{$fg[green]%}%~%{$fg[blue]%}]%{$reset_color%}\$vcs_info_msg_0_
%B%{$fg[blue]%}╰──%(?:%{$fg[blue]%}╼:%{$fg[red]%}╼) %{$reset_color%}"
