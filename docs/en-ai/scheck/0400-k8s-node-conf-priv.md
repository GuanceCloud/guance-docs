# 0400-k8s-node-conf-priv-kubernetes Configuration File Permissions Not Set to 644 or Higher
---

## Rule ID

- 0400-k8s-node-conf-priv


## Category

- Container


## Level

- Warn


## Compatible Versions

- Linux


## Description

- If you are using a Kubernetes node on a computer managed by systemd, please verify that the permissions of the kubernetes.service file are correctly set to 644 or more restrictive.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- The kubernetes.service file contains sensitive parameters that may alter the behavior of the Kubernetes daemon. Therefore, no user other than root should be able to write to it to maintain the integrity of the file.


## Risk Items

- Container Security


## Audit Method

- Execute the following commands to verify if the file permissions are set to "644" or more restrictive:

```bash
stat -c %a /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
stat -c %a /etc/kubernetes/kubelet.conf
stat -c %a /var/lib/kubelet/config.yaml
```


## Remediation

- Execute the following command to modify the permissions of the three configuration files:
```bash
#> chmod 644 /etc/systemd/system/kubelet.service.d/10-kubeadm.conf /etc/kubernetes/kubelet.conf /var/lib/kubelet/config.yaml
```
This will set the file permissions to "644".


## Impact

- None


## Default Values

- This file may not exist on the system. In this case, this recommendation does not apply. By default, if the file exists, the file permissions will be correctly set to 644.


## References

- [kubernetes-kubelet](https://kubernetes.io/docs/admin/kubelet/)


## CIS Controls

- None