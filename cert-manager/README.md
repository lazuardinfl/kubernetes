# cert-manager

## ca

create root ca, use openssl config from issuer/openssl.cnf
```
openssl genrsa -des3 -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 7300 -out rootCA.crt -config openssl.cnf -extensions v3_ca
```

## helm

using helm leader election can be changed to another namespace
```
helm repo add jetstack https://charts.jetstack.io

helm template cert-manager jetstack/cert-manager -n cert-manager --version v1.14.5 \
--set global.leaderElection.namespace=cert-manager > temp.yaml
```