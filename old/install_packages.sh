#!/bin/bash

## Get directory of script.
DIR="$(dirname "$(readlink -f "$0")")"
PACKAGES="$DIR"/packages.txt

## Script should run with root privileges.
if [ "$(id -u)" -ne 0 ]
then
    echo "$0 should be run with root privileges."
    exit 1
fi

## Test for internet connection.
nc -zw1 google.com 443 1> /dev/null 2>&1
if [ "$?" -ne 0 ]
then
    echo "$0 cannout run without a internet connection."
    exit 1
fi

## Iterativly install each of the package.
#for FONT in "${FONTS[@]}"
while IFS= read -r line
do
    if [[ "${line:0:1}" != "" && "${line:0:1}" != "#" ]]
    then
        echo "(*) Installing package: $line"
        pacman --noconfirm -S "$line" 1> /dev/null
        PACMAN_RETURN_CODE=$?
        if [ "$PACMAN_RETURN_CODE" -ne 0 ]
        then
            ## Pacman failed to install a font.
            echo "error: Pacman failed to install: $line, code: $PACMAN_RETURN_CODE"
            exit 1
        fi
    fi
done < "$PACKAGES"
