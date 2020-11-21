#!/bin/bash

# ensure cert path exists
mkdir -p ${CERT_PATH}

# add tls cert and key files
cat>${CERT_PATH}/tls.crt<<EOF
${TLS_CRT}
EOF

cat>${CERT_PATH}/tls.key<<EOF
${TLS_KEY}
EOF
