#!/usr/bin/env bash
#
# Ubuntu 22.04: Unattended bootstraper for freshly installed system
# Author: Mikael Henriksson (2022)
#

set -e
SUDO_USER_HOME="$(eval echo "~${SUDO_USER}")"

# Add Ubuntu external repositories (to only run apt update once)
add-apt-repository -y ppa:neovim-ppa/unstable
apt update

# NeoVim unstable
apt-get -y install neovim vim xclip wl-clipboard

# Build essentials
apt-get -y install  \
    build-essential \
    curl            \
    git             \
    manpages-dev

# Python3
apt-get -y install  \
    pip             \
    python3         \
    python3-venv    \
PYTHON_PIP_PACKAGES="numpy matplotlib sympy ipython pynvim pygments"
sudo --user="${SUDO_USER}" -- bash -c "pip install --upgrade --user ${PYTHON_PIP_PACKAGES}"

# Rust & Co (un-attended rustup install)
apt-get -y install  \
    bat             \
    ripgrep
RUST_CARGO_PACKAGES="git-delta fd-find"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo --user="${SUDO_USER}" bash -s -- -y
sudo --user="${SUDO_USER}" -- bash -c ". ~/.cargo/env && cargo install ${RUST_CARGO_PACKAGES}"

# Ubuntu: symbolic link batcat -> bat
sudo --user="${SUDO_USER}" mkdir -p "${SUDO_USER_HOME}/.local/bin"
sudo --user="${SUDO_USER}" ln -s /usr/bin/batcat "${SUDO_USER_HOME}/.local/bin/bat"

# (Z)Shell and company
apt-get -y install  \
    bfs             \
    fzf             \
    tmux            \
    zsh

# Other packages
apt-get -y install              \
    fuse3                       \
    htop                        \
    inkscape                    \
    libfuse2                    \
    npm                         \
    texlive-full                \
    tree                        \
    xdg-desktop-portal          \
    xdg-desktop-portal-gnome    \
    xdg-desktop-portal-gtk

