# openebs

## helm

```
helm repo add openebs https://openebs.github.io/openebs
helm template openebs openebs/openebs -n openebs -f values.yaml > temp.yaml
```

## localpv

change local folder permissions on each node
```
sudo groupadd openebs
sudo usermod -aG openebs $USER
exit
sudo chown :openebs /var/openebs/local
sudo chmod 770 /var/openebs/local
```

## restore

restore old pvc, keep permissions and ownership
- create pvc and temporary pod with volumes key refer to pvc created before
- delete temporary pod, but don't delete pvc resource
- delete new pvc local folder, `sudo rm -rf /var/openebs/local/<new>`
- copy old pvc folder to new pvc folder, `sudo cp -rp /var/openebs/local/<old> /var/openebs/local/<new>`