# prometheus

## helm

```
# add repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# install crd
helm install prometheus-crd prometheus-community/prometheus-operator-crds -n prometheus --create-namespace --version 18.0.1
# upgrade crd
helm upgrade prometheus-crd prometheus-community/prometheus-operator-crds -n prometheus --version 18.0.1

# install release
helm install prometheus prometheus-community/kube-prometheus-stack -f values.yaml -n prometheus --create-namespace --version 69.7.4
# upgrade release
helm upgrade prometheus prometheus-community/kube-prometheus-stack -f values.yaml -n prometheus --version 69.7.4
```

## external node

to scrape external target outside kubernetes cluster, use ScrapeConfig crd
```
apiVersion: monitoring.coreos.com/v1alpha1
kind: ScrapeConfig
metadata:
  name: external-node
  namespace: prometheus
  labels:
    release: prometheus
spec:
  jobName: node
  staticConfigs:
    - labels:
        release: prometheus
      targets:
        - <ip or host>:<port>
        - 192.168.100.3:9100
```
