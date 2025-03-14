# 0096-squid-uninstalled - Ensure squid HTTP Proxy Server is Not Installed
---

## Rule ID

- 0096-squid-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Squid is a standard proxy server used in many distributions and environments.



## Scan Frequency
- 0 * * * *

## Theoretical Basis


- Unless the system is specifically configured to act as a proxy server, it is recommended to remove the squid package to reduce the potential attack surface.



- Note: There are multiple HTTP proxy servers. Unless required, these should be checked and removed if not needed.



## Risk Items


- Hacker Penetration



- Data Breach



- Network Security



- Mining Risk



- Botnet Risk



## Audit Method
- Execute the following command to verify whether squid is installed.

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
    9.2 Ensure Only Approved Ports, Protocols, and Services Are Running<br>
       Ensure that only network ports, protocols, and services listening on each system are those validated by business requirements.