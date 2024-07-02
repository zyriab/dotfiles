# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export EDITOR=nvim
export TERM=wezterm

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

### Neovim w/ Bob (version manager)
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"

export BOB_CONFIG="$HOME/.config/bob/config.toml"

### Go
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

### Rust
export PATH="$PATH:$HOME/.cargo/bin"

### Luarocks
export PATH="$PATH:$HOME/.luarocks/bin"

### fzf theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#6e7681,bg:,hl:#ffffff --color=fg+:#c9d1d9,bg+:#1e4273,hl+:#fdac54 --color=info:#d29922,prompt:#58a6ff,pointer:#a371f7 --color=marker:#ec8e2c,spinner:#6e7681,header:#343941'

### bat theme
export BAT_THEME="github_dark_colorblind_custom"


ZSH_THEME="random"
# DISABLE_LS_COLORS="true"
HIST_STAMPS="yyyy-mm-dd"

if [ -f ~/scripts/zvm-config.sh ]; then
    source ~/scripts/zvm-config.sh
fi

plugins+=(zsh-vi-mode zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

# source $ZSH_CUSTOM/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

### Custom scripts
if [ -f ~/scripts/scripts.sh ]; then 
    source ~/scripts/scripts.sh
fi

if [ -f ~/.fzf.zsh ]; then 
    source ~/.fzf.zsh
fi

eval "$(zoxide init --cmd cd zsh)"
