# Options
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

bindkey -e

# Prompt
setopt prompt_subst
. ~/.zsh/git-prompt.zsh
PROMPT='%K{blue} %n %k%K{magenta} %~ %k '
RPROMPT='$(git_prompt)'
setopt TRANSIENT_RPROMPT

# Completion
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Keybinds
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

bindkey '^[[1;5D' backward-word # Ctrl + Left
bindkey '^[[1;5C' forward-word # Ctrl + Right

bindkey '^[[1;3D' backward-word # Alt + Left
bindkey '^[[1;3C' forward-word # Alt + Right

autoload -U select-word-style
select-word-style bash

# Aliases
if [[ -x /usr/bin/dircolors ]]; then
    if [[ -r ~/.dircolors ]]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# More aliases
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# fzy aliases
alias historyf='print -z $(history -r -n 1 | fzy --prompt="search history> ")'
alias cdf='cd $(fdfind --type directory --hidden --max-depth 1 | fzy --prompt="cd into> ")'

# Hooks
function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
chpwd_functions+=( chpwd-osc7-pwd )
