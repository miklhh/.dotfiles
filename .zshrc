#
# Configuration is very miniscule but it does the job both for faint tty sessions and in interactive colored terminal
# emulators. If Powerlevel10k is available it is sourced. If not, a fallback prompt is available.
#
# Author: Mikael Henriksson (www.github.com/miklhh)
#


# --------------------------------------------------------------------------------------------------------------------
# --                                              Environment settings                                              --
# --------------------------------------------------------------------------------------------------------------------

# Export base env-variables.
export HOST=$(uname -n)
export NAME=$(whoami)
export PAGER="less"
export DOTFILES="${HOME}/.dotfiles"
command -v "nvim" 1>/dev/null 2>&1 && export EDITOR="nvim" || export EDITOR="vim"

# Add ${HOME}.local/bin to path if available
[ -d "${HOME}/.local/bin" ] && export PATH="${HOME}/.local/bin:${PATH}"

# Add ${HOME}/.cargo/bin to path if available
[ -d "${HOME}/.cargo/bin" ] && export PATH="${HOME}/.cargo/bin:${PATH}"

# Source ${HOME}/.zsh-local which can contain machine/system specific zsh settings
[ -f "${HOME}/.zsh-local" ] && source "${HOME}/.zsh-local"

# Source the zsh aliasing file if available
[ -f "${HOME}/.zsh-alias" ] && source "${HOME}/.zsh-alias" \
    || echo "[ .zshrc:${LINENO} ]: Warning: \${HOME}/.zsh-alias unavailable"

# Global glob-settings for ripgrep (rg)
RG_GLOB='!{node_modules,.git}'

# Preferred number of threads for use by ripgrep (rg) when traversing files and directories. Set to zero (0) to let
# ripgrep decide using its heuristics.
RG_THREADS='0'

# Default to Vim keybindings no matter the ${EDITOR}/${VISUAL} environment variables. More key binding are found 
# below under 'Key bindings'. The 'bindkey -v' option must be set before the FZF settings are loaded, as FZF depends
# on it being set properly.
bindkey -v

# --------------------------------------------------------------------------------------------------------------------
# --                                                 FZF settings                                                   --
# --------------------------------------------------------------------------------------------------------------------
if command -v fzf 1>/dev/null 2>&1; then
    # Fuzzy finder 'fzf' available
    # Source fzf command line completion scripts
    source "${HOME}/.dotfiles/.fzf-completion.zsh"
    source "${HOME}/.dotfiles/.fzf-key-bindings.zsh"
    FZF_COMPLETION_TRIGGER=''
    FZF_COMPLETION_OPTS='--border --info=inline' 
    bindkey '^T' fzf-completion
    bindkey '^I' $fzf_default_completion

    # (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
    # - The first argument to the function is the name of the command.
    # - You should make sure to pass the rest of the arguments to fzf.
    _fzf_comprun() {
      local command=$1
      shift
      case "$command" in
        cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
        export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
        ssh)          fzf "$@" --preview 'dig {}' ;;
        *)            fzf "$@" ;;
      esac
    }

    if command -v rg 1>/dev/null 2>&1; then
        # Ripgrep (rg) available in path, use it for path list completion on zsh fzf-completion and on fzf call
        export FZF_DEFAULT_COMMAND="rg -j${RG_THREADS} -g${RG_GLOB} --files --hidden --no-ignore-vcs"
        _fzf_compgen_path() {
            rg -j${RG_THREADS} -g${RG_GLOB} --files --hidden --no-ignore-vcs "$1" 2>/dev/null
        }
    else
        # Ripgrep (rg) not in $PATH, regular GNU (or BSD) find will be used for command-line completion with fzf
        echo "[ .zshrc:${LINENO} ]: Warning: 'rg' not in \${PATH}"
    fi

    if command -v bfs 1>/dev/null 2>&1; then
        # Breadth first search (bfs) available in path, use it for directory list completion in zsh fzf-completion
        _fzf_compgen_dir() {
            bfs "$1" -type d -exclude -name .git 2>/dev/null
        }
    fi
else
    # Fuzzy finder 'fzf' unavailable
    echo "[ .zshrc:${LINENO} ]: Warning: 'fzf' not in \${PATH}"
fi

# --------------------------------------------------------------------------------------------------------------------
# --                                                Prompt settings                                                 --
# --------------------------------------------------------------------------------------------------------------------
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
    if is-at-least "5.3.0"; then
        # If the dotfiles are bootstraped from 'https://github.com/miklhh/.dotfiles', then '${HOME}/.powerlevel10k'
        # will be a symlink to '${HOME}/.dotfiles/powerlevel10k'. If this '.zshrc' file is used stand alone, the user
        # will manually have to install Powerlevel10k into '${HOME}/.powerlevel10k'.
        [ -d "${HOME}/.powerlevel10k" ] && P10K_THEME="${HOME}/.powerlevel10k/powerlevel10k.zsh-theme"
        if [ -f "${P10K_THEME}" ]; then
            set_prompt_p10k
        else
            echo "[ .zshrc:${LINENO} ]: Warning: directory ${HOME}/.powerlevel10k unavailable"
            set_prompt_plain
        fi
    else # Zsh version lower than 5.3.0
        echo "[ .zshrc:${LINENO} ]: Warning: Zsh version (${ZSH_VERSION}) lower than 5.3.0, could not load Powerlevel10k"
        set_prompt_plain
    fi
else
    set_prompt_plain
fi

source ~/.dotfiles/zsh-autosuggestions/zsh-autosuggestions.zsh

# --------------------------------------------------------------------------------------------------------------------
# --                                                 History settings                                               --
# --------------------------------------------------------------------------------------------------------------------
HISTFILE="${HOME}/.config/zsh/.zsh-history"
HISTSIZE=5000                   # Max events stored in session
SAVEHIST=5000                   # Max events stored in history file
setopt extended_history         # Record timestamp in history file
setopt hist_expire_dups_first   # Delete duplicates first when HISTFILE is full
setopt hist_ignore_all_dups     # Remove older enties if command is a duplicate
setopt inc_append_history       # Load history only on startup but append in realtime
setopt hist_verify              # Upon hitting enter, reload line into edit buf


# --------------------------------------------------------------------------------------------------------------------
# --                                                 Key bindings                                                   --
# --------------------------------------------------------------------------------------------------------------------

# History search with <CTRL-R> and <CTRL-F>
bindkey "^?" backward-delete-char
bindkey '^R' history-incremental-search-backward
bindkey '^F' history-incremental-search-forward

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

# --------------------------------------------------------------------------------------------------------------------
# --                                                 Misc                                                           --
# --------------------------------------------------------------------------------------------------------------------

# Bat colorscheme. Available bat colorschemes can be listed with 'bat --list-themes'.
export BAT_THEME="gruvbox-light"

# Man pages coloring and formating using nvim or bat
if command -v nvim 1>/dev/null 2>&1; then
    export MANPAGER='nvim +Man!'
elif command -v bat 1>/dev/null 2>&1; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
else
    echo "[ .zshrc:${LINENO} ]: Warning: neither 'nvim' nor 'bat' in \${PATH} for man-page formating"
fi

# Enable zsh autocompletion
autoload -U compinit
compinit -d "${HOME}/.config/zsh/.zcompdump"

