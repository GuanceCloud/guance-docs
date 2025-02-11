# 0100-ypserv-uninstalled-NIS Service Installed
---

## Rule ID

- 0100-ypserv-uninstalled


## Category

- System


## Level

- Warning


## Compatible Versions

- Linux


## Description

- The NIS service is inherently an insecure system, susceptible to DOS attacks, buffer overflows, and poor authentication when querying NIS maps. NIS has generally been replaced by protocols such as Lightweight Directory Access Protocol (LDAP). It is recommended to remove the ypserv package if a more secure service is required.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- The ypserv package provides NIS (Network Information Service) service. This service, formally known as Yellow Pages, is a client-server directory service protocol used for distributing system configuration profiles. NIS servers are a collection of programs that allow the distribution of configuration files.


## Risk Items

- Hacker Penetration

- Data Leakage

- Network Security

- Mining Risk

- Botnet Risk


## Audit Method

- Execute the following command to verify if ypserv is installed.

```bash
# rpm -q ypserv
package ypserv is not installed
```


## Remediation

- Run the command to remove ypserv.
```bash
# yum remove ypserv
```


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- Version 7<br>
    9.2 Ensure only approved ports, protocols, and services are running<br>
    Ensure that only network ports, protocols, and services listening on each system meet validated business needs and are running on the system.