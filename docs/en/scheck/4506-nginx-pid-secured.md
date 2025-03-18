# 4506-nginx-pid-secured - Ensure NGINX Process ID (PID) File Is Secured
---

## Rule ID

- 4506-nginx-pid-secured


## Category

- nginx


## Level

- warn


## Compatible Versions


- Linux




## Description


- The nginx PID file stores the master process ID of the nginx process. This file should not be subject to unauthorized modifications.



## Scan Frequency
- 0 */30 * * *

## Theory


- The PID file should be owned by root and group root. It should also be readable by everyone but writable only by root (permissions 644). This will prevent unauthorized modifications to the PID file, which could lead to a denial of service.



## Risk Items


- nginx security



## Audit Method
- Execute the following command to verify:

```bash
ls -l /var/run/nginx.pid
# The result should be
-rw-r--r--. 1 root root 6 Nov 12 01:06 /var/run/nginx.pid
```



## Remediation
- Execute the following commands:
```bash
#> chown root:root /var/run/nginx.pid
#> chmod 644 /var/run/nginx.pid
```



## Impact


- None




## Default Value


- By default, the PID is owned by the root user




## References


- [nginx-user](http://nginx.org/en/docs/ngx_core_module.html#user)



## CIS Controls


- None