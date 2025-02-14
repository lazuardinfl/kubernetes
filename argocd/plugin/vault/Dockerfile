FROM alpine:3.21

ARG CUSTOM_CA=ca/*
ARG AVP=argocd-vault-plugin
ARG KUSTOMIZE=kustomize

# Switch to root for the ability to perform install
USER root

# Install tools needed to retrieve & decrypt secrets, render manifests
RUN apk add --upgrade --no-cache \
    gpg curl ca-certificates

# Add custom root CA
COPY ${CUSTOM_CA} /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Install the AVP plugin (as root so we can copy to /usr/local/bin)
COPY ${AVP} /usr/local/bin/argocd-vault-plugin
RUN chmod +x /usr/local/bin/argocd-vault-plugin

# Install Kustomize
COPY ${KUSTOMIZE} /usr/local/bin/kustomize
RUN chmod +x /usr/local/bin/kustomize

# Copy optional entrypoint to download tools
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Switch back to non-root user
USER 999
