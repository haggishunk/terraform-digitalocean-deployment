#!/bin/bash

# add ca cert
mkdir /usr/local/share/ca-certificates/custom
cat>/usr/local/share/ca-certificates/custom/ca.crt<<EOF
${CA_CRT}
EOF

update-ca-certificates
