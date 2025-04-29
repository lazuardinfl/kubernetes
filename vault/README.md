# vault

web ui cli
```
vault read auth/token/lookup
vault read auth/token/lookup-self
vault list auth/token/accessors
```

## helm

```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm template vault hashicorp/vault -n vault -f values.yaml --version 0.30.0 > temp.yaml
```

## audit

to enable audit log to stdout of kubernetes, run vault cli command
`vault audit enable file file_path=stdout`

## in-cluster traffic

To connect from another pod inside kubernetes cluster internally via domain without causing traffic to
hairpin (travel out of cluster then back in via ingress), you can add some coredns configuration below.
- `kubectl edit cm -n kube-system coredns` to edit coredns config
- add `rewrite` plugin with your domain
  ```
  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: coredns
    namespace: kube-system
  data:
    Corefile: |
      .:53 {
          ...
          ready
          rewrite name vault.domain.com vault.vault.svc.cluster.local
          ...
      }
  ```
- `kubectl rollout restart deploy -n kube-system coredns` to restart coredns pod
