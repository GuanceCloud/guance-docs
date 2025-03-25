## 1 Sealos node notready, kubelet reports node not found
Log in to the problematic node and check the kubelet logs.
```shell
journalctl -xeu kubelet
```
The logs reveal that apiserver cannot be connected; test network connectivity.
```shell
telnet apiserver.cluster.local 6443
```
Testing reveals network issues; disable the firewall on the master node to resolve the issue.
```shell
systemctl stop firewalld
```

## 2 Kylin ARM architecture Sealos deployment timeout
Check if other containerized products have been deployed.
```shell
rpm -qa | grep docker
rpm -qa | grep podman
```
Redundant software is found; uninstall the redundant software.
```shell
rpm -e <redundant_software_name>
```
Uninstall Sealos and reinstall it.
```shell
sealos reset
```

## 3 Physical machine k8s cluster deployment, calico component fails to start
When deploying a k8s cluster on a physical machine, the calico component fails to start with the following error.
![](img/faq-k8s-1.png)

```shell
kubectl -n calico-system get installations.operator.tigera.io 
kubectl -n calico-system edit installations.operator.tigera.io default

# Change to interface: eth.*|en.*|bound.* What bound.* is changed to depends on the physical machine's network card name, requiring a regular expression match
nodeAddressAutodetectionV4:
  interface: eth.*|en.*
```

## 4 Kylin ARM architecture sealos deployment reports segmentation fault
![](img/faq-k8s-2.png)
Install the new version of sealos and the k8s cluster.
```shell
# sealos
wget https://mirror.ghproxy.com/https://github.com/labring/sealos/releases/download/v4.3.7/sealos_4.3.7_linux_arm64.tar.gz \
   && tar zxvf sealos_4.3.7_linux_arm64.tar.gz sealos && chmod +x sealos && mv sealos /usr/bin
# k8s cluster   
sealos run pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/kubernetes:v1.25.16-4.3.7 pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/helm:v3.8.2 pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/calico:v3.24.1  --single  --debug
```

## 5 Selaos installation reports port conflict, 'Port: 10249 occupied'
![](img/faq-k8s-3.png)
Check if there is a port conflict; if so, close the conflicting port.
```shell
lsof -i: <port_number>
```
If the above command has no output, it may indicate an abnormality with the lsof command.
```shell
whereis lsof
# If multiple lsof commands exist and only one works normally, you can rename or move the other lsof binary commands to another path.
```

## 6 sealos cluster deployment kubelet fails to start
**OS is openEuler 22.03 version**
Problem description: During sealos deployment, errors keep occurring, preventing the cluster from starting up. It is judged to be a kubelet issue; check the kubelet logs.
![](img/faq-k8s-4.png)
By checking the /var/log/message log, it is discovered that the /etc/resolv.conf file does not exist.
![](img/faq-k8s-5.png)
Create the file and configure the correct DNS server, then reinstall sealos.