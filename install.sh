#!/bin/bash

PrintLine(){
  for ((i = 0; i < $1; i++)); do
      echo -n "-"
  done
  echo
}
PrintBlock() {
    local lineLength=70 
    local str=$1
    local l=${#str}
    local paddingLength=$(( (lineLength - l) / 2 ))

    PrintLine $lineLength

    padding=""
    for ((i=0; i<paddingLength; i++)); do
        padding="$padding-"
    done

    if [ $((l % 2)) -eq 1 ]; then
        echo "$padding$str$padding-"
    else
        echo $padding$str$padding
    fi

    PrintLine $lineLength
}



PrintBlock "Updating Packages"
sudo apt update
sudo apt upgrade


PrintBlock "Installing Dependencies"
sudo apt install -y \
    git \
    xinput \
    neofetch \
    brightnessctl \
    feh \
    acpi \
    xdotool \
    wmctrl \
    thunar \
    pulseaudio \
    pulseaudio-utils \
    blueman \
    tree \
    numlockx \
    xclip \
    xsel \
    maim \
    gcc g++ libstdc++6 \
    gedit

sudo apt autoremove


REPO_DIR=$(pwd)
warnings=""

# Temp folder for installation 
mkdir installer
mkdir backupDotfiles
cd installer

#---------------Fonts
PrintBlock "Installing fonts"
if [ ! -d "/usr/local/share/fonts" ]; then
    sudo mkdir /usr/local/share/fonts
fi

if [ ! -d "/usr/local/share/fonts/HackNerdFont"]; then
    sudo cp -r fonts/HackNerdFont /usr/local/share/fonts/
    fc-cache
else
    warnings=$warnings"Could not copy HackNerdFont, folder /usr/local/share/fonts/HackNerdFont already exists\n"
fi



#---------------Alacritty
PrintBlock "Installing Alacritty"
git clone https://github.com/alacritty/alacritty.git
cd alacritty

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup override set stable
rustup update stable

sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
cargo build --release
cd ..

if [ -d "~/.config/alacritty" ]; then
    cp -r ~/.config/alacritty backupDotfiles/
fi
ln -s "$REPO_DIR/alacritty" ~/.config/



#---------------ZSH
PrintBlock "Installing ZSH"
sudo apt install zsh
chsh -s $(which zsh)
ln -s "$REPO_DIR/zsh" ~/.config/

if [ -f "~/.config/.zshrc" ]; then
    cp ~/.zshrc backupDotfiles/zshrc
fi
ln -s ~/.config/zsh/.zshrc ~/.zshrc


#---------------Polybar
PrintBlock "Installing Polybar"
sudo apt install polybar

if [ -d "~/.config/polybar" ]; then
    cp -r ~/.config/polybar backupDotfiles/
fi
ln -s "$REPO_DIR/polybar" ~/.config/


#---------------Rofi
PrintBlock "Installing Rofi"
sudo apt install rofi
if [ -d "~/.config/rofi" ]; then
    cp -r ~/.config/rofi backupDotfiles/
fi
ln -s "$REPO_DIR/rofi" ~/.config/


#---------------NeoVim
PrintBlock "Installing neovim"
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x nvim.appimage

if [ ! -d "/opt/nvim"]; then
    sudo mkdir /opt/nvim
fi

if [ ! -f "/opt/nvim/nvim.appimage"]; then
    sudo mv nvim.appimage /opt/nvim
else
    warnings=$warnings"Could not copy nvim.appimage, /opt/nvim/nvim.appimage already exists\n"
fi

if [ ! -f "/usr/bin/nvim"]; then
    sudo ln -s /opt/nvim/nvim.appimage /usr/bin/nvim
else
    warnings=$warnings"Could not symlink nvim.appimage to /usr/bin/nvim, /usr/bin/nvim already exists\n"
fi

if [ ! -f "/usr/local/bin/nvim"]; then
    sudo ln -s /opt/nvim/nvim.appimage /usr/local/bin/nvim
else
    warnings=$warnings"Could not symlink nvim.appimage to /usr/local/bin/nvim, /usr/local/bin/nvim already exists\n"
fi

git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim


if [ -d "~/.config/nvim" ]; then
    cp -r ~/.config/nvim backupDotfiles/
fi
ln -s "$REPO_DIR/nvim" ~/.config/

sudo apt install python3-neovim npm nodejs fd-find ripgrep lolcat
npm install -g neovim

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'



#---------------libinput-gestures
PrintBlock "Installing libinput-gestures"
sudo apt install libinput-tools
sudo gpasswd -a $USER input

cd installer
git clone https://github.com/bulletmark/libinput-gestures.git
cd libinput-gestures
sudo ./libinput-gestures-setup install
if [ -f "~/.config/libinput-gestures.conf" ]; then
    cp -r ~/.config/libinput-gestures.conf backupDotfiles/
fi
ln -s "$REPO_DIR/libinput-gestures.conf" ~/.config/

libinput-gestures-setup autostart start
cd ..
rm -rf libinput-gestures
cd ..


PrintBlock "Finished"
echo $warnings
echo "Please restart yout copmputer to apply every changes"
