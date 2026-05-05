autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' get-unapplied true
zstyle ':vcs_info:*' formats '[%F{blue}%b%f]-%F{red}%u%f%F{green}%c%f'
zstyle ':vcs_info:*' actionformats '[%F{blue}%b%f|%F{yellow}%a%f]-%F{red}%u%f%F{green}%c%f'

# Display untracked files
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
        hook_com[unstaged]+='T'
    fi
}

function _git_prompt () {
    vcs_info
    echo "${vcs_info_msg_0_}"
}

. ~/.zsh/async-prompt.zsh

_omz_register_handler _git_prompt

function git_prompt () {
    echo -n $_OMZ_ASYNC_OUTPUT[_git_prompt]
}
