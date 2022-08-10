#!/usr/bin/env bash
#
# Ubuntu 22.04: Unattended bootstraper for freshly installed system
# Author: Mikael Henriksson (2022)
#

set -e
SUDOER_USER="${SUDO_USER}"
SUDOER_USER_HOME="$(eval echo ~${SUDOER_USER})"

# Add Ubuntu external repositories (to only run apt update once)
add-apt-repository -y ppa:neovim-ppa/unstable
apt update

# Build essentials
BUILD_ESSENTIALS_APT_PACKAGES="build-essential manpages-dev git curl"
apt-get -y install ${BUILD_ESSENTIALS_APT_PACKAGES}

# NeoVim unstable
apt-get -y install neovim vim xclip wl-clipboard

# Rust & Co (un-attended rustup install)
RUST_APT_PACKAGES="bat ripgrep"
RUST_CARGO_PACKAGES="git-delta"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo --user=${SUDOER_USER} bash -s -- -y
sudo --user=${SUDOER_USER} -- bash -c ". ~/.cargo/env && cargo install ${RUST_CARGO_PACKAGES}"
apt-get -y install ${RUST_APT_PACKAGES}

# Ubuntu: symbolic link batcat -> bat
sudo --user=${SUDOER_USER} mkdir -p "${SUDOER_USER_HOME}/.local/bin"
sudo --user=${SUDOER_USER} ln -s /usr/bin/batcat "${SUDOER_USER_HOME}/.local/bin/bat"

# Shell & Co
SHELL_APT_PACKAGES="zsh tmux bfs fzf"
apt-get -y install ${SHELL_APT_PACKAGES}

# Python packages
PYTHON_APT_PACKAGES="pip"
PYTHON_PIP_PACKAGES="numpy matplotlib sympy ipython"
apt-get -y install ${PYTHON_APT_PACKAGES}
sudo --user=${SUDOER_USER} -- bash -c "pip install --upgrade --user ${PYTHON_PIP_PACKAGES}"

# Other packages
apt-get -y install htop inkscape texlive-full

