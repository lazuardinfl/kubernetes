# nextcloud

## helm

```
helm repo add nextcloud-aio https://nextcloud.github.io/all-in-one
helm template nextcloud nextcloud-aio/nextcloud-aio-helm-chart -f values1.yaml > temp1.yaml
```

## database

postgresql \
login as super user
```
CREATE USER oc_nextcloud WITH PASSWORD '<pass>';
CREATE DATABASE <db> WITH OWNER oc_nextcloud TEMPLATE template0 ENCODING 'UTF8';
GRANT ALL PRIVILEGES ON DATABASE <db> TO oc_nextcloud;
\c <db>
GRANT ALL ON SCHEMA public TO oc_nextcloud;
```