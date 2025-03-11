# 0402-kubeproxy-conf-priv-proxy kubeconfig file permissions not set to 644 or more restrictive
---

## Rule ID

- 0402-kubeproxy-conf-priv


## Category

- Container


## Level

- Warn


## Compatible Versions


- Linux




## Description


- If you are using kube-proxy on a computer that manages services with systemd, verify that the proxy kubeconfig file permissions are correctly set to 644 or more restrictive.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- The kube-proxy configuration file contains sensitive parameters that can alter the behavior of the kube-proxy daemon. Therefore, no user other than root should be able to write to it to maintain the integrity of the file.



## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify if the file permissions are set to "644" or more restrictive:

```bash
stat -c %a /var/lib/kube-proxy/config.conf
```



## Remediation
- Execute the following command:
```bash
#> chmod 644 /var/lib/kube-proxy/config.conf
```
This will set the file permissions to "644".



## Impact


- None




## Default Value


- This file may not exist on the system. In this case, this recommendation does not apply. By default, if the file exists, the file permissions will be correctly set to 644.




## References


- [kube-proxy](https://kubernetes.io/docs/admin/kube-proxy/)



## CIS Controls


- None