#!/bin/sh
# 
# Automization of Arch Linux installation with mArch configuration.
#

BOOT_MODE="UNKNOWN"

welcomemsg() {
    echo "Hi"
}

getbootmode() {
    if ls /sys/firmware/efi/efivars 1> /dev/null 2>&1
    then
        BOOT_MODE="UEFI"
    else
        BOOT_MODE="BIOS"
    fi
    echo "Boot mode detected: $BOOT_MODE"
}

partition_disk() {
    echo "In this step we want to partition a disk. This is a delicate process and therefore you will be prompted with cfdisk, a user friendly TUI disk partitioner."
    echo "In this step we are interested in:"
    partition_disk_print_req

    DISK_PARTITION_DONE="false"
    while [ "$DISK_PARTITION_DONE" = "false" ]
    do
        # Launch CFDISK (Live BOOT has root privilege).
        echo ""
        read -r -p "Press any key to launch CFDISK..." DONT_CARE
        cfdisk
        clear
    
        # Prompt result.
        echo "******************"
        echo "* CURRENT STATUS *"
        echo "******************"
        fdisk -l | grep "Device" -A 20
        echo ""
        partition_disk_print_req
        echo ""
        echo "If you satisfy all the requierment, that is having atleast the requiered partitions for one disk, you can now continue. Otherwise you'll need to go back to cfdisk and try to satisfy the requierments again."
        read -r -p "Do you want to continue (are you satisfying the requierments?) (y/N)? " answer
        case ${answer} in
            y|Y)
                # User completed disk partitioning.
                DISK_PARTITION_DONE="true";;
            *)
                # User wants to launch cfdisk again.
                DISK_PARTITION_DONE="false";;
        esac

    done
}

partition_disk_print_req() {
    if [ $BOOT_MODE = "UEFI" ]
    then
        echo ""
        echo "****************"
        echo "* REQUIREMENTS *"
        echo "****************"
        echo "  Mount point  | Partition |    Partition Type    |  Suggested Size  "
        echo "---------------------------------------------------------------------"
        echo "   /mnt/boot   | /dev/sdX1 | EFI System partition |     260-512 M    "
        echo "     /mnt      | /dev/sdX2 |    Linux root (/)    |                  "
        echo "    [NONE]     | /dev/sdX3 |      Linux swap      |  More than 512 M "
    else
        echo ""
        echo " * REQUIREMENTS *"
        echo "  Mount point  | Partition |    Partition Type    |  Suggested Size  "
        echo "---------------------------------------------------------------------"
        echo "     /mnt      | /dev/sdX1 |    Linux root (/)    |                  "
        echo "    [NONE]     | /dev/sdX2 |      Linux swap      |  More than 512 M "
    fi
}

change_live_env_keymap() {
    read -r -p "Do you want to switch to swedish keyboard layout (y/N)? " answer
    case ${answer} in
        y|Y)
            # Set swedish keyboard layout.
            LIVE_ENV_KEYMAP_SE="/usr/share/kbd/keymaps/atari/atari-se.map.gz"
            if loadkeys "$LIVE_ENV_KEYMAP_SE" 
            then
                echo "Error loading swedish keymap. Continuing anyway..."
            else
                echo "Swedish keymap loaded ($LIVE_ENV_KEYMAP_SE)"
            fi;;
        *)
            # No change to keyboard layout.
            echo "No change to keyboard layout."
    esac
}

welcomemsg

getbootmode

partition_disk
