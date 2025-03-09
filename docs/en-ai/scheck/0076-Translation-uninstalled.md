# 0076-Translation-uninstalled-mcstrans Service Installed
---

## Rule ID

- 0076-Translation-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- The mcstransd daemon provides category label information to client processes that request it. Label translation is defined in /etc/selinux/targeted/setrans.conf.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Since this service is not frequently used, uninstall it to reduce the amount of potentially vulnerable code running on the system.


## Risk Items

- Hacker penetration

- Data leakage

- Mining risk

- Compromised machine risk


## Audit Method

- Verify that mcstrans is not installed. Run the following command:

```bash
# rpm -q mcstrans
package mcstrans is not installed
```


## Remediation

- Run the following command to uninstall mcstrans:

```bash
# yum remove mcstrans
```


## Impact

- None


## Default Value

- None


## References

## CIS Control

- Version 7
9.2 Ensure Only Approved Ports, Protocols, and Services Are Running
Ensure that only network ports, protocols, and services with validated business needs are listening on each system.