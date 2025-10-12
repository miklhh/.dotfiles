#!/usr/bin/env bash

# Stop script on command failure
set -e

# Work and download directory: .dotfiles/.local/share/fonts
BASEDIR=$(dirname "$0")
cd "${BASEDIR}"

# Download the four MesloLGS Nerd fonts
LINK_BASE="https://github.com/romkatv/powerlevel10k-media/raw/master"
[ -f 'MesloLGS NF Regular.ttf' ] || wget --quiet "${LINK_BASE}/MesloLGS%20NF%20Regular.ttf"
[ -f 'MesloLGS NF Bold.ttf' ] || wget --quiet "${LINK_BASE}/MesloLGS%20NF%20Bold.ttf"
[ -f 'MesloLGS NF Italic.ttf' ] || wget --quiet "${LINK_BASE}/MesloLGS%20NF%20Italic.ttf"
[ -f 'MesloLGS NF Bold Italic.ttf' ] || wget --quiet "${LINK_BASE}/MesloLGS%20NF%20Bold%20Italic.ttf"
