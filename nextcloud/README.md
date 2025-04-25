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
