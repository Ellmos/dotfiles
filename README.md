# Dotfiles

The config is made to run on debian 12 with i3 as a window manager
The `install.sh` script install and setup the entire config and place the old dotfiles inside the backupDotfiles directory.


## Installation
First you need to add your user to the sudoers group
```
su -
```

```
usermod -aG sudo <user>
exit
```

```
su - <user>
```


Now you can install everything
```
sudo apt install -y git
git clone https://github.com/Ellmos/dotfiles.git
cd dotfiles
./install.sh
```
