#!/usr/bin/env bash
#
# More information here:
# https://apt.syncthing.net/
#

# Stop on script failure
set -e

# Add the release PGP keys:
mkdir -p /etc/apt/keyrings
curl -L -o                                          \
    /etc/apt/keyrings/syncthing-archive-keyring.gpg \
    https://syncthing.net/release-key.gpg

# Add the "stable" channel to your APT sources:
echo \
    "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" \
    | sudo tee /etc/apt/sources.list.d/syncthing.list

# Add the "candidate" channel to your APT sources:
echo \
    "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing candidate" \
    | sudo tee /etc/apt/sources.list.d/syncthing.list
