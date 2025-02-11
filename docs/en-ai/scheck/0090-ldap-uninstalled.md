# 0090-ldap-uninstalled-LDAP Installed

---

## Rule ID

- 0090-ldap-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Lightweight Directory Access Protocol (LDAP) was introduced as a replacement for NIS/YP. It provides a method to look up information from a central database.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- If the system does not need to act as an LDAP server, it is recommended to remove this software to reduce the potential attack surface.


## Risk Items

- Increased risk of being attacked


## Audit Method

- Run the following command to verify that the corresponding component is not installed:
```bash
# rpm -q openldap-servers
package openldap-servers is not installed
```


## Remediation

- Run the following command to remove the corresponding package:
```bash
# yum remove openldap-servers
```


## Impact

- For more detailed documentation on OpenLDAP, please visit the project homepage: http://www.openldap.org.


## Default Values

- None


## References

- None


## CIS Controls

- Version 7
>    9.2 Ensure only approved ports, protocols, and services are running  
>    Ensure that only network ports, protocols, and services with validated business needs are listening on each system.