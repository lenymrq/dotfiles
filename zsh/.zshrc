# Set up starship
eval "$(starship init zsh)"

# Reset the cursor shape to a bar, useful for NeoVim
# if [[ $TERM == "st-256color" ]] || [[ $TERM == "foot" ]]; then
# 	precmd() { echo -ne '\e[5 q' }
# fi

# Initialize completion system
autoload -Uz compinit
compinit

# Completion behavior and appearance
zstyle ':completion:*' menu select
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Keybinds
bindkey '^[[Z' reverse-menu-complete
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[5D' backward-word
bindkey '^[[5C' forward-word

# Syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# PATH
export PATH="$PATH:/opt/nvim/"
export PATH="$PATH:/home/leny/.local/bin"

# Aliases
alias ls='lsd'
alias l='lsd -la'
alias cat='batcat'

alias exegol='sudo -E /home/leny/.local/bin/exegol'

# Set up fzf key bindings and fuzzy completion
function version_greater_equal() {
    printf '%s\n%s\n' "$2" "$1" | sort --check=quiet --version-sort
}

if version_greater_equal $(fzf --version) '0.48.0'; then
    source <(fzf --zsh)
else
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
fi

# Foot terminal spawn new terminal in same cwd
function osc7-pwd() {
    emulate -L zsh
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

# Vim-like word selection
autoload -U select-word-style
select-word-style bash
