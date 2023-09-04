#!/usr/bin/env bash
#
# Ubuntu 22.04 unattended bootstraper for freshly installed system
# Author: Mikael Henriksson (2022)
#

set -e
SUDO_USER_HOME="$(eval echo "~${SUDO_USER}")"
BOOTSTRAP_PATH="$(dirname "$(readlink -f "$0")")"

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
    python3-venv
PYTHON_PIP_PACKAGES="numpy matplotlib sympy ipython pynvim pygments"
sudo --user="${SUDO_USER}" -- \
    bash -c "pip install --upgrade --user ${PYTHON_PIP_PACKAGES}"

# Rust & Co (un-attended rustup install)
apt-get -y install  \
    bat             \
    ripgrep
RUST_CARGO_PACKAGES="git-delta fd-find"
sudo --user="${SUDO_USER}"                              \
    bash "${BOOTSTRAP_PATH}/rustup-init-1.26.0.sh"      \
        --default-host="x86_64-unknown-linux-gnu"       \
        --default-toolchain="stable"                    \
        --profile="default"                             \
        --no-modify-path                                \
        -y
sudo --user="${SUDO_USER}" -- \
    bash -c ". ~/.cargo/env && cargo install ${RUST_CARGO_PACKAGES}"
# Triple: x86_64-unknown-linux-gnu
# Toolchain: stable
# Profile: default
# Modify PATH: no

# Ubuntu: symbolic link batcat -> bat
if [ ! -f "${SUDO_USER_HOME}/.local/bin/bat" ]; then
    sudo --user="${SUDO_USER}" mkdir -p "${SUDO_USER_HOME}/.local/bin"
    sudo --user="${SUDO_USER}" ln -s /usr/bin/batcat "${SUDO_USER_HOME}/.local/bin/bat"
fi

# (Z)Shell and company (fzf is installed from git)
apt-get -y install  \
    bfs             \
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

