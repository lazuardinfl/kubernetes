# cilium

pod ip -> `10.147.0.0/16` \
services ip -> `10.97.0.0/16`

## helm

```
helm repo add cilium https://helm.cilium.io

export API_SERVER_IP=<kubernetes-api-server-ip>
export API_SERVER_PORT=<kubernetes-api-server-port>

helm template cilium cilium/cilium -n kube-system -f values.yaml --version 1.16.7 \
--set k8sServiceHost=${API_SERVER_IP} --set k8sServicePort=${API_SERVER_PORT} > temp.yaml
```

## bgp peering

to enable bgp peering, add this helm value:
```
bgpControlPlane:
  enabled: true
```

then apply this config:
```
apiVersion: cilium.io/v2alpha1
kind: CiliumBGPPeeringPolicy
metadata:
  name: bgp-peering-policy
  namespace: kube-system
spec:
  nodeSelector:
    matchLabels:
      kubernetes.io/os: linux
  virtualRouters: # []CiliumBGPVirtualRouter
  - localASN: 65000
    exportPodCIDR: true
    neighbors: # []CiliumBGPNeighbor
    - peerAddress: 192.168.0.2/32
      peerASN: 65000
      eBGPMultihopTTL: 10
      connectRetryTimeSeconds: 120
      holdTimeSeconds: 90
      keepAliveTimeSeconds: 30
      gracefulRestart:
        enabled: true
        restartTimeSeconds: 120
```
