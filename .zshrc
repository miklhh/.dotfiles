#
# Configuration is very miniscule but it does the job both for faint tty
# sessions and in interactive colored terminal emulators. If Powerlevel10k is
# available, it should be sourced.
#
# Author: Mikael Henriksson (www.github.com/miklhh)
#

#
# Export base env-variables.
#
export HOST=$(hostname)
export NAME=$(whoami)
export EDITOR="vim"
export PAGER="less"

#
# Source .zsh-extra which can contain system specific configuration.
#
[ -f "${HOME}/.zsh-extra" ] && source "${HOME}/.zsh-extra" 

#
# Coloring when using ls.
#
if [ $(uname -s) = "Darwin" ]
then
    # MacOS machine with FreeBSD ls.
    alias ls='ls -G'
else
    # Any other machine (probably Linux).
    alias ls='ls --color=auto'
fi
alias ll='ls -l'

#
# Prompt settings. In a TTY environment we use a basic zsh standard prompt, same
# thing goes if P10K is not installed. If P10K is installed and this is an
# interactive shell session, we source one of two P10K-profiles based on whether
# the MesloLGD Nerd Font is available through fontconfig or not.
#
P10K_THEME="$HOME/powerlevel10k/powerlevel10k.zsh-theme"
if [ "$TERM" != "linux" ] && [ -f "$P10K_THEME" ]
then
    # Interactive prompt settings. To generate a new one, run 'p10k configure'.
    source "$P10K_THEME"
    source "$HOME/.p10k.zsh"
else
    # Not so fun prompt settings.
    autoload -U colors && colors
    PROMPT="[%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%} %{$fg[yellow]%}%~%{$reset_color%}] $ "
fi


#
# History settings. Most of these settings are straight up taken from the
# 'oh-my-zsh/lib/history.zsh' configuration. They don't require oh-my-zsh.
#
[ -z "$HISTFILE" ] && export HISTFILE="$HOME/.zsh-history"
export HISTSIZE=5000          # Max events stored in session
export SAVEHIST=5000          # Max events stored in history file
setopt extended_history       # Record timestamp in history file
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE is full
setopt hist_ignore_all_dups   # Remove older enties if command is a duplicate
setopt share_history          # Share history among ZSH sessions
setopt hist_verify            # Upon hitting enter, reload line into edit buf
bindkey '^[[A' history-beginning-search-backward # '^[[A' = Up-arrow
bindkey '^[[B' history-beginning-search-forward  # '^[[B' = Down-arrow
bindkey -a j history-beginning-search-forward
bindkey -a k history-beginning-search-backward


#
# Bind HOME, END & DEL keys to get to the begining/end of the current line and
# for deleting a character.
#
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[3~' delete-char


#
# Basic autocompletion.
#
autoload -U compinit
compinit

