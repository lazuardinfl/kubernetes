FROM debian:12.7-slim

ARG ROOT_CA=ca/*
ARG AVP=argocd-vault-plugin
ARG KUSTOMIZE=kustomize

# Switch to root for the ability to perform install
USER root

# Install tools needed for your repo-server to retrieve & decrypt secrets, render manifests
# (e.g. curl, awscli, gpg, sops)
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        gpg \
        curl \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add custom root CA
COPY ${ROOT_CA} /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Install the AVP plugin (as root so we can copy to /usr/local/bin)
COPY ${AVP} /usr/local/bin/argocd-vault-plugin
RUN chmod +x /usr/local/bin/argocd-vault-plugin

# Install kustomize
COPY ${KUSTOMIZE} /usr/local/bin/kustomize
RUN chmod +x /usr/local/bin/kustomize

# Switch back to non-root user
USER 999
