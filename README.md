kubernetes bootstrap on bare metal
- all cluster node has ip not behind nat
- cni without encryption
- csi with local storage
- external ingress mode
- some pod to pod traffic encrypted with tls

to achieve secure traffic, all nodes should behind same switch
- virtual linux bridge like in Proxmox and VMware ESXi
- real switch with same gateway on all node ip

if well known CA is not used, but instead private CA is used, then it must be injected into container trust store
