# 4118-k8s-etcd-ownership-k8s-etcd file ownership is not set to root:root
---

## Rule ID

- 4118-k8s-etcd-ownership


## Category

- container


## Level

- warn


## Compatible Versions

- Linux


## Description

- If k8s-etcd is used on a computer that manages services with systemd, verify that the ownership and group ownership of the k8s-etcd file are correctly set to root.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- The k8s-etcd file contains sensitive parameters that may alter the behavior of the k8s-etcd daemon. Therefore, it should be owned by root, and the group should also be owned by root to maintain the integrity of the file.


## Risk Items

- Container Security


## Audit Method

- Execute the following command to verify that the file and group belong to root:

```bash
stat -c %U:%G /etc/kubernetes/manifests/etcd.yaml
```
The above command should return no output.


## Remediation

- Execute the following command:
```bash
#> chown root:root /etc/kubernetes/manifests/etcd.yaml
```
This will set the ownership and group ownership of the file to root.


## Impact

- None


## Default Value

- This file may not exist on the system. In this case, this recommendation does not apply. By default, if the file exists, the ownership and group ownership of this file will be correctly set to root:root.


## References

- [etcd](https://coreos.com/etcd)

- [kubernetes-etcd](https://kubernetes.io/docs/admin/etcd/)


## CIS Controls

- None