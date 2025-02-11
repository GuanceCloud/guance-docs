# 0102-ypbind-uninstalled-NIS Client Uninstalled

---

## Rule ID

- 0102-ypbind-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Network Information Service (NIS), formerly known as Yellow Pages, is a client-server directory service protocol used for distributing system configuration files. The NIS client (ypbind) is used to bind machines to NIS servers and receive distributed configuration files.


## Scan Frequency
- 0 */30 * * *

## Theoretical Basis

- The NIS service is inherently an insecure system, vulnerable to DOS attacks, buffer overflows, and poor authentication when querying NIS maps. NIS has generally been replaced by protocols such as Lightweight Directory Access Protocol (LDAP). It is recommended to remove this service.


## Risk Items

- Hacker Penetration

- Data Leakage

- Network Security

- Mining Risk

- Botnet Risk


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

- Many insecure service clients are used as troubleshooting tools and in test environments. Uninstalling them can inhibit testing and troubleshooting capabilities. If they are required for use, ensure they are removed afterward to prevent accidental or intentional misuse.


## Default Values

- None


## References

- None


## CIS Controls

- Version 7<br>
    Ensure unauthorized software is either removed or kept up-to-date.