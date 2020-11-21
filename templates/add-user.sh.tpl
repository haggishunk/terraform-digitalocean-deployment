#!/bin/bash

# add user
useradd -m ${USERNAME}
usermod -aG docker ${USERNAME}
mkdir /home/${USERNAME}/.ssh
cp /root/.ssh/authorized_keys /home/${USERNAME}/.ssh/authorized_keys
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh
