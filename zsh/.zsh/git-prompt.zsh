autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true

function _git_prompt () {
    vcs_info
    echo "${vcs_info_msg_0_}"
}

. ~/.zsh/async-prompt.zsh

_omz_register_handler _git_prompt

function git_prompt () {
    echo -n $_OMZ_ASYNC_OUTPUT[_git_prompt]
}
