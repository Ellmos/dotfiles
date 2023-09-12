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
    exit 0;
fi


DOTFILES_DIR=$(pwd)

# Backup current dotfiles
mkdir backupDotfiles

# Temp folder for installation 
rm -rf installer
mkdir installer
cd installer



warnings=$'Some steps might have failed check below for logs:\n'


PrintBlock "Updating Packages"
sudo apt update
sudo apt upgrade


PrintBlock "Installing Dependencies"
sudo apt install -y \
    curl \
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
    gedit \
    strongswan strongswan-swanctl

sudo apt autoremove

#---------------Polybar
PrintBlock "Installing i3 "
if ! which i3 &> /dev/null; then
    sudo apt install -y i3 i3-wm
fi

if [ -e ~/.config/i3 ]; then
    mv ~/.config/i3 "$DOTFILES_DIR/backupDotfiles/"
fi
ln -s "$DOTFILES_DIR/i3" ~/.config/


#---------------Fonts
PrintBlock "Installing fonts"
if ! fc-list | grep -q "HackNerdFont"; then
    if [ ! -e /usr/local/share/fonts ]; then
        sudo mkdir -p /usr/local/share/fonts
    fi

    if [ ! -e /usr/local/share/fonts/HackNerdFont ]; then
        sudo cp -r "$DOTFILES_DIR/fonts/HackNerdFont" /usr/local/share/fonts/
        fc-cache
    else
        warnings=$warnings$'Could not copy HackNerdFont, folder /usr/local/share/fonts/HackNerdFont already exists\n'
    fi
fi


#---------------Polybar
PrintBlock "Installing Polybar"
if ! which polybar &> /dev/null; then
    sudo apt install -y polybar
fi

if [ -e ~/.config/polybar ]; then
    mv ~/.config/polybar "$DOTFILES_DIR/backupDotfiles/"
fi
ln -s "$DOTFILES_DIR/polybar" ~/.config/



#---------------Rofi
PrintBlock "Installing Rofi"
if ! which rofi &> /dev/null; then
    sudo apt install -y rofi
fi

if [ -e ~/.config/rofi ]; then
    mv ~/.config/rofi "$DOTFILES_DIR/backupDotfiles/"
fi
ln -s "$DOTFILES_DIR/rofi" ~/.config/



#---------------Alacritty
PrintBlock "Installing Alacritty"

if ! which alacritty &>/dev/null; then

    git clone https://github.com/alacritty/alacritty.git
    cd alacritty

    # Installing Rustup
    if ! which rustup &>/dev/null; then
        wget -O rustup-init.sh https://sh.rustup.rs
        chmod +x rustup-init.sh
        ./rustup-init.sh -y
        source "$HOME/.cargo/env"
    fi

    rustup override set stable
    rustup update stable

    # Dependencies
    sudo apt install -y \
        cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

    # Build
    cargo build --release

    if ! infocmp alacritty &> /dev/null; then
        infocmp alacritty
    fi

    # Adding desktop entry
    sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database

    cd ..
fi

if [ -e ~/.config/alacritty ]; then
    mv ~/.config/alacritty "$DOTFILES_DIR/backupDotfiles/"
fi
ln -s "$DOTFILES_DIR/alacritty" ~/.config/



#---------------ZSH
PrintBlock "Installing ZSH"
if ! echo "$SHELL" | grep zsh &> /dev/null; then
    sudo apt install -y zsh
    echo "Enter you password to change the shell to zsh"
    chsh -s $(which zsh)

    if [ -e ~/.config/zsh ]; then
        mv ~/.config/zsh "$DOTFILES_DIR/backupDotfiles/"
    fi
    ln -s "$DOTFILES_DIR/zsh" ~/.config/
fi


if [ -e ~/.zshrc ]; then
    mv ~/.zshrc "$DOTFILES_DIR/backupDotfiles/zshrc"
fi
ln -s ~/.config/zsh/.zshrc ~/.zshrc




#---------------NeoVim
PrintBlock "Installing Neovim"

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

sudo apt install  -y python3-neovim npm nodejs fd-find ripgrep lolcat
sudo npm install -g neovim

PrintBlock "THE ERROR MESSAGE IS NORMAL JUST WAIT"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'



#---------------libinput-gestures
PrintBlock "Installing libinput-gestures"

if ! libinput-gestures-setup autostart start &> /dev/null; then
    sudo apt install libinput-tools
    sudo gpasswd -a $USER input

    git clone https://github.com/bulletmark/libinput-gestures.git
    cd libinput-gestures
    sudo ./libinput-gestures-setup install
    cd ..
fi
if [ -e ~/.config/libinput-gestures.conf ]; then
    mv ~/.config/libinput-gestures.conf "$DOTFILES_DIR/backupDotfiles/"
fi
ln -s "$DOTFILES_DIR/libinput-gestures.conf" ~/.config/
libinput-gestures-setup autostart start



#---------------Brave
PrintBlock "Installing Brave"
if ! which brave-browser &> /dev/null; then
    sudo apt install -y curl

    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update
    sudo apt install -y brave-browser
fi 



PrintBlock "Installing Extras"
#---------------Gitkraken
if ! which gitkraken &> /dev/null; then
    PrintBlock "Installing GitKraken"
    wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
    sudo apt install -y ./gitkraken-amd64.deb

fi

#---------------Discord
if ! which gitkraken &> /dev/null; then
    PrintBlock "Installing Discord"
    sudo wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    sudo chmod +x discord.deb
    sudo apt install -y ./discord.deb
fi


#---------------Bitwarden
if ! tree /opt/ | grep "bitwarden.appimage" &> /dev/null; then
    PrintBlock "Installing Bitwarden"
    sudo wget -O bitwarden.appimage "https://vault.bitwarden.com/download/?app=desktop&platform=linux"
    sudo wget -O bitwarden.png "https://static-00.iconduck.com/assets.00/bitwarden-icon-2048x2048-dpfdlf2a.png"
    sudo chmod +x bitwarden.appimage
    sudo mkdir -p /opt/bitwarden/
    sudo mv "$DOTFILES_DIR/installer/bitwarden.appimage" /opt/bitwarden/
    sudo mv  "$DOTFILES_DIR/installer/bitwarden.png" /opt/bitwarden

    sudo echo $'[Desktop Entry]\nName=Bitwarden\nComment=Password Manager\nExec=/opt/bitwarden/bitwarden.appimage\nIcon=/opt/bitwarden/bitwarden.png\nType=Application\nCategories=Utility\nTerminal=false' \
        > "$HOME/.local/share/applications/bitwarden.desktop"
    chmod +x "$HOME/.local/share/applications/bitwarden.desktop"
fi


#---------------Docker
if ! which docker &> /dev/null; then
    PrintBlock "Installing Docker"
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo \
        "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
        "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi




#---------------Docker
if ! which tailscale &> /dev/null; then
    PrintBlock "Installing Tailscale"
    curl -fsSL https://tailscale.com/install.sh | sh
fi


#---------------End
cd ..
sudo apt autoremove -y
rm -rf installer

PrintBlock "Finished"
echo $warnings
echo $'\n'
echo "The installation is finished"
echo "Your previous config files are stored inside the directory 'backupDotfiles'"
echo "Please restart your computer to apply every changes"
exit 0
