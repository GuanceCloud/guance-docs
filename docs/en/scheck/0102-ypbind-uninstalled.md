# 0102-ypbind-uninstalled-NIS Client Installed

---

## Rule ID

- 0102-ypbind-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Network Information Service (NIS), formerly known as Yellow Pages, is a client-server directory service protocol used for distributing system configuration files. The NIS client (ypbind) is used to bind machines to NIS servers and receive distributed configuration files.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- The NIS service is inherently an insecure system, vulnerable to DOS attacks, buffer overflows, and has poor authentication when querying NIS maps. NIS has typically been replaced by protocols such as Lightweight Directory Access Protocol (LDAP). It is recommended to remove this service.


## Risk Items

- Hacker penetration
- Data leakage
- Network security
- Mining risk
- Botnet risk


## Audit Method

- Execute the following command to verify if ypbind is installed.

```bash
# rpm -q ypbind
package ypbind is not installed
```


## Remediation

- Run the command to remove ypbind.
```bash
# yum remove ypbind
```


## Impact

- Many insecure service clients are used as troubleshooting tools and in test environments. Uninstalling them will reduce testing and troubleshooting capabilities. If they are required for use, ensure they are removed afterward to prevent accidental or intentional misuse.


## Default Value

- Not specified


## References

- None


## CIS Control

- Version 7<br>
    Ensure unauthorized software is either removed or updated in a timely manner.