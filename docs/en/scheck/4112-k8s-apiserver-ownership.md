# 4112-k8s-apiserver-ownership-k8s-apiserver File Ownership Not Set to root:root
---

## Rule ID

- 4112-k8s-apiserver-ownership


## Category

- Kubernetes API Server


## Level

- warn


## Compatible Versions

- Linux


## Description

- If you are using nginx on a computer that manages services with systemd, verify that the file ownership and group ownership of nginx are correctly set to root.



## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- Setting ownership to the root user and root group reduces the possibility of unauthorized modifications to the nginx configuration files.



## Risk Items

- nginx security



## Audit Method

- Execute the following command to verify that the file and group belong to root:

```bash
stat /etc/nginx
```


## Remediation

- Execute the following command:
```bash
#> chown -R root:root /etc/nginx
```
This will set the file ownership and group ownership to root.



## Impact

- None



## Default Values

- The default ownership and group for nginx is root



## References

- None



## CIS Controls

- None