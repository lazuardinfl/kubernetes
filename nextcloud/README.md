# nextcloud

## helm

```
helm repo add nextcloud https://nextcloud.github.io/helm
helm template nextcloud nextcloud/nextcloud -n nextcloud -f values.yaml --version 6.6.10 > temp.yaml
```

## database

postgresql \
login as super user
```
CREATE USER <user> WITH PASSWORD '<pass>';
CREATE DATABASE <db> WITH OWNER <user> TEMPLATE template0 ENCODING 'UTF8';
GRANT ALL PRIVILEGES ON DATABASE <db> TO <user>;
\c <db>
GRANT ALL ON SCHEMA public TO <user>;
```

## in-cluster traffic

To connect from another pod inside kubernetes cluster internally via domain without causing traffic to
hairpin (travel out of cluster then back in via ingress), you can add some coredns configuration below.
- `kubectl edit cm -n kube-system coredns` to edit coredns config
- add `rewrite` plugin with your domain
  ```
  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: coredns
    namespace: kube-system
  data:
    Corefile: |
      .:53 {
          ...
          ready
          rewrite name nextcloud.domain.com nextcloud.nextcloud.svc.cluster.local
          ...
      }
  ```
- `kubectl rollout restart deploy -n kube-system coredns` to restart coredns pod
