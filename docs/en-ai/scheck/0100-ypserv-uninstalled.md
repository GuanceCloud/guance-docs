# 0100-ypserv-uninstalled-NIS Service Installed
---

## Rule ID

- 0100-ypserv-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- The NIS service is inherently an insecure system, susceptible to DOS attacks, buffer overflows, and poor authentication when querying NIS maps. NIS has typically been replaced by protocols such as Lightweight Directory Access Protocol (LDAP). It is recommended to remove the ypserv package if a more secure service is needed.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- The ypserv package provides the NIS (Network Information Service) service. This service, formally known as Yellow Pages, is a client-server directory service protocol for distributing system configuration profiles. NIS servers are a collection of programs that allow the distribution of configuration files.


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
    Ensure that only network ports, protocols, and services with validated business needs are listening on each system.