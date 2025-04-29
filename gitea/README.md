# gitea

## helm

```
helm repo add gitea-charts https://dl.gitea.com/charts
helm template gitea gitea-charts/gitea -n gitea -f values.yaml --version 11.0.1 > temp.yaml
```

## database

#### postgresql
login as super user
```
CREATE USER <user> WITH PASSWORD '<pass>';
CREATE DATABASE <db> WITH OWNER <user> TEMPLATE template0 ENCODING UTF8 LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';
GRANT ALL PRIVILEGES ON DATABASE <db> TO <user>;
\c <db>
GRANT ALL ON SCHEMA public TO <user>;
```

#### redis
```
redis://:password@redis.domain.com:6379/3?pool_size=100&idle_timeout=180s&
```

## ldap

group:
```
{
    "cn=admin,ou=gitea,ou=groups,dc=domain,dc=com": {
        "org": ["Admin"]
    },
    "cn=user,ou=gitea,ou=groups,dc=domain,dc=com": {
        "org": ["team1", "team2"]
    }
}
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
          rewrite name gitea.domain.com gitea.gitea.svc.cluster.local
          ...
      }
  ```
- `kubectl rollout restart deploy -n kube-system coredns` to restart coredns pod
