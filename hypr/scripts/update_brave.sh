#!/bin/sh

dnf --disablerepo="*" --enablerepo=brave-browser check-update brave-browser

if [ "$?" -eq 100 ]; then
    echo "Brave needs an update, running: 'sudo dnf update brave-browser'."
    sudo dnf update brave-browser
fi
