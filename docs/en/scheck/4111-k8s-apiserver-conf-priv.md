# 4111-k8s-apiserver-conf-priv-apiserver Configuration File Permissions Not Set to 644 or Higher
---

## Rule ID

- 4111-k8s-apiserver-conf-priv


## Category

- Container


## Level

- Warn


## Compatible Versions

- Linux


## Description

- If you are using Kubernetes's apiserver on a computer managed by systemd, verify that the permissions for the kubernetes.service file are correctly set to 644 or more restrictive.


## Scan Frequency
- 0 */30 * * *

## Theoretical Basis

- The kubernetes.apiserver file contains sensitive parameters that can alter the behavior of the Kubernetes daemon. Therefore, no user other than root should have write access to maintain the integrity of the file.


## Risk Items

- Container Security


## Audit Method
- Execute the following command to verify if the file permissions are set to "644" or more restrictive:

```bash
stat -c %a /etc/kubernetes/manifests/kube-apiserver.yaml
```


## Remediation
- Execute the following command to modify the permissions of the configuration file:
```bash
#> chmod 644 /etc/kubernetes/manifests/kube-apiserver.yaml
```
This will set the file permissions to "644".


## Impact

- None


## Default Value

- By default, the kube-apiserver.yaml permissions are set to 640


## References

- [kubernetes-apiserver](https://kubernetes.io/docs/admin/kube-apiserver/)


## CIS Controls

- None