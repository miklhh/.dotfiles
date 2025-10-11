#!/usr/bin/env bash
#
# Ubuntu 24.04 unattended bootstrapper for freshly installed system
# Author: Mikael Henriksson (2024)
#

# Stop on script failure
set -e

SUDO_USER_HOME="$(eval echo "~${SUDO_USER}")"
BOOTSTRAP_PATH="$(dirname "$(readlink -f "$0")")"

# Add NeoVim PPA
add-apt-repository -y ppa:neovim-ppa/unstable

# Add Syncthing PPA with PGP key
"${BOOTSTRAP_PATH}"/ubuntu-syncthing-ppa.bash

# Perform apt repository refresh
apt-get update

# NeoVim unstable
apt-get -y install neovim vim xclip wl-clipboard

# Syncthing
apt-get -y install syncthing

# Build essentials
apt-get -y install  \
    build-essential \
    curl            \
    git             \
    manpages-dev

# Python3
apt-get -y install          \
    python3                 \
    python3-pip             \
    python3-venv            \
    python3-numpy           \
    python3-matplotlib      \
    python3-sympy           \
    python3-ipython         \
    python3-pygments

# Rust & Co (un-attended rustup install)
apt-get -y install  \
    bat             \
    ripgrep
RUST_CARGO_PACKAGES="git-delta fd-find fnm"
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
    texlive-full                \
    tree                        \
    xdg-desktop-portal          \
    xdg-desktop-portal-gnome    \
    xdg-desktop-portal-gtk

# Purge NodeJS from the system
apt-get -y remove nodejs npm
rm -rf "${SUDO_USER_HOME}/.npm"
rm -rf "${SUDO_USER_HOME}/.node-gyp"
rm -rf /usr/local/bin/npm
rm -rf /usr/local/share/man/man1/node*
rm -rf /usr/local/lib/dtrace/node.d
rm -rf /opt/local/bin/node
rm -rf /opt/local/include/node
rm -rf /opt/local/lib/node_modules
rm -rf /usr/local/lib/node*
rm -rf /usr/local/include/node*
rm -rf /usr/local/bin/node*
