# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/home/mikl/.oh-my-zsh"

# Theme of zsh.
ZSH_THEME="powerlevel10k/powerlevel10k"

# High DPI features.
export QT_AUTO_SCEEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1.25

# Extend PATH
export PATH="$HOME/sw:$PATH"


# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# It is only worth using oh-my-zsh in a non linux tty type terminal. Such a use
# would greatly garble a tty terminal output.
if [ "$TERM" != "linux" ]
then
    source $ZSH/oh-my-zsh.sh
else
    PROMPT="$PWD \$ $reset_color"
fi

# User configuration
export EDITOR='vim'

# Aliases
alias ll='ls -l'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
