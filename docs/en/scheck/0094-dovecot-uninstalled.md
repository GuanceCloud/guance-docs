# 0094-dovecot-uninstalled-IMAP and POP3 Services Installed
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


- Hacker Penetration



- Data Breach



- Network Security



- Mining Risk



- Botnet Risk



## Audit Method
- Execute the following command to verify if dovecot is installed.

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



- 9.2 Ensure Only Approved Ports, Protocols, and Services Are Running<br>
    Ensure that only network ports, protocols, and services that have been validated by business requirements are listening on each system.