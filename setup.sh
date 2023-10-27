#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

ln -sfn "$PWD/zsh/.zshrc" $USER_HOME/
ln -sfn "$PWD/zsh/.bash_aliases" $USER_HOME/

ln -sfn "$PWD/nvim" $USER_HOME/.config/
ln -sfn "$PWD/wezterm" $USER_HOME/.config/wezterm
ln -sfn "$PWD/wezterm/.wezterm.lua" $USER_HOME/.wezterm.lua
ln -sfn "$PWD/lazygit" $USER_HOME/.config/

ln -sfn "$PWD/redshift/redshift.conf" $USER_HOME/.config/
