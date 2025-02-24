#!/bin/sh

set -e

mkdir -p /custom-tools

if [ ! -z "${AVP_URL}" ]; then
    curl -L "${AVP_URL}" -o argocd-vault-plugin
    mv -f argocd-vault-plugin /usr/local/bin/argocd-vault-plugin
fi

if [ ! -z "${KUSTOMIZE_URL}" ]; then
    curl -L "${KUSTOMIZE_URL}" -o kustomize.tar.gz
    tar xvzf kustomize.tar.gz
    mv -f kustomize /usr/local/bin/kustomize
    rm kustomize.tar.gz
fi

cp -f /usr/local/bin/argocd-vault-plugin /custom-tools/argocd-vault-plugin
chmod +x /custom-tools/argocd-vault-plugin

cp -f /usr/local/bin/kustomize /custom-tools/kustomize
chmod +x /custom-tools/kustomize
