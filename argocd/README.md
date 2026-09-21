# argocd

## crd

crd need to use server side apply because it exceeds size limit for client side apply,
use `kubectl apply --server-side --force-conflicts -f crd/argocd-crd.yaml`

## vault plugin

included vault plugin container image contains:
- Argo CD Vault Plugin v1.18.1
- Kustomize v5.4.3

if another version is needed, then environment variables can be set to download tools:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: argocd-repo-server
spec:
  template:
    spec:
      initContainers:
        - name: custom-tools
          env:
            - name: AVP_URL
              value: "https://github.com/argoproj-labs/argocd-vault-plugin/releases/download/v1.18.1/argocd-vault-plugin_1.18.1_linux_amd64"
            - name: KUSTOMIZE_URL
              value: "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.4.3/kustomize_v5.4.3_linux_amd64.tar.gz"
```
