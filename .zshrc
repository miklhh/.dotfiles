#
# Configuration is very miniscule but it does the job both for faint tty sessions and in
# interactive colored terminal emulators. If Powerlevel10k is available it is sourced.
# If not, a fallback prompt is available.
#
# Author: Mikael Henriksson (www.github.com/miklhh)
#

# ------------------------------------------------------------------------------------ #
# --                              Environment settings                              -- #
# ------------------------------------------------------------------------------------ #

# Export base env-variables.
export HOST=$(uname -n)
export NAME=$(whoami)
export PAGER="less"
export DOTFILES="${HOME}/.dotfiles"
command -v "nvim" 1>/dev/null 2>&1 && export EDITOR="nvim" || export EDITOR="vim"

# Prepend to PATH if not already in PATH
function prepend_path {
    local to_add_path="${1}"
    case ":${PATH}:" in
        *:"${to_add_path}":*) ;;
        *) export PATH="${to_add_path}:$PATH" ;;
    esac
}

# Add ${HOME}.local/bin to path if available
[ -d "${HOME}/.local/bin" ] && prepend_path "${HOME}/.local/bin"

# Add ${HOME}/.cargo/bin to path if available
[ -d "${HOME}/.cargo/bin" ] && prepend_path "${HOME}/.cargo/bin"

# Source ${HOME}/.zsh-local which can contain machine/system specific zsh settings
[ -f "${HOME}/.zsh-local" ] && source "${HOME}/.zsh-local"

# Source the zsh aliasing file if available
[ -f "${HOME}/.zsh-alias" ] && source "${HOME}/.zsh-alias" \
    || echo "[ .zshrc:${LINENO} ]: Warning: \${HOME}/.zsh-alias unavailable"

# Default to Vim keybindings no matter the ${EDITOR}/${VISUAL} environment variables.
# More key binding are found below under 'Key bindings'. The 'bindkey -v' option must be
# set before the FZF settings are loaded, as FZF depends on it being set properly.
bindkey -v

# ------------------------------------------------------------------------------------ #
# --                                  FZF settings                                  -- #
# ------------------------------------------------------------------------------------ #

export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS='
    --border --info=inline
    --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
    --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598
    --color marker:#fe8019,header:#665c54
'

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'    "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"          "$@" ;;
    ssh)          fzf --preview 'dig {}'                    "$@" ;;
    *)            fzf                                       "$@" ;;
  esac
}

if command -v fd 1>/dev/null 2>&1; then
    export FD_DEFAULT="fd --hidden --no-ignore-vcs"
    export FZF_DEFAULT_COMMAND="${FD_DEFAULT} ."
    export FZF_CTRL_T_COMMAND="${FD_DEFAULT} . ${HOME}"
    export FZF_CTRL_T_OPTS="-d '${HOME}/' --with-nth 2"
    export FZF_ALT_C_COMMAND="(echo ${HOME}/; ${FD_DEFAULT} --type d . ${HOME})"
    export FZF_ALT_C_OPTS="-d '${HOME}/' --with-nth 2"
    _fzf_compgen_path() {
        fd --type file --hidden --no-ignore-vcs . "$1" 2>/dev/null
    }
    _fzf_compgen_dir() {
        fd --type directory --hidden --no-ignore-vcs . "$1"
    }
else
    # Fd not in path, falling back to regular GNU (or BSD) find for command-line
    # completion with fzf
    echo "[ .zshrc:${LINENO} ]: Warning: 'fd' not in \${PATH}"
fi

