# cilium

pods ip -> `10.147.0.0/16` \
services ip -> `10.97.0.0/16`

## helm

some parameters can be added via `helm --set key=value` or `values.yaml` file
- `k8sServiceHost`, required, kubernetes API server, e.g. `kubernetes.domain.com`
- `k8sServicePort`, required, kubernetes API server port, e.g. `6443`
- `image.repository`, agent image repo, e.g. `registry.domain.com/cilium/cilium`
- `operator.image.repository`, operator image repo, e.g. `registry.domain.com/cilium/operator`
- `preflight.image.repository`, preflight image repo, e.g. `registry.domain.com/cilium/cilium`
- `useDigest`, used within `image` key to use image digest, boolean `true` or `false`
- `current-version`, current cilium version before upgrade process e.g. `1.9`
- `values-file`, helm values file in YAML format, e.g. `values.yaml`

```
# add repo
helm repo add cilium https://helm.cilium.io

# install with routing mode tunnel
helm install cilium cilium/cilium -n kube-system -f values-tunnel.yaml --version 1.20.1
# install with routing mode native
helm install cilium cilium/cilium -n kube-system -f values-native.yaml --version 1.20.1

# preflight before upgrade
helm template cilium cilium/cilium -n kube-system -f values-preflight.yaml --version 1.20.1 > preflight.yaml
# apply preflight manifest
kubectl apply -f preflight.yaml
# wait until all pods ready then delete
kubectl delete -f preflight.yaml

# upgrade
helm upgrade cilium cilium/cilium -n kube-system -f <values-file> --set upgradeCompatibility=<current-version-ex-1.19> --version 1.20.1

# template
helm template cilium cilium/cilium -n kube-system -f <values-file> --version 1.20.1 > temp.yaml
```

## bgp peering

to enable bgp peering, add this helm value:
```
bgpControlPlane:
  enabled: true
```
