# jenkins

## helm

```
helm repo add jenkins https://charts.jenkins.io
helm template jenkins jenkins/jenkins -n jenkins -f values.yaml > temp.yaml
```

## static

Additional nginx container added to serve public static contents. \
Contents is located inside public directory on jenkins home path. 