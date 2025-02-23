
# 10.147.0.0/16 -> pod
# 10.97.0.0/16 -> services

# disable swap from /etc/fstab and sudo swapoff -a

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF

# apply sysctl params without reboot
sudo sysctl --system

# verify that net.ipv4.ip_forward is set to 1
sysctl net.ipv4.ip_forward

# remove old docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# add docker official gpg key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# add docker repository to apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# install containerd
sudo apt-get install containerd.io

containerd config default | sudo tee /etc/containerd/config.toml
# change config /etc/containerd/config.toml
# SystemdCgroup = true
# sandbox_image = <same as kubeadm config images list>
sudo systemctl restart containerd

# install kubernetes on all node
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update

# on control plane
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
sudo kubeadm init \
--control-plane-endpoint <ip-or-dommain> \
--pod-network-cidr 10.147.0.0/16 \
--service-cidr 10.97.0.0/16 \
--image-repository <registry-domain>/<path> \
--skip-phases=addon/kube-proxy # if using Cilium CNI

# on worker
sudo apt-get install -y kubelet kubeadm
sudo apt-mark hold kubelet kubeadm
sudo systemctl enable --now kubelet
sudo kubeadm join <control-plane-host>:<control-plane-port> \
--token <token> \
--discovery-token-ca-cert-hash sha256:<hash>

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl taint nodes --all node-role.kubernetes.io/master-

# install CNI
# install CSI
