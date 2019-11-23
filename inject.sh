#!/bin/sh

#
# Part of mArch build script. Usage of this injection script requires the host
# system to have the following programs installed and added to PATH:
#   * xorriso
#   * unsquashfs/mksquashfs (known as squashfs-tools)
#   * isoinfo (from cdrtools)
# Most system will have to run this script with root privileges (sudo) sense
# the extracted Arch filesystem from the ISO will preserve the file owenership
# status of the Arch ISO system root.

# Processors to use.
PROCESSORS="255"

# Directories.
MNT_DIR="fmnt"
ISO_DIR_CUSTOM="$MNT_DIR/customiso"
ISO_DIR_MOUNT="$MNT_DIR/archiso"
ISO_OUT="mArch-custom.iso"
SQUASHFS_ROOT_DIR="squashfs-root"

# Cleanup function.
cleanup() {
    # Remove mount directory.
    if ls "$ISO_DIR_MOUNT" 1>/dev/null 2>&1
    then
        rmdir "$ISO_DIR_MOUNT"
    fi

    # Remove custom ISO directory.
    if ls "$ISO_DIR_CUSTOM" 1>/dev/null 2>&1
    then
        rm -rf "$ISO_DIR_CUSTOM"
    fi

    # Remove squashfs-root
    if ls squashfs-root 1>/dev/null 2>&1
    then
        rm -rf "$SQUASHFS_ROOT_DIR"
    fi

    # Remove injected Arch root archive.
    if ls airootfs.sfs 1>/dev/null 2>&1
    then
        rm -f airootfs.sfs
        rm -f airootfs.sha512
    fi
    rmdir "$MNT_DIR"
}

# Unmount function.
unmount() {
    # Unmount the Arch ISO.
    if ls "$ISO_DIR_MOUNT" 1>/dev/null 2>&1
    then
        if umount "$ISO_DIR_MOUNT" >> "$LOG_FILE" 2>&1
        then
            echo "* Mountpoint unmounted/removed."
        else
            echo "* Could not unmount Arch ISO."
        fi
    fi
}

# Exit failure function.
EXIT_FAILURE_CODE="1"
exit_failure() {
    unmount
    cleanup
    echo "See log file '$LOG_FILE' for more info."
    exit $EXIT_FAILURE_CODE
}

# Test for requiered software.
HAS_ALL_REQUIERED_SOFTWARE="true"
test_software() {
    if [ "$1" = "" ]
    then
        HAS_ALL_REQUIERED_SOFTWARE="false"
        printf "Software: %-11s%s\n" "$2" "[ ]"
    else
        printf "Software: %-11s%s\n" "$2" "[X]"
    fi
}

test_software "$(command -v isoinfo)"    "isoinfo"
test_software "$(command -v xorriso)"    "xorriso"
test_software "$(command -v mksquashfs)" "mksquashfs"
test_software "$(command -v unsquashfs)" "unsquashfs"
if [ "$HAS_ALL_REQUIERED_SOFTWARE" != "true" ]
then
    echo "* Software missing in PATH. Please install software and/or add to PATH."
    exit "$EXIT_FAILURE_CODE"
else
    echo "* Injection tools OK!"
fi

# Extract ISO image filename.
ISO_COUNT=$(find . -maxdepth 1 -name "archlinux-*.iso" | wc -l)
if [ "$ISO_COUNT" = "0" ]
then
    echo "* No Arch Linux ISO image found in directory."
    exit 1
elif [ "$ISO_COUNT" != "1" ]
then
    echo "* Multiple Arch Linux ISO images found in directory."
    exit 1
else
    ISO_FILE=$(ls archlinux-*.iso 2>/dev/null)
    echo "* Arch Linux ISO image detected: '$ISO_FILE'."
fi

# Create new logfile.
LOG_FILE="LOG_INJECT.txt"
echo "--- mArch injection log: ---" > "$LOG_FILE"
echo "* New log file created: '$LOG_FILE'."

# Create work mount directory.
mkdir -p "$ISO_DIR_MOUNT"

# Mount the Arch ISO.
if mount -t iso9660 -o loop "$ISO_FILE" "$ISO_DIR_MOUNT" >> "$LOG_FILE" 2>&1
then
    echo "* Successfully mounted '$ISO_FILE' to '$ISO_DIR_MOUNT'."
else
    echo "* Could not mount Arch ISO. Perhaps you need to rerun with root privileges."
    exit_failure
fi

# Copy the content to the word directory.
if cp -a "$ISO_DIR_MOUNT" "$ISO_DIR_CUSTOM"
then
    echo "* Successfully copied ISO content to '$ISO_DIR_CUSTOM'."
else
    echo "* Failed to copy ISO content to '$ISO_DIR_CUSTOM'."
    exit_failure
fi

# Unsquashify the airootfs.sfs.
SQUASHFS_PATH="mnt/customiso/arch/x86_64/airootfs.sfs"
echo "* Extracting '$SQUASHFS_PATH':"
if unsquashfs -processors "$PROCESSORS" -q "$ISO_DIR_CUSTOM"/arch/x86_64/airootfs.sfs 2>>"$LOG_FILE"
then
    echo "* Successfully extracted 'airootfs.sfs'."
else
    echo "* ERROR: Could not unsquashify 'airootfs.sfs'. See log for more info."
    exit_failure
fi

# Copy content.
echo "* Injecting Arch filesystem ('$SQUASHFS_ROOT_DIR'):"
cp install_packages.sh "$SQUASHFS_ROOT_DIR"/root/install_packages.sh
cp packages.txt "$SQUASHFS_ROOT_DIR"/root/packages.txt

# Make new squash archive.
if mksquashfs "$SQUASHFS_ROOT_DIR" airootfs.sfs -quiet -processors "$PROCESSORS" 2>>"$LOG_FILE"
then
    echo "* Successfully recreated Arch root archive ('airootfs.sfs')."
else
    echo "* ERROR: Could not recreate 'airootfs.sfs'. Exiting"
    exit_failure
fi

# Create archive checksum.
sha512sum airootfs.sfs > airootfs.sha512

# Copy the files to the new isodir.
cp airootfs.sfs "$ISO_DIR_CUSTOM"/arch/x86_64/airootfs.sfs
cp airootfs.sha512 "$ISO_DIR_CUSTOM"/arch/x86_64/airootfs.sfa512

# Extract the ISO Volume label.
ISO_VOL=$(isoinfo -d -i "$ISO_FILE" 2>/dev/null | awk '/Volume id:/{print $3}')

# Generate new isofile.
echo "* Generating new ISO file (ISO Volume label: $ISO_VOL)..."
xorriso -as mkisofs \
        -iso-level 3 \
        -full-iso9660-filenames \
        -volid "${ISO_VOL}" \
        -eltorito-boot isolinux/isolinux.bin \
        -eltorito-catalog isolinux/boot.cat \
        -no-emul-boot -boot-load-size 4 -boot-info-table \
        -isohybrid-mbr "$ISO_DIR_CUSTOM"/isolinux/isohdpfx.bin \
        -output "$ISO_OUT" \
        "$ISO_DIR_CUSTOM"

# End of program, cleanup.
unmount
cleanup
echo "* Unmount and cleanup done."
echo "* Injection successful, '$ISO_OUT' created."
exit 0
