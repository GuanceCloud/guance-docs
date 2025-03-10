# 0103-rsh-uninstalled-rsh Installed

---

## Rule ID

- 0103-rsh-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- The rsh package contains client commands for the rsh service.


## Scan Frequency

- 0 */30 * * *


## Rationale

- These legacy clients contain many security exposures and have been replaced by the more secure SSH package. Even if the service has been removed, it is best to ensure that the clients are also removed to prevent users from inadvertently attempting to use these commands, thereby exposing their credentials. Note that removing the rsh package will remove the clients for rsh, rcp, and rlogin.


## Risk Items

- Data Leakage


## Audit Method

- Execute the following command to check if the rsh package is installed:

```bash
# rpm -q rsh
package rsh is not installed
```


## Remediation

- Execute the following command to remove the rsh package:

```bash
# yum remove rsh
```


## Impact

- Many insecure service clients are used as troubleshooting tools and in test environments. Uninstalling them will suppress testing and troubleshooting capabilities. If necessary, it is recommended to remove the clients after use to prevent accidental or intentional misuse.


## Default Value



## References



## CIS Controls

- Version 7

> **2.6 Handling Unauthorized Software**
>
> Ensure unauthorized software is removed or inventory is updated timely