#!/bin/zsh

# Add static plugins
for PLUGIN_NAME in $(ls "$ZDOTDIR/plugins"); do
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" ||
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    fi
done
