case $- in
    *i*) ;;
    *) return;;
esac

# keybinds
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'

# history
HISTCONTROL="erasedups:ignoreboth"
HISTSIZE=1000
HISTFILESIZE=1000

export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

shopt -s histappend

# options
shopt -s checkwinsize
shopt -s globstar

PROMPT_DIRTRIM=2

bind "set mark-symlinked-directories on"

shopt -s histappend
shopt -s cmdhist

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

    # tab completion colors
    bind "set colored-stats on"
fi

# completion
[ -f /etc/bash_completion ] && . /etc/bash_completion \
    || [ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"

complete -d cd

# alias
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -l'

alias bat='batcat'

# environment variables
if [ -f ~/.bash_env ]; then
    . ~/.bash_env
fi

# fzf
function version_greater_equal () {
    printf '%s\n%s\n' "$2" "$1" | sort --check=quiet --version-sort
}

if version_greater_equal $(fzf --version) '0.48.0'; then
    . <(fzf --bash)
else
    . /usr/share/doc/fzf/examples/key-bindings.bash
fi

# prompt
export GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
PS1='\[\e[32m\]\w\[\e[0m\] $(__git_ps1 "on \[\e[35m\]%s\[\e[0m\]")\[\e[0m\]\n\[\e[33m\]❯\[\e[0m\] '

# terminal specific
if [[ "$TERM" == "foot" ]]; then
    osc0_title() {
        local curdir
        if [[ "$PWD" == "$HOME" ]]; then
            curdir='~'
        else
            curdir=${PWD##*/}
        fi
        printf '\e]0;%s\e\\' "foot: ${curdir}"
    }

    osc7_cwd() {
        local strlen=${#PWD}
        local encoded=""
        local pos c o
        for (( pos=0; pos<strlen; pos++ )); do
            c=${PWD:$pos:1}
            case "$c" in
                [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
                * ) printf -v o '%%%02X' "'${c}" ;;
            esac
            encoded+="${o}"
        done
        printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
    }

    PROMPT_COMMAND=${PROMPT_COMMAND:+${PROMPT_COMMAND%;}; }osc0_title
    PROMPT_COMMAND=${PROMPT_COMMAND:+${PROMPT_COMMAND%;}; }osc7_cwd
fi
