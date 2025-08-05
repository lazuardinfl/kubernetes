# Kubernetes Bootstrap

kubernetes bootstrap on bare metal
- all cluster node has ip not behind nat
- native routing of kernel
- cni without encryption
- csi with local storage
- external ingress mode
- some pod to pod traffic encrypted with tls

if well known CA is not used, but instead private CA is used, then it must be injected into container trust store
