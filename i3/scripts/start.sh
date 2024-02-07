#!/bin/sh

bg=0
CHANGE_BG() 
{
    killall i3lock &> /dev/null
    feh --bg-fill "$HOME/.config/i3/img/loadings/loading$bg.png"
    bg=$(($bg+1))
    i3lock -p win -i "$HOME/.config/i3/img/loadings/loading$bg.png"
}


#ask to install config
sed -i '/which zsh/d' ~/.bashrc
rm -f ~/.config/alacritty

read -r -p "Wanna install da config buddy [y/n]" response
response=${response,,}
if [[ ! $response =~ ^(yes|y| ) ]] && [[ ! -z $response ]]; then
    exit 0;
fi
# sh ~/.config/i3/start.sh 


#install config
[ ! -e ~/.zshrc ] && ln -s ~/.config/zsh/.zshrc ~/.zshrc
[ ! -e ~/.zsh_history ] && ln -s ~/.config/zsh/.zsh_history ~/.zsh_history
echo "[ \$(which zsh) ] && export SHELL=\`which zsh\` && exec \"\$SHELL\" -l" >> ~/.bashrc
ln -s ~/afs/dotfiles/alacritty ~/.config/alacritty

if [ ! $(which home-manager) ]; then
    CHANGE_BG
    nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
    nix-channel --add https://github.com/nixos/nixpkgs/archive/refs/tags/23.05.tar.gz nixpkgs
    nix-channel --update

    CHANGE_BG
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
    nix-shell '<home-manager>' -A install
fi


# Installing nvim / packer / packages
CHANGE_BG
#nix-env -iA nixpkgs.neovim
nvim --headless 2> /dev/null &

CHANGE_BG
xset r rate 250
feh --bg-fill ~/.config/i3/img/bg/japanNight.png
killall i3lock &> /dev/null
sh ~/.config/i3/scripts/dodo.sh
