# Dotfiles

Have a good time trying to understand all this shit ;)


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
su - elmos
```


Now you can install everything
```
sudo apt install -y git
git clone https://github.com/Ellmos/dotfiles.git
cd dotfiles
./install.sh
```