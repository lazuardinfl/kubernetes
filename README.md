kubernetes bootstrap on bare metal
- cluster node has public ip
- cni without encryption
- csi with local storage
- external ingress mode
- some pod to pod traffic encrypted with tls

to achieve secure traffic, all nodes must behind same switch
- virtual linux bridge like in Proxmox and VMware ESXi
- real switch with same gateway on all node ip