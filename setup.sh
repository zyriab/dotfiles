#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
CONFIG_DIR="$USER_HOME/.config"

ln -sfn "$PWD/zsh/.zshrc" "$USER_HOME"
ln -sfn "$PWD/zsh/.bash_aliases" "$USER_HOME"

ln -sfn "$PWD/nvim" "$CONFIG_DIR"
ln -sfn "$PWD/wezterm" "$CONFIG_DIR"
ln -sfn "$PWD/wezterm/.wezterm.lua" "$USER_HOME"
ln -sfn "$PWD/lazygit" "$CONFIG_DIR"
ln -sfn "$PWD/bat" "$CONFIG_DIR"
ln -sfn "$PWD/clangd/" "$CONFIG_DIR"

ln -sfn "$PWD/redshift/redshift.conf" "$CONFIG_DIR"
