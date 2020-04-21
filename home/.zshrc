#
# .zshrc configuration for zsh usage on bumble and GLaDOS as of 2020-04-20. The
# configuration is very miniscule but it does the job both for faint tty
# sessions and in interactive colored terminal emulators.
#
# Author: Mikael Henriksson
#         www.github.com/miklhh
#


# Export base env-variables.
export HOST=$(hostname)
export NAME=$(whoami)
export PATH="$HOME/sw:$PATH"
export EDITOR="vim"
export PAGER="less"

# High DPI features (what arer they doing here?! fix this you lazy!).
export QT_AUTO_SCEEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1.25

# Aliases (should be exported to .zsh_aliases).
alias ls='ls --color=auto'
alias ll='ls -l'


#
# Prompt settings. In a TTY environment we use a basic zsh standard prompt, same
# thing goes if P10K is not installed. If P10K is installed and this is an
# interactive shell session, we source one of two P10K-profiles based on whether
# the MesloLGD Nerd Font is available through fontconfig or not.
#
P10K_INSTALL_DIR="$HOME/powerlevel10k"
P10K_THEME="$P10K_INSTALL_DIR/powerlevel10k.zsh-theme"
if [ "$TERM" != "linux" ] && [ -f "$P10K_THEME" ]
then
    # Interactive prompt settings.
    P10K_NORMAL="$HOME/.p10k_norm.zsh"
    P10K_FLAT="$HOME/.p10k_flat.zsh"
    fc-list -q 'MesloLGS NF' && source "$P10K_NORMAL" || source "$P10K_FLAT"
    source "$P10K_THEME"
else
    # Not so fun prompt settings.
    autoload -U colors && colors
    PROMPT="%{$fg[cyan]%}$NAME%{$reset_color%}@%{$fg[green]%}$HOST%{$reset_color%}%{$fg[yellow]%} $PWD$reset_color \$ "
fi


#
# History settings. Most of these settings are straight up taken from the
# 'oh-my-zsh/lib/history.zsh' configuration but, of course, don't require the
# use of oh-my-zsh framwork.
#
[ -z "$HISTFILE" ] && export HISTFILE="$HOME/.zsh-history"
export HISTSIZE=5000          # Max events stored in session.
export SAVEHIST=5000          # Max events stored in history file.
setopt extended_history       # Record timestamp in history file.
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE is full.
setopt hist_ignore_all_dups   # Remove older enties if command is a duplicate.
setopt share_history          # Share history among ZSH sessions.
setopt hist_verify            # Upon hitting enter, reload line into edit buf.
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward


#
# Rebind HOME and END keys to get to the begining/end of the current line.
#
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line


#
# Basic autocompletion.
#
autoload -U compinit
compinit

