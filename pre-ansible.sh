#!/bin/bash

sudo pacman -Syu --needed ansible git base-devel
ansible-galaxy collection install -r requirements.yml

# install yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si

#
# ## Configure pam_ssh
# mkdir ~/.ssh/login-keys.d/
# cd ~/.ssh/login-keys.d/
# ln -s ../id_ed25519
