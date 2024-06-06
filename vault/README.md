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
helm template vault hashicorp/vault -n vault -f values.yaml > temp.yaml
```