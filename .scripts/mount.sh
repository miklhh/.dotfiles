#!/bin/sh
#
# Mount your Linköping University (LiU) home directory under ${MOUNT_POINT}. The mount point is created with sshfs,
# which requires kernel config CONFIG_FUSE_FS and the userspace programs libfuse and sshfs. The LiU home directory is
# mounted under ${MOUNT_POINT} and uses one of the FIL-LAGER servers filur0[0-7].it.liu.se. The FIL-LAGER servers are
# only accessable from within the university network. The script (sshfs) will prompt you for your LiU password. The
# mount point is un-mounted from the command line with `umount ${MOUNT_POINT}`
#
LIU_ID="mikhe33"
MOUNT_POINT="${HOME}/${LIU_ID}"
FILUR_SERVER="filur05"

id -u ${LIU_ID} 2>/dev/null 1>&2 && MOUNT_UID=$(id -u ${LIU_ID}) || MOUNT_UID=$(id -u)
id -g ${LIU_ID} 2>/dev/null 1>&2 && MOUNT_GID=$(id -g ${LIU_ID}) || MOUNT_GID=$(id -g)

echo " * Using mount point: ${MOUNT_POINT}"
[ -d "${MOUNT_POINT}" ] || mkdir -v "${MOUNT_POINT}"

echo " * Connecting to ${FILUR_SERVER}"

# SAMBA mount
#sudo mount -t cifs -o vers=3.1.1,cifsacl,username=mikhe33,domain=AD,uid=mikl,gid=mikl //ad.liu.se/home/mikhe33 mikhe33

### Do not reconnect on connection failure
#sshfs -o ServerAliveInterval=15,ServerAliveCountMax=3,uid="${MOUNT_UID}",gid="${MOUNT_GID}" "${LIU_ID}@${FILUR_SERVER}.it.liu.se:/staff/${LIU_ID}" "${MOUNT_POINT}"

### Automatic reconnect (seems to cause problem on the LiU-IT side after a connectection is broken)
sshfs -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,uid="${MOUNT_UID}",gid="${MOUNT_GID}" "${LIU_ID}@${FILUR_SERVER}.it.liu.se:/staff/${LIU_ID}" "${MOUNT_POINT}"

SSHFS_RETURNCODE="${?}"

if [ "${SSHFS_RETURNCODE}" -eq 0 ]; then
    echo " * Successfully mounted"
    exit 0
else
    echo " * Mount failed"
    exit "${SSHFS_RETURNCODE}"
fi

