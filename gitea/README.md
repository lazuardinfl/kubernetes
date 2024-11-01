# gitea

## helm

```
helm repo add gitea-charts https://dl.gitea.com/charts
helm template gitea gitea-charts/gitea -n gitea -f values.yaml > temp.yaml
```

## database

postgresql \
login as super user
```
CREATE USER <user> WITH PASSWORD '<pass>';
CREATE DATABASE <db> WITH OWNER <user> TEMPLATE template0 ENCODING UTF8 LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';
GRANT ALL PRIVILEGES ON DATABASE <db> TO <user>;
\c <db>
GRANT ALL ON SCHEMA public TO <user>;
```

## config

use ldap to login
```
server:
LANDING_PAGE=explore

service:
DISABLE_REGISTRATION=true

redis:
redis://:password@redis.domain.com:6379/3?pool_size=100&idle_timeout=180s&
```
