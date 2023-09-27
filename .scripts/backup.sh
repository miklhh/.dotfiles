#!/bin/sh

# Setting this, so the repo does not need to be given on the commandline:
# export BORG_REPO=ssh://frask53@liu:22/~/backup/office
export BORG_REPO=ssh://mikhe33@only-da-bash/home/mikhe33/backup/maokai

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

borg create                         \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    --exclude-caches                \
    --exclude "${HOME}/opt"         \
    --exclude "${HOME}/snap"        \
    --exclude "${HOME}/Downloads"   \
    --exclude "${HOME}/tmp"         \
    --exclude "${HOME}/.vboxes"     \
    --exclude "${HOME}/.cache"      \
    --exclude "${HOME}/.local"      \
    --exclude "${HOME}/.wine"       \
    --exclude "${HOME}/.venv"       \
    --exclude "${HOME}/.rustup"     \
    --exclude "${HOME}/.cargo"      \
    --exclude "${HOME}/.matlab"     \
    --exclude "${HOME}/.Xilinx"     \
    --exclude "${HOME}/.zoom"       \
                                    \
    ::'{hostname}-{now}'            \
    "${HOME}"                       \

backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-daily    2               \
    --keep-weekly   4               \
    --keep-monthly  0               \

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup and Prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup and/or Prune finished with warnings"
else
    info "Backup and/or Prune finished with errors"
fi

exit ${global_exit}