# Source FZF settings
[ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh"                              \
    || echo "[ .zshrc:${LINENO} ]: Warning: ${HOME}/.fzf.zsh not found"

[ -f "${HOME}/.dotfiles/.fzf-git.sh" ] && source "${HOME}/.dotfiles/.fzf-git.sh"    \
    || echo "[ .zshrc:${LINENO} ]: Warning: ${HOME}/.dotfiles/.fzf-git.sh"

# ------------------------------------------------------------------------------------ #
# --                              Prompt settings                                   -- #
# ------------------------------------------------------------------------------------ #

function set_prompt_plain {
    autoload -U colors && colors
    PROMPT=""
    PROMPT+="%B[%{$fg[cyan]%}%n%{$reset_color%}%B@%{$fg[green]%}%m%{$reset_color%}%B "
    PROMPT+="%{$fg[yellow]%}%~%{$reset_color%}%B] $%b "
}

function set_prompt_p10k {
    if [[ -r "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]
    then
        source "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    else
        echo "[ .zshrc:${LINENO} ]: Warning: could not enable P10k instant prompt"
    fi
    source "${P10K_THEME}"
    source "${HOME}/.p10k.zsh"

    # zsh autosuggestions
    [ -f "${HOME}/.dotfiles/zsh-autosuggestions/zsh-autosuggestions.zsh" ] &&
        source "${HOME}/.dotfiles/zsh-autosuggestions/zsh-autosuggestions.zsh"
}

if [ "${TERM}" != "linux" ] && [ "${TERM}" != "xterm" ]; then
    autoload is-at-least
    if is-at-least "5.3.0"; then
        # If dotfiles are bootstraped from 'https://github.com/miklhh/.dotfiles', then
        # '${HOME}/.powerlevel10k' is symlinked to '${HOME}/.dotfiles/powerlevel10k'.
        # If this '.zshrc' file is used stand alone, users will manually have to install
        # Powerlevel10k into '${HOME}/.powerlevel10k'.
        [ -d "${HOME}/.powerlevel10k" ] &&
            P10K_THEME="${HOME}/.powerlevel10k/powerlevel10k.zsh-theme"
        if [ -f "${P10K_THEME}" ]; then
            set_prompt_p10k
        else
            echo "[ .zshrc:${LINENO} ]:"                                            \
                 "Warning: directory '${HOME}/.powerlevel10k' unavailable, falling" \
                 "back to plain prompt"
            set_prompt_plain
        fi
    else  # Zsh version lower than 5.3.0
        echo "[ .zshrc:${LINENO} ]: Warning zsh version (${ZSH_VERSION}) is lower"  \
             "than the required 5.3.0, could not load Powerlevel10k"
        set_prompt_plain
    fi
else
    set_prompt_plain
fi

# ------------------------------------------------------------------------------------ #
# --                               History settings                                 -- #
# ------------------------------------------------------------------------------------ #

HISTFILE="${HOME}/.config/zsh/.zsh-history"
HISTSIZE=5000                   # Max events stored in session
SAVEHIST=5000                   # Max events stored in history file
setopt extended_history         # Record timestamp in history file
setopt hist_expire_dups_first   # Delete duplicates first when HISTFILE is full
setopt hist_ignore_all_dups     # Remove older enties if command is a duplicate
setopt inc_append_history       # Load history only on startup but append in realtime
setopt hist_verify              # Upon hitting enter, reload line into edit buf


# ------------------------------------------------------------------------------------ #
# --                               Key bindings                                     -- #
# ------------------------------------------------------------------------------------ #

# Detele a single character with DEL
bindkey "^?" backward-delete-char

# History back/forward search with up/down arrow
bindkey '^[[A' history-beginning-search-backward # '^[[A' = Up-arrow
bindkey '^[[B' history-beginning-search-forward  # '^[[B' = Down-arrow

# History forward/backward search with j/k in normal mode
bindkey -a j history-beginning-search-forward
bindkey -a k history-beginning-search-backward

# Bind HOME/END to 'go to beginig/end of line' and DEL to delete character under cursor
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[3~' delete-char

# ------------------------------------------------------------------------------------ #
# --                                    Misc                                        -- #
# ------------------------------------------------------------------------------------ #

# Bat colorscheme. Available bat colorschemes can be listed with 'bat --list-themes'.
export BAT_THEME="gruvbox-dark"

# Man pages coloring and formating using nvim or bat
if command -v nvim 1>/dev/null 2>&1; then
    export MANPAGER='nvim +Man!'
elif command -v bat 1>/dev/null 2>&1; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
else
    echo "[ .zshrc:${LINENO} ]:" \
         "Warning: neither 'nvim' nor 'bat' in \${PATH} for man-page formating"
fi

# Enable zsh autocompletion
autoload -U compinit
compinit -d "${HOME}/.config/zsh/.zcompdump"

