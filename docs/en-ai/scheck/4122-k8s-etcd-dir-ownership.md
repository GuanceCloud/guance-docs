# 4122-k8s-etcd-dir-ownership-k8s-etcd file ownership is not set to etcd:etcd
---

## Rule ID

- 4122-k8s-etcd-dir-ownership


## Category

- container


## Level

- warn


## Compatible Versions


- Linux




## Description


- If k8s-etcd is used on a computer that manages services with systemd, verify that the file ownership and group ownership of k8s-etcd are correctly set to etcd.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- The k8s-etcd file contains sensitive parameters that may alter the behavior of the k8s-etcd daemon. Therefore, it should be owned by root, and the group should also be owned by root to maintain the integrity of the file.



## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify that the file and group belong to root:

```bash
stat -c %U:%G /var/lib/etcd
```
The above command should return no output.



## Remediation
- Execute the following command:
```bash
#> chown etcd:etcd /var/lib/etcd
```
This will set the file ownership and group ownership to root.



## Impact


- None




## Default Value


- This file may not exist on the system. In this case, this recommendation does not apply. By default, if the file exists, the file ownership and group ownership will be correctly set to root:root.




## References


- [etcd](https://coreos.com/etcd)



- [kubernetes-etcd](https://kubernetes.io/docs/admin/etcd/)



## CIS Controls


- None