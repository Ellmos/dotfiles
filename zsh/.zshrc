export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history


# some useful options (man zshoptions)
setopt appendhistory           # Append new history entries to the history file
setopt extended_history        # Record the timestamp of each command in the history file
setopt hist_expire_dups_first  # Delete duplicate commands first when history file size exceeds HISTSIZE
setopt hist_ignore_dups        # Ignore duplicate commands in the history list
setopt hist_ignore_space       # Ignore commands that start with a space in the history list
setopt hist_verify             # Show command with history expansion to the user before running it
setopt share_history           # Share command history data between multiple shells

setopt auto_cd                 # Automatically change to a directory without using 'cd'
setopt auto_pushd              # Automatically push directories onto the directory stack after 'cd'
setopt pushd_ignore_dups       # Ignore duplicates when using 'pushd'
setopt pushdminus              # Enable 'pushd' behavior to rotate the stack with negative indices

setopt extendedglob            # Enable extended globbing features
setopt nomatch                 # Do not report error if pattern does not match during filename expansion

setopt menucomplete            # Automatically select the first completion on pressing Tab
setopt auto_menu               # Show completion menu automatically on successive Tab presses
setopt complete_in_word        # Allow completion within words
setopt always_to_end           # Position cursor at the end of the line after completion

setopt multios                 # Enable redirecting output to multiple streams (e.g., echo >file1 >file2)
setopt long_list_jobs          # Show jobs in a long list format in notifications
setopt interactivecomments     # Recognize and allow comments in interactive mode

unsetopt BEEP                  # beeping is annoying

stty stop undef                # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# Import other config files
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_dir() {
    if [ -d "$ZDOTDIR/$1" ]; then
        for i in $(ls "$ZDOTDIR/$1"); do
            # if [ "$i" = "completion.zsh" ]; then
            #     continue
            # fi

            zsh_add_file "$1/$i"
        done
    fi
}

zsh_add_file "zsh-preload"
zsh_add_dir "lib"
zsh_add_file "zsh-plugins"
zsh_add_file "zsh-prompt"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-keymaps" # leave at the end to override any potential keymaps by plugins
source "$ZDOTDIR/zsh-exports" # personal files to export private token, key ...

fastfetch # kekeland
