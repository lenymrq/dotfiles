# Set up starship
eval "$(starship init zsh)"

# Reset the cursor shape to a bar, useful for NeoVim
if [[ $TERM == "st-256color" ]] || [[ $TERM == "foot" ]]; then
	precmd() { echo -ne '\e[5 q' }
fi

# Disable padding on Alacritty when launching NeoVim
if [[ $TERM == "alacritty" ]]; then
	precmd() {
		alacritty msg config -r
		echo -ne '\e[5 q'  # Restore cursor if using beam cursor
	}
	preexec() {
		if [[ "$1" == nvim* ]]; then
			alacritty msg config "window.padding.x=0"
			alacritty msg config "window.padding.y=0"
		fi
	}
fi

setopt histignorealldups sharehistory

# Use emacs keybindings
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' highlight-lines color bg=green
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose false

# Keybinds
bindkey '^[[Z' reverse-menu-complete
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[5D' backward-word
bindkey '^[[5C' forward-word

# Syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Environment variables
export PATH="$PATH:/opt/nvim/"
export PATH="$PATH:/home/leny/.local/bin"

# Aliases
# alias ls='lsd'
# alias la='lsd -A'
# alias l='lsd -AlF'
alias ls='ls --color=auto'
alias la='ls -A'
alias l='ls -AlF'

alias bat='batcat'

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
if [[ $TERM == "foot" ]]; then
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
fi

# Adjust word delimiters
WORDCHARS=${WORDCHARS/\/}
WORDCHARS=${WORDCHARS/_}
WORDCHARS=${WORDCHARS/-}
WORDCHARS=${WORDCHARS/.}

# Fix escape sequences keybinds
if [[ $TERM == "st-256color" ]]; then
    bindkey -s $';2u' ' '
    bindkey -s $';3u' ' '
    bindkey $'7;2u' backward-delete-char
    bindkey $'7;5u' backward-delete-char
fi
