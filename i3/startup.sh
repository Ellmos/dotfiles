#!/bin/sh

change_gb() 
{ 
    feh --bg-fill "$HOME/.config/i3/img/loadings/loading$1.png" 
}

change_gb 0

# Neovim                                                                                             
nix profile install nixpkgs#neovim                                              
if [ ! -e .local/share/nvim/site/pack/packer/start ]; then
    mkdir -p .local/share/nvim/site/pack/packer/start
fi

change_gb 1


cd .local/share/nvim/site/pack/packer/start
if [ ! -e packer.nvim ]; then
    git clone https://github.com/wbthomason/packer.nvim
fi

change_gb 2

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' >> /dev/null

change_gb 3

# NerdFonts
nix profile install nixpkgs#nerdfonts

change_gb 4


nix profile install nixpkgs#zsh
ln -s ~/.config/zsh/.zshrc ~/.zshrc

xset r rate 250

feh --bg-fill ~/.config/i3/img/bg.png
bash ~/.config/i3/dodo.sh
