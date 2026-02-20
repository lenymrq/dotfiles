# keybinds
bindkey -e
bindkey '^[[Z' reverse-menu-complete
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# history
HISTCONTROL="erasedups:ignoreboth"
HISTSIZE=1000
SAVEHIST=1000

export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# options
setopt prompt_subst

WORDCHARS=${WORDCHARS/\/}
WORDCHARS=${WORDCHARS/_}
WORDCHARS=${WORDCHARS/-}
WORDCHARS=${WORDCHARS/.}

# misc
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# completion
autoload -U compinit
compinit

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  # add colors to entries
zstyle ':completion:*' menu select  # display menu
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive matching

# aliases
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -l'

alias bat='batcat'

# fzf
function version_greater_equal() {
    printf '%s\n%s\n' "$2" "$1" | sort --check=quiet --version-sort
}

if version_greater_equal $(fzf --version) '0.48.0'; then
    source <(fzf --zsh)
else
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
fi

# syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# prompt
autoload -Uz vcs_info

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

zstyle ':vcs_info:git:*' formats '(git:%b)'

PROMPT='%F{green}%n%F{normal}@%F{cyan}%m%F{normal}:%F{yellow}%3~%F{normal} ${vcs_info_msg_0_:+${vcs_info_msg_0_}}
$ '
