DEV_PATH="$HOME/Developer"

### Utils
# alias nvim="/usr/local/bin/nvim.appimage"
alias vim="nvim"
alias v="nvim ."
alias lg="lazygit"
alias rst="source ~/.zshrc"
alias gcg="git config --edit --global"
alias gcl="git config --edit --local"
alias cputemp="sudo powermetrics --samplers smc |grep -i \"CPU die temperature\""

### Prog
alias got="go test ./..."
alias qc="qmk compile -e CONVERT_TO=promicro_rp2040 -km colemak-v1"

### Navigation
alias dev="cd $DEV_PATH"

### Fixes
alias jy="sudo ~/scripts/init-controller.py"
alias tpad="sudo ~/scripts/restart-touchpad.sh"
