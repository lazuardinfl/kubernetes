# openldap

## command

`LDAPTLS_REQCERT=never` to ignore server tls \
param `-w <password>` or `-W` will ask for password at terminal
```
ldapsearch -H ldap://domain.com -D <user dn> -x -W -LLL -b <user dn>
ldapsearch -H ldaps://domain.com -D <user dn> -x -w <password> -LLL -b <user dn>
ldapsearch -H ldap://domain.com -D <config dn> -x -W -b cn=config '(olcDatabase={-1}frontend)' olcAccess
ldappasswd -H ldap://domain.com -D <user dn> -x -W -S <user dn>
ldapadd -H ldap://domain.com -D <config dn> -x -w <password> -f file.ldif
ldapdelete -H ldap://domain.com -D <config dn> -x -w <password> <dn>
ldapmodify -H ldaps://domain.com -D <config dn> -x -w <password> -f file.ldif
LDAPTLS_REQCERT=never ldapmodify -H ldaps://openldap.com -D <config dn> -x -w <password> -f file.ldif
```

## acl

There are two special pseudo attributes, entry and children:
- To read (and hence return) a target entry, the subject must have read access to the target's entry attribute.
- To perform a search, the subject must have search access to the search base's entry attribute.
- To add or delete an entry, the subject must have write access to the entry's entry attribute AND must have write access to the entry's parent's children attribute.
- To rename an entry, the subject must have write access to entry's entry attribute AND have write access to both the old parent's and new parent's children attributes.

Rules:
- user must have manager
- group must have owner, manager, or secretary

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
          rewrite name openldap.domain.com openldap.openldap.svc.cluster.local
          ...
      }
  ```
- `kubectl rollout restart deploy -n kube-system coredns` to restart coredns pod
