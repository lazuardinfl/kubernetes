# keycloak

official keycloak deployment uses operator but you can bypass that:
- deploy using operator
- make your own template based on resources created by operator
- delete operator resource

## database

postgresql \
login as super user
```
CREATE USER <user> WITH PASSWORD '<pass>';
CREATE DATABASE <db> WITH OWNER <user> ENCODING 'UTF8';
GRANT ALL PRIVILEGES ON DATABASE <db> TO <user>;
\c <db>
GRANT ALL ON SCHEMA public TO <user>;
```
