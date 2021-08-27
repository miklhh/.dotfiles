#
# Configuration is very miniscule but it does the job both for faint tty
# sessions and in interactive colored terminal emulators. If Powerlevel10k is
# available, it is sourced.
#
# Author: Mikael Henriksson (www.github.com/miklhh)
#


#
# Export base env-variables.
#
export HOST=$(hostname)
export NAME=$(whoami)
export PAGER="less"
command -v "nvim" 1>/dev/null 2>&1 && export EDITOR="nvim" || export EDITOR="vim"

#
# Source ${HOME}.zsh-extra which can contain system specific configuration
#
[ -f "${HOME}/.zsh-extra" ] && source "${HOME}/.zsh-extra"

#
# Add ${HOME}/.cargo/bin to path if available
#
[ -d "${HOME}/.cargo/bin" ] && export PATH="${HOME}/.cargo/bin:$PATH"

#
# Add ${HOME}.local/bin to path if available
#
[ -d "${HOME}/.local/bin" ] && export PATH="${HOME}/.local/bin:$PATH"

#
# Alias Vim -> NVim
#
command -v "nvim" 1>/dev/null 2>&1 && alias vim='nvim'

#
# Settings for ls
#
if [ $(uname -s) = "Darwin" ]
then
    # MacOS machine with FreeBSD ls
    alias ls='ls -G'
else
    # Any other machine (probably Linux).
    alias ls='ls --color=auto --group-directories-first'
fi
alias ll='ls -l'

#
# Prompt settings. In a tty environment we use a basic zsh standard prompt. Same
# thing goes if P10K is not installed. If P10K is installed and this is an
# interactive shell session, we source P10K profile.
#
P10K_THEME="$HOME/.powerlevel10k/powerlevel10k.zsh-theme"
if [ "$TERM" != "linux" ] && [ -f "$P10K_THEME" ]
then
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # Interactive prompt settings. To generate a new prompt (located in
    # $HOME/.p10k.zsh), run 'p10k configure'.
    source "$P10K_THEME"
    source "$HOME/.p10k.zsh"
else
    # Non P10K prompt
    autoload -U colors && colors
    PROMPT="[%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%} %{$fg[yellow]%}%~%{$reset_color%}] $ "
fi

#
# Zsh history settings
#
[ -z "$HISTFILE" ] && export HISTFILE="$HOME/.config/zsh/.zsh-history"
export HISTSIZE=5000          # Max events stored in session
export SAVEHIST=5000          # Max events stored in history file
setopt extended_history       # Record timestamp in history file
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE is full
setopt hist_ignore_all_dups   # Remove older enties if command is a duplicate
setopt inc_append_history     # Load history only on startup but append in realtime
setopt hist_verify            # Upon hitting enter, reload line into edit buf
bindkey '^[[A' history-beginning-search-backward # '^[[A' = Up-arrow
bindkey '^[[B' history-beginning-search-forward  # '^[[B' = Down-arrow
bindkey -a j history-beginning-search-forward
bindkey -a k history-beginning-search-backward

#
# Bind HOME, END & DEL keys to get to the begining/end of the current line and
# for deleting a character
#
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[3~' delete-char

#
# Use ripgrep with fzf if available
#
if which rg 1>/dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
fi

#
# Vi keybindings. This is not always loaded by default if not specified
# explicitly, e.g., on MacOSX iTerm2
#
bindkey -v
bindkey "^?" backward-delete-char

#
# Change directory fzf style
#
if which fzf 1>/dev/null; then
    if which bfs 1>/dev/null; then
        alias cdd='cd $(bfs . -type d | fzf || echo .)'
    else
        alias cdd='cd $(find . -type d | fzf || echo .)'
    fi
else
    alias cdd='echo "fzf not in \$PATH"'
fi

#
# Enable zsh autocompletion
#
autoload -U compinit
compinit -d "${HOME}/.config/zsh/.zcompdump"

