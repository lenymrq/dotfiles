# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="re5et"

# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git nvm)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# Created by `pipx` on 2024-10-14 19:14:24
export PATH="$PATH:/home/leny/.local/bin"

export PATH=$PATH:/home/leny/.spicetify

# Alias
clang-format-all() {
    find $1 -type f -name '*.[ch]' | xargs clang-format -i
}
