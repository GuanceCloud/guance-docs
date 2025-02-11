# 0096-squid-uninstalled - Ensure squid HTTP Proxy Server is Not Installed
---

## Rule ID

- 0096-squid-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Squid is a standard proxy server used in many distributions and environments.


## Scan Frequency

- 0 * * * *


## Rationale

- Unless the system is specifically configured to act as a proxy server, it is recommended to remove the squid package to reduce the potential attack surface.

- Note: There are multiple HTTP proxy servers. Unless needed, these should be checked and removed.


## Risk Items

- Hacker Penetration
- Data Leakage
- Network Security
- Mining Risk
- Botnet Risk


## Audit Method

- Run the following command to verify if squid is installed.

```bash
# rpm -q squid
package squid is not installed
```


## Remediation

- Run the command to remove squid.
```bash
# yum remove squid
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
       Ensure that only network ports, protocols, and services that listen on the system are validated for business needs and are running on each system.