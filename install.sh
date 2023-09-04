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

    echo $'\n\n'
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



# Check if program has already been ran
if [ -e backupDotfiles ]; then 
    echo "There is already a backup of some dotfiles, if you want to run the program delete the folder 'backupDotfiles'"
    exit 0
fi


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


DOTFILES_DIR=$(pwd)

# Backup current dotfiles
mkdir backupDotfiles

# Temp folder for installation 
rm -rf installer
mkdir installer
cd installer




warnings=$'Some steps might have failed check below for logs:\n'


#---------------Fonts
PrintBlock "Installing fonts"
if ! fc-list | grep -q "HackNerdFont"; then
  if [ ! -e /usr/local/share/fonts ]; then
      sudo mkdir -p /usr/local/share/fonts
  fi

if [ ! -e /usr/local/share/fonts/HackNerdFont ]; then
      sudo cp -r fonts/HackNerdFont /usr/local/share/fonts/
      fc-cache
  else
      warnings=$warnings$'Could not copy HackNerdFont, folder /usr/local/share/fonts/HackNerdFont already exists\n'
  fi
fi




#---------------Alacritty
PrintBlock "Installing Alacritty"

if ! which rustup &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
rustup override set stable
rustup update stable


if ! which alacritty &>/dev/null; then
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty

    sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
    cargo build --release

    cd ..
    rm -rf alacritty
fi

if [ -e ~/.config/alacritty ]; then
    mv ~/.config/alacritty "$DOTFILES_DIR/backupDotfiles/"
fi
ln -s "$DOTFILES_DIR/alacritty" ~/.config/



#---------------ZSH
PrintBlock "Installing ZSH"
sudo apt install zsh
echo "Enter you password to change the shell to zsh"
chsh -s $(which zsh)

if [ -e ~/.config/zsh ]; then
    mv ~/.config/zsh "$DOTFILES_DIR/backupDotfiles/"
fi
ln -s "$DOTFILES_DIR/zsh" ~/.config/

if [ -e ~/.zshrc ]; then
    mv ~/.zshrc "$DOTFILES_DIR/backupDotfiles/zshrc"
fi
ln -s ~/.config/zsh/.zshrc ~/.zshrc


#---------------Polybar
PrintBlock "Installing Polybar"
sudo apt install polybar

if [ -e ~/.config/polybar ]; then
    mv ~/.config/polybar "$DOTFILES_DIR/backupDotfiles/"
fi
ln -s "$DOTFILES_DIR/polybar" ~/.config/


#---------------Rofi
PrintBlock "Installing Rofi"
sudo apt install rofi
if [ -e ~/.config/rofi ]; then
    mv ~/.config/rofi "$DOTFILES_DIR/backupDotfiles/"
fi
ln -s "$DOTFILES_DIR/rofi" ~/.config/


#---------------NeoVim
PrintBlock "Installing neovim"

if ! which nvim &>/dev/null; then
    wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod +x nvim.appimage

    if [ ! -e /opt/nvim ]; then
        sudo mkdir -p /opt/nvim
    fi

    if  [ ! -e /opt/nvim/nvim.appimage ]; then
        sudo mv nvim.appimage /opt/nvim
    else
        warnings=$warnings$'Could not copy nvim.appimage, /opt/nvim/nvim.appimage already exists\n'
    fi

    if [ ! -e /usr/bin/nvim ]; then
        sudo ln -s /opt/nvim/nvim.appimage /usr/bin/nvim
    else
        warnings=$warnings$'Could not symlink nvim.appimage to /usr/bin/nvim, /usr/bin/nvim already exists\n'
        fi

    if [ ! -e /usr/local/bin/nvim ]; then
        sudo ln -s /opt/nvim/nvim.appimage /usr/local/bin/nvim
    else
        warnings=$warnings$'Could not symlink nvim.appimage to /usr/local/bin/nvim, /usr/local/bin/nvim already exists\n'
    fi
fi

if [ -e ~/.config/nvim ]; then
    mv ~/.config/nvim "$DOTFILES_DIR/backupDotfiles/"
fi
ln -s "$DOTFILES_DIR/nvim" ~/.config/

rm -rf ~/.local/share/nvim/
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim


sudo apt install python3-neovim npm nodejs fd-find ripgrep lolcat
sudo npm install -g neovim



PrintBlock "THE ERROR MESSAGE IS NORMAL JUST WAIT"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'



#---------------libinput-gestures
PrintBlock "Installing libinput-gestures"
sudo apt install libinput-tools
sudo gpasswd -a $USER input

git clone https://github.com/bulletmark/libinput-gestures.git
cd libinput-gestures
sudo ./libinput-gestures-setup install
if [ -e ~/.config/libinput-gestures.conf ]; then
    mv ~/.config/libinput-gestures.conf "$DOTFILES_DIR/backupDotfiles/"
fi
ln -s "$DOTFILES_DIR/libinput-gestures.conf" ~/.config/

libinput-gestures-setup autostart start
cd ..
rm -rf libinput-gestures




#---------------End
cd ..
rm -rf installer

PrintBlock "Finished"
echo $warnings
echo $'\n'
echo "The installation is finished"
echo "Your previous config files are stored inside the directory 'backupDotfiles'"
echo "Please restart your computer to apply every changes"
exit 0
