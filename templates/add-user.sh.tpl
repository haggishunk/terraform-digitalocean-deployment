#!/bin/env bash

# add user
useradd -s $(which bash) -m ${USERNAME}

# make sudoer
cat>/etc/sudoers.d/${USERNAME}<<EOF
${USERNAME} ALL=(ALL) NOPASSWD:ALL
EOF

# set up ssh
mkdir /home/${USERNAME}/.ssh
cp /root/.ssh/authorized_keys /home/${USERNAME}/.ssh/authorized_keys
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh

# turn off root logins
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g'
