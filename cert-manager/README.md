# cert-manager

## private ca

create root ca, use openssl config from issuer/openssl.cnf
```
openssl genrsa -des3 -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 7300 -out rootCA.crt -config openssl.cnf -extensions v3_ca
```

## helm

using helm leader election can be changed to another namespace
```
helm repo add jetstack https://charts.jetstack.io

helm template cert-manager jetstack/cert-manager -n cert-manager --version v1.16.2 \
--set global.leaderElection.namespace=cert-manager > temp.yaml
```

## let's encrypt behind proxy

if behind corporate proxy, you can add this config
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cert-manager
spec:
  template:
    spec:
      containers:
        - name: cert-manager-controller
          args:
          - --dns01-recursive-nameservers-only
          - --dns01-recursive-nameservers=<ip1>:53,<ip2>:53 # your corporate dns server
          env:
          - name: HTTP_PROXY
            value: "http://<ip-or-domain>:<port>"
          - name: HTTPS_PROXY
            value: "http://<ip-or-domain>:<port>"
          - name: NO_PROXY
            value: "localhost,domain.com,10.97.0.0/16,10.147.0.0/16" # domain.com will match apex and all subdomains
          # volume for private ca
          volumeMounts:
            - name: private-ca
              mountPath: /etc/ssl/certs/org.pem
              subPath: org.crt
      volumes:
        - name: private-ca
          secret:
            secretName: private-ca
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cert-manager-webhook
spec:
  template:
    spec:
      containers:
        - name: cert-manager-webhook
          # volume for private ca
          volumeMounts:
            - name: private-ca
              mountPath: /etc/ssl/certs/org.pem
              subPath: org.crt
      volumes:
        - name: private-ca
          secret:
            secretName: private-ca
```

## acme dns challenge

some dns server have problem with txt records if not enclosed in quotes, \
to bypass this then create temporary txt record with name *.domain.com and content "temporary"
