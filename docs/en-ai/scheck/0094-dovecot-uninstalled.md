# 0094-dovecot-uninstalled-IMAP and POP3 services are installed
---

## Rule ID

- 0094-dovecot-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Unless this system provides POP3 and/or IMAP servers, it is recommended to remove this package to reduce the potential attack surface.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- Unless this system provides POP3 and/or IMAP servers, it is recommended to remove this package to reduce the potential attack surface.


## Risk Items

- Hacker penetration

- Data leakage

- Network security

- Mining risk

- Botnet risk


## Audit Method

- Run the following command to verify if dovecot is installed.

```bash
# rpm -q dovecot
package dovecot is not installed
```


## Remediation

- Run the command to remove dovecot.
```bash
# yum remove dovecot
```


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- Version 7

- 9.2 Ensure only approved ports, protocols, and services are running<br>
Ensure that only network ports, protocols, and services that listen on systems for validated business needs are running on each system.