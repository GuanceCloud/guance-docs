# 0099-rsync-uninstalled-rsync Installed or rsyncd Service Not Masked
---

## Rule ID

- 0099-rsync-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Unless necessary, the rsync package should be removed to reduce the attack surface of this system. The rsyncd service poses a security risk because it uses an unencrypted protocol for communication. 
  Note: If the rsync package is a required dependency, but the rsyncd service is not essential, the service should be masked.


## Scan Frequency
- 0 */30 * * *


## Theoretical Basis

- The rsyncd service can be used to synchronize files between systems over a network link.


## Risk Items

- Hacker penetration

- Data leakage

- Network security

- Mining risk

- Botnet risk


## Audit Method
- Run the following command to verify if rsync is installed.

```bash
# rpm -q rsync
package rsync is not installed
```


## Remediation
- Run the command to remove rsync.
```bash
# yum remove rsync
```


## Impact

- None


## Default Values

- None


## References

- None


## CIS Controls

- Version 7<br>
    9.2 Ensure only approved ports, protocols, and services are running<br>
    Ensure that only validated business requirements for network ports, protocols, and services are being listened on and running on each system.