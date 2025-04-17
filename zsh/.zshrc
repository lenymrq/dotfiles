# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# nvm
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-nvm)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# Created by `pipx` on 2024-10-14 19:14:24
export PATH="$PATH:/home/leny/.local/bin"

export PATH=$PATH:/home/leny/.spicetify

export PATH=$PATH:/home/leny/bin

source <(fzf --zsh)
