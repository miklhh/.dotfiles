#
# Configuration is very miniscule but it does the job both for faint tty sessions and in interactive colored terminal
# emulators. If Powerlevel10k is available it is sourced. If not, a fallback prompt is available.
#
# Author: Mikael Henriksson (www.github.com/miklhh)
#


# Export base env-variables.
export HOST=$(uname -n)
export NAME=$(whoami)
export PAGER="less"
command -v "nvim" 1>/dev/null 2>&1 && export EDITOR="nvim" || export EDITOR="vim"

# Source ${HOME}/.zsh-local which can contain configuration local to the machine
[ -f "${HOME}/.zsh-local" ] && source "${HOME}/.zsh-local"

# Source the Zsh alias file
[ -f "${HOME}/.zsh-alias" ] && source "${HOME}/.zsh-alias" || echo "[ .zshrc:${LINENO} ]: Warning: \${HOME}/.zsh-alias unavailable"

# Add ${HOME}/.cargo/bin to path if available
[ -d "${HOME}/.cargo/bin" ] && export PATH="${HOME}/.cargo/bin:${PATH}"

# Add ${HOME}.local/bin to path if available
[ -d "${HOME}/.local/bin" ] && export PATH="${HOME}/.local/bin:${PATH}"

# Prompt settings
function set_prompt_plain {
    autoload -U colors && colors
    PROMPT="%B[%{$fg[cyan]%}%n%{$reset_color%}%B@%{$fg[green]%}%m%{$reset_color%}%B %{$fg[yellow]%}%~%{$reset_color%}%B] $%b "
}

function set_prompt_p10k {
    if [[ -r "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    else
        echo "[ .zshrc:${LINENO} ]: Warning: could not enable P10k instant prompt"
    fi
    source "${P10K_THEME}"
    source "${HOME}/.p10k.zsh"
}

if [ "${TERM}" != "linux" ] && [ "${TERM}" != "xterm" ]; then
    autoload is-at-least
    if is-at-least "5.1.0"; then
        [ -d "${HOME}/.powerlevel10k" ] && P10K_THEME="${HOME}/.powerlevel10k/powerlevel10k.zsh-theme"
        if [ -f "${P10K_THEME}" ]; then
            set_prompt_p10k
        else
            echo "[ .zshrc:${LINENO} ]: Warning: directory ${HOME}/.powerlevel10k unavailable"
            set_prompt_plain
        fi
    else # Zsh version lower than 5.1.0
        echo "[ .zshrc:${LINENO} ]: Warning: Zsh version (${ZSH_VERSION}) lower than 5.1.0, could not load Powerlevel10k"
        set_prompt_plain
    fi
else
    set_prompt_plain
fi

# Zsh history settings
HISTFILE="${HOME}/.config/zsh/.zsh-history"
HISTSIZE=5000          # Max events stored in session
SAVEHIST=5000          # Max events stored in history file
setopt extended_history       # Record timestamp in history file
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE is full
setopt hist_ignore_all_dups   # Remove older enties if command is a duplicate
setopt inc_append_history     # Load history only on startup but append in realtime
setopt hist_verify            # Upon hitting enter, reload line into edit buf
bindkey '^[[A' history-beginning-search-backward # '^[[A' = Up-arrow
bindkey '^[[B' history-beginning-search-forward  # '^[[B' = Down-arrow
bindkey -a j history-beginning-search-forward
bindkey -a k history-beginning-search-backward

# Bind HOME/END to 'go to beginig/end of line' and DEL to delete character under cursor
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[3~' delete-char

# Use Ripgrep with Fzf if available
if command -v rg 1>/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-ignore-vcs -g '!{node_modules,.git}'"
else
    echo "[ .zshrc:${LINENO} ]: Warning: 'rg' not in \${PATH}"
fi

# Man pages coloring and formating using Bat
if command -v bat 1>/dev/null 2>&1; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
else
    echo "[ .zshrc:${LINENO} ]: Warning: 'bat' not in \${PATH}, using regular man-page formating"
fi

#
# Vi keybindings. This is not always loaded by default if not specified
# explicitly, e.g., on MacOSX iTerm2
#
bindkey -v
bindkey "^?" backward-delete-char
bindkey '^R' history-incremental-search-backward
bindkey '^F' history-incremental-search-forward

# Enable zsh autocompletion
autoload -U compinit
compinit -d "${HOME}/.config/zsh/.zcompdump"

