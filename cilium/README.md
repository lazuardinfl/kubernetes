# cilium

pod ip -> `10.147.0.0/16` \
services ip -> `10.97.0.0/16`

## helm

```
helm repo add cilium https://helm.cilium.io

export API_SERVER_IP=<kubernetes-api-server-ip>
export API_SERVER_PORT=<kubernetes-api-server-port>

helm template cilium cilium/cilium -n kube-system -f values.yaml --version 1.15.5 \
--set k8sServiceHost=${API_SERVER_IP} --set k8sServicePort=${API_SERVER_PORT} > temp.yaml
```

## bgp peering
to enable bgp peering, add this helm value:
```
bgpControlPlane:
  enabled: true
```
then add `cilium-bgp-peering.yaml` file to kustomize resources