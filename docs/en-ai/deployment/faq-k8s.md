## 1 Sealos Node Not Ready, Kubelet Reports Node Not Found
Log in to the problematic node and check the kubelet logs.
```shell
journalctl -xeu kubelet
```
The logs show that apiserver cannot be connected. Test network connectivity.
```shell
telnet apiserver.cluster.local 6443
```
The test shows that the network is unreachable. Stop the firewall on the master node to resolve the issue.
```shell
systemctl stop firewalld
```

## 2 Kylin ARM Architecture Sealos Deployment Timeout
Check if other containerized products are deployed.
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

## 3 Physical Machine k8s Cluster Deployment, Calico Component Fails to Start
When deploying a k8s cluster on a physical machine, the Calico component fails to start with the following error.
![](img/faq-k8s-1.png)

```shell
kubectl -n calico-system get installations.operator.tigera.io 
kubectl -n calico-system edit installations.operator.tigera.io default

# Change to interface: eth.*|en.*|bound.* Modify bound.* based on the physical machine's network interface name, ensuring the regular expression matches it.
nodeAddressAutodetectionV4:
  interface: eth.*|en.*
```

## 4 Kylin ARM Architecture Sealos Deployment Reports Segmentation Fault
![](img/faq-k8s-2.png)
Install the new version of Sealos and the k8s cluster.
```shell
# Sealos
wget https://mirror.ghproxy.com/https://github.com/labring/sealos/releases/download/v4.3.7/sealos_4.3.7_linux_arm64.tar.gz \
   && tar zxvf sealos_4.3.7_linux_arm64.tar.gz sealos && chmod +x sealos && mv sealos /usr/bin
# k8s cluster   
sealos run pubrepo.guance.com/googleimages/kubernetes:v1.25.16-4.3.7 pubrepo.guance.com/googleimages/helm:v3.8.2 pubrepo.guance.com/googleimages/calico:v3.24.1  --single  --debug
```

## 5 Sealos Installation Reports Port Conflict, 'Port: 10249 Occupied'
![](img/faq-k8s-3.png)
Check if the port is in conflict; if so, close the port.
```shell
lsof -i: <port_number>
```
If the above command has no output, there may be an issue with the lsof command.
```shell
whereis lsof
# If multiple lsof commands exist and only one works properly, rename or move the other lsof binaries to another path.
```

## 6 Sealos Cluster Deployment, Kubelet Fails to Start
**OS is openEuler 22.03 version**
Problem description: During Sealos deployment, errors persist, preventing the cluster from starting up. It appears to be a kubelet issue. Check the kubelet logs.
![](img/faq-k8s-4.png)
By checking the `/var/log/message` log, it is found that the `/etc/resolv.conf` file does not exist.
![](img/faq-k8s-5.png)
Create the file and configure the correct DNS server, then reinstall Sealos.