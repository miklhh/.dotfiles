#
# My personal .zshrc configuration as of 2020-04-20 for usage at bumble and
# GLaDOS. Very miniscule configuration, but it does the job.
#


# Basic ENV variables.
export HOST=$(hostname)
export NAME=$(whoami)
export PATH="$HOME/sw:$PATH"
export EDITOR="vim"
export PAGER="less"

# High DPI features.
export QT_AUTO_SCEEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1.25

# ZSH aliases.
alias ls='ls --color=auto'
alias ll='ls -l'

# It is only worth using P10K in a non linux TTY type terminal (and if it
# exists!). Usage in TTYs and on systems without p10k is laaaame.
if [ "$TERM" != "linux" ] && [ -f "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ]
then
    P10K_NORMAL="$HOME/.p10k_norm.zsh"
    P10K_FLAT="$HOME/.p10k_flat.zsh"
    fc-list -q 'MesloLGS NF' && source "$P10K_NORMAL" || source "$P10K_FLAT"
    source ~/powerlevel10k/powerlevel10k.zsh-theme
else
    autoload -U colors && colors
    PROMPT="%{$fg[cyan]%}$NAME%{$reset_color%}@%{$fg[green]%}$HOST%{$reset_color%}%{$fg[yellow]%} $PWD$reset_color \$ "
fi

