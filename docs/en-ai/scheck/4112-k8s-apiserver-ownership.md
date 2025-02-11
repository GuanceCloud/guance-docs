# 4112-k8s-apiserver-ownership-k8s-apiserver File Ownership Not Set to root:root
---

## Rule ID

- 4112-k8s-apiserver-ownership


## Category

- Nginx


## Level

- Warn


## Compatible Versions

- Linux


## Description

- If you are using nginx on a computer that uses systemd to manage services, verify that the file ownership and group ownership of nginx are correctly set to root.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- Setting the ownership to the root user and root group will reduce the possibility of unauthorized modifications to the nginx configuration files.


## Risk Items

- Nginx Security


## Audit Method

- Execute the following command to verify that the file and group are owned by root:

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

- The default ownership and group for nginx is root.


## References

- None


## CIS Controls

- None