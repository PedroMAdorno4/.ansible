#!/bin/bash

sudo pacman -Syu ansible

# install yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si

# sudo ln ~/scripts/decreaseVolume.sh /usr/.local/bin/decreaseVolume
# sudo ln ~/scripts/increaseVolume.sh /usr/.local/bin/increaseVolume
# sudo ln ~/scripts/project-finder /usr/.local/bin/project-finder
# sudo ln ~/scripts/project-terminals /usr/.local/bin/project-terminals
# sudo ln ~/scripts/rotateScreen.sh /usr/.local/bin/rotate-screen
# sudo ln ~/scripts/switchAudio.sh /usr/.local/bin/switch-audio
# sudo ln ~/scripts/toggle-spotify /usr/.local/bin/toggle-spotify
# sudo ln ~/scripts/wallpaper-engine /usr/.local/bin/wallpaper-engine
#
# ## Configure pam_ssh
# mkdir ~/.ssh/login-keys.d/
# cd ~/.ssh/login-keys.d/
# ln -s ../id_ed25519
