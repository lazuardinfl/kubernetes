# nfs

## helm

```
# add repo
helm repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts

# install release
helm install csi-driver-nfs csi-driver-nfs/csi-driver-nfs -f values.yaml -n kube-system --version 4.11.0

# upgrade release
helm upgrade csi-driver-nfs csi-driver-nfs/csi-driver-nfs -f values.yaml -n kube-system --version 4.11.0

# template
helm template csi-driver-nfs csi-driver-nfs/csi-driver-nfs -f values.yaml -n kube-system --version 4.11.0 > temp.yaml
```

## node assignment

To apply nfs only on selected node, add label to node and use `nodeSelector` to deploy node based on that label.

## storage class

Example nfs storage class `nfs-storage.yaml` can be applied using kubectl, assuming cluster has local nfs server ready.
Additional storage class can be applied with custom configuration, e.g. external nfs server, share path, etc.
