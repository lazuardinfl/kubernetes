#!/bin/bash

cd ~/projects/kubernetes/test/public-init

cat <<EOF | tee nginx.conf
overlay
public ${INIT_NAME}
new line
another
EOF

curl -fsSL -o file.txt ${INIT_FILE}