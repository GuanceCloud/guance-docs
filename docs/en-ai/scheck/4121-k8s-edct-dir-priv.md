# 4121-k8s-edct-dir-priv-etcd Data Directory Permissions Not Set to 700 or Higher
---

## Rule ID

- 4121-k8s-edct-dir-priv


## Category

- Container


## Level

- Info


## Compatible Versions

- Linux


## Description

- Ensure that the etcd data directory has restrictive permissions of 700 or higher.

## Scan Frequency
- 0 */30 * * *

## Theoretical Basis

- Etcd is a highly available key-value store used by Kubernetes deployments for persistent storage of all REST API objects. This data directory should be protected from any unauthorized read/write access.

## Risk Items

- Container Security

## Audit Method

- Execute the following command to verify if the file permissions are set to "644" or more restrictive:

```bash
stat -c %a /var/lib/etcd
```

## Remediation

- Execute the following command to modify the permissions of the configuration files:
```bash
#> chmod 700 /var/lib/etcd
```
This will set the directory permissions to "700".

## Impact

- None

## Default Value

- By default, the permissions of `/var/lib/etcd` are set to 755.

## References

- [kubernetes-etcd](https://kubernetes.io/docs/admin/etcd/)
- [etcd](https://coreos.com/etcd/docs/latest/op-guide/configuration.html#data-dir)

## CIS Controls

- None