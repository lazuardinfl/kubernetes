# cert-manager

create root ca

```
openssl genrsa -des3 -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 7300 -out rootCA.crt -config openssl.cnf -extensions v3_ca
```