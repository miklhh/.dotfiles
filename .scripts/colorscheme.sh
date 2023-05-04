#!/bin/sh
#
# Presistantly set the colorscheme of the terminal emulator and vim to either light or dark.
# Takes one command line argument, either "light" or "dark".
#
# Author: Mikael Henriksson (2022)
#

OS=$(uname -s)
RELEASE=$(uname -r)

# Sanitise the input
if [ "${1}" != "dark" ] && [ "${1}" != "light" ]; then
    echo "Usage: '${0} [light/dark]'"
fi

# Send a signal to
for NEOPID in $(pgrep "nvim"); do
    if [ "${1}" = "dark" ]; then
        echo "Sending SIGUSR1 to pid: ${NEOPID}"
        kill -s USR1 "${NEOPID}"
    elif [ "${1}" = "light" ]; then
        echo "Sending SIGWINCH to pid: ${NEOPID}"
        kill -s WINCH "${NEOPID}"
    fi
done
