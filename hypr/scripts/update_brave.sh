#!/bin/sh

find ~/.config/BraveSoftware -iname SingletonLock -exec rm {} \;

dnf --disablerepo="*" --enablerepo=brave-browser check-update brave-browser

if [ "$?" -eq 100 ]; then
    echo "Brave needs an update, running: 'sudo dnf update brave-browser'."
    sudo dnf --disablerepo="*" --enablerepo=brave-browser update brave-browser
fi
