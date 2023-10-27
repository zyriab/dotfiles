DEV_PATH="/mnt/DATA/dev"

### Utils
alias bat="upower -i `upower -e | grep 'BAT'`"
# alias nvim="/usr/local/bin/nvim.appimage"
alias v="nvim ."
alias vc="nvim ~/.config/nvim"
alias gg="lazygit"
alias rst="source ~/.zshrc"

### Prog
alias got="go test ./..."

### Navigation
alias dev="cd $DEV_PATH"
alias app="cd $DEV_PATH/apps"
alias gma="cd $DEV_PATH/games"
alias plu="cd $DEV_PATH/plugins"

### Fixes
alias jy="sudo ~/scripts/init-controller.py"
alias tpad="sudo ~/scripts/restart-touchpad.sh"
