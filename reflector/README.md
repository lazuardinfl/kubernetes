# reflector

## private-ca

private-ca is used to store custom CA for another namespaces
```
apiVersion: v1
kind: Secret
metadata:
  name: private-ca
  namespace: original
  annotations:
    reflector.v1.k8s.emberstack.com/reflection-allowed: "true"
    reflector.v1.k8s.emberstack.com/reflection-auto-enabled: "true"
    reflector.v1.k8s.emberstack.com/reflection-auto-namespaces: "gitea,keycloak,nextcloud,openldap,vault,test"
data:
  ca.crt: (cat ca.crt | base64 -w0)
  ca.p12: (cat ca.p12 | base64 -w0)
  pkcs12-password: (echo -n 'password' | base64 -w0)
  another.crt: (cat another.crt | base64 -w0)
```
