# 4117-k8s-edct-conf-priv-etcd Configuration File Permissions Not Set to 644 or Higher
---

## Rule ID

- 4117-k8s-edct-conf-priv


## Category

- Container


## Level

- Info


## Compatible Versions


- Linux




## Description


- If you are using etcd with Kubernetes on a computer managed by systemd, verify that the permissions for the kubernetes.service file are correctly set to 644 or more restrictive.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- The kubernetes.etcd file contains sensitive parameters that can alter the behavior of the Kubernetes daemon. Therefore, no user other than root should have write access to it to maintain the integrity of the file.



## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify that the file permissions are set to "644" or more restrictive:

```bash
stat -c %a /etc/kubernetes/manifests/etcd.yaml
```



## Remediation
- Run the following command to modify the permissions of the configuration file:
```bash
#> chmod 644 /etc/kubernetes/manifests/etcd.yaml
```
This sets the file permissions to "644".



## Impact


- None




## Default Value


- By default, the permission of etcd.yaml is 640




## References


- [etcd](https://coreos.com/etcd)



- [Kubernetes-etcd](https://kubernetes.io/docs/admin/etcd/)



## CIS Controls


- None