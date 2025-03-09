# LDAP Client Uninstalled

---

## Rule ID

- 0106-openldapclients-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Lightweight Directory Access Protocol (LDAP) was introduced as a replacement for NIS/YP. It is a service that provides a method to look up information from a central database.


## Scan Frequency

- 00 */30 * * *


## Theoretical Basis

- If the system does not need to act as an LDAP client, it is recommended to remove this software to reduce the potential attack surface.


## Risk Items

- Hacker penetration

- Data leakage

- Network security

- Mining risk

- Botnet risk


## Audit Method

- Run the following command to verify that the openldap clients package is not installed:

```bash
# rpm -q openldap-clients
package openldap-clients is not installed
```


## Remediation

- Run the following command to remove the openldap clients package:

```bash
# yum remove openldap-clients
```


## Impact

- Many insecure service clients are used as troubleshooting tools and test environments. Uninstalling them will inhibit testing and troubleshooting capabilities. If necessary, it is recommended to remove the client after use to prevent accidental or intentional misuse.


## Default Values



## References

- [OpenLDAP documentation](http://www.openldap.org.)


## CIS Controls

- Version 7
   9.2 Ensure only approved ports, protocols, and services are running
Ensure that only network ports, protocols, and services that have validated business needs are running on each system.