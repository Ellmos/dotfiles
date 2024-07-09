#!/bin/zsh

# Add static plugins
function add_plugin_folder() {
    folder="$1"
    for name in $(ls "$ZDOTDIR/$folder"); do
        if [ -d "$ZDOTDIR/$folder/$name" ]; then 
            add_file "$folder/$name/$name.plugin.zsh" ||
                add_file "$folder/$name/$name.zsh"
        fi
    done
}

function clone_git_plugins() {
    # Create git directoruy if does not exists
    folder="$2"
    if [ ! -d "$ZDOTDIR/$folder" ]; then
        mkdir -p "$ZDOTDIR/$folder";
    fi

    for plugin in "${(@P)1}"; do
        name=$(echo "$plugin" | cut -d "/" -f 2)
        if [ ! -d "$ZDOTDIR/$folder/$name" ]; then
            git clone "https://github.com/$plugin.git" "$ZDOTDIR/$folder/$name"
        fi
    done
}

# Params
static_plugins_folder="plugins/static"
git_plugins_folder="plugins/git"

git_plugins=(
    hlissner/zsh-autopair
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-syntax-highlighting
)

# adding the plugins
add_plugin_folder "$static_plugins_folder"

clone_git_plugins git_plugins "$git_plugins_folder"
add_plugin_folder "$git_plugins_folder"
