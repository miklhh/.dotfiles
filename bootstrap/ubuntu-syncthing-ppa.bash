#!/usr/bin/env bash

# Stop on script failure
set -e

# Add the release PGP keys:
curl -o                                               \
    /usr/share/keyrings/syncthing-archive-keyring.gpg \
    https://syncthing.net/release-key.gpg

# Add the "stable" channel to your APT sources:
echo \
    "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" \
    | tee /etc/apt/sources.list.d/syncthing.list

# Add the "candidate" channel to your APT sources:
echo \
    "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing candidate" \
    | tee /etc/apt/sources.list.d/syncthing.list

