# 0101-telnetserver-uninstalled-telnet Server Installed
---

## Rule ID

- 0101-telnetserver-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- The telnet-server package includes the telnet daemon, which accepts connections from users of other systems via the telnet protocol. This software uses an insecure transmission protocol, posing a security risk.


## Scan Frequency

- * * */1 * *


## Theoretical Basis

- The telnet protocol is insecure and unencrypted. Using unencrypted transmission media can allow users with access to sniff network traffic to steal credentials. The ssh package provides encrypted sessions and stronger security.


## Risk Items

- Hacker penetration

- Data leakage

- Network security

- Mining risk

- Botnet risk


## Audit Method

- Execute the following command to verify whether telnet-server is installed.

```bash
# rpm -q telnet-server
package telnet-server is not installed
```


## Remediation

- Run the command to remove telnet-server.
```bash
# yum remove telnet-server
```


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- Version 7

- 2.6 Address Unauthorized Software  
Ensure unauthorized software is removed or directories are updated in a timely manner.

- 9.2 Ensure Only Approved Ports, Protocols, and Services Are Running  
Ensure only network ports, protocols, and services that meet validated business needs are listening on each system.