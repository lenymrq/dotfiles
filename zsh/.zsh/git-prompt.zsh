autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' formats '[%F{blue}%b%f]-%F{red}%u%f%F{green}%c%f%m'
zstyle ':vcs_info:*' actionformats '[%F{blue}%b%f|%F{yellow}%a%f]-%F{red}%u%f%F{green}%c%f%m'

# Display untracked files
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
        hook_com[unstaged]+='T'
    fi
}

# Display remote changes
zstyle ':vcs_info:git*+set-message:*' hooks git-st
function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # Exit early in case the worktree is on a detached HEAD
    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    local -a ahead_and_behind=(
        $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

    (( $ahead )) && gitstatus+=( "+${ahead}" )
    (( $behind )) && gitstatus+=( "-${behind}" )

    hook_com[misc]+=${(j:/:)gitstatus}
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
