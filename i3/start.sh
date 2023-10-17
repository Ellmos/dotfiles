#!/bin/sh

bg=0
CHANGE_BG() 
{
    feh --bg-fill "$HOME/.config/i3/img/loadings/loading$bg.png"
    bg=$(($bg+1))
}


[ ! -e ~/.zshrc ] && ln -s ~/.config/zsh/.zshrc ~/.zshrc
[ ! -e ~/.zsh_history ] && ln -s ~/.config/zsh/.zsh_history ~/.zsh_history


CHANGE_BG
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
nix-channel --add https://github.com/nixos/nixpkgs/archive/refs/tags/23.05.tar.gz nixpkgs
nix-channel --update


CHANGE_BG
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install



# Installing nvim / packer / packages

CHANGE_BG
nix-env -iA nixpkgs.neovim


CHANGE_BG
mkdir -p ~/.local/share/nvim/site/pack/packer/start
git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim


CHANGE_BG
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2> /dev/null


xset r rate 250
feh --bg-fill ~/.config/i3/img/bg/japanNight.png
picom &
bash ~/.config/i3/dodo.sh
