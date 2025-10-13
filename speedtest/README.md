# speedtest

## multiple backend

To add more servers for multiple test points, some resources need to be patched.
- ConfigMap, speedtest-config
  ```
  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: speedtest-config
  data:  
    servers: |
      [
        {
          "name": "Server 1",
          "server": "https://server-1.speedtest.domain.com/",
          "dlURL": "garbage.php",
          "ulURL": "empty.php",
          "pingURL": "empty.php",
          "getIpURL": "getIP.php"
        },
        // add more servers
      ]
  ```
- Deployment, speedtest-backend
  ```
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: speedtest-backend
  spec:
    replicas: 2 # total servers
    template:
      spec:
        affinity:
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
                - matchExpressions:
                    - key: kubernetes.io/hostname
                      operator: In
                      values:
                        - node-1
                        - node-2
                        - add more servers
  ```
- Ingress, speedtest-ingress
  ```
  apiVersion: networking.k8s.io/v1
  kind: Ingress
  metadata:
    name: speedtest-ingress
  spec:
    rules:
      - host: speedtest.domain.com
      - host: server-1.speedtest.domain.com
      - host: server-2.speedtest.domain.com
      - host: add more servers
  ```
- NetworkPolicy, speedtest-policy, prevents backend access from incoming traffic outside resident node, like ingress or load balancer.
  Ingress controller must reside on same node as backend pod to access it, so backend deployment node affinity should be configured.
  Delete this policy to remove traffic restriction or modify it accordingly using patches.
