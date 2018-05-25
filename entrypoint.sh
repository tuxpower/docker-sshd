#!/bin/sh

# generate host keys if not present
ssh-keygen -A

# check wether a random root-password is provided
if [ ! -z "${ROOT_PASSWORD}" ] && [ "${ROOT_PASSWORD}" != "root" ]; then
    echo "root:${ROOT_PASSWORD}" | chpasswd
fi

# check whether a SSH key is provided
if [ ! -z "${ROOT_PUBKEY}" ]; then
    echo "${ROOT_PUBKEY}" > ~/.ssh/authorized_keys
    chmod 400 ~/.ssh/authorized_keys
fi


# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
