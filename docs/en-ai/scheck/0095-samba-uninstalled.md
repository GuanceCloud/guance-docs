# 0095-samba-uninstalled - Ensure Samba is Not Installed
---

## Rule ID

- 0095-samba-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- The Samba daemon allows system administrators to configure their Linux systems to share file systems and directories with Windows desktops. Samba publishes file systems and directories via the Server Message Block (SMB) protocol. Windows desktop users will be able to mount these directories and file systems as lettered drives on their systems.



## Scan Frequency
- 0 * * * *

## Theoretical Basis





## Risk Items


- Hacker Penetration



- Data Breach



- Network Security



- Mining Risk



- Botnet Risk



## Audit Method
- Execute the following command to verify whether Samba is installed.

```bash
# rpm -q samba
package samba is not installed
```



## Remediation
- Run the command to remove Samba.
```bash
# yum remove samba
```



## Impact


- None




## Default Values


- None




## References


- None



## CIS Controls


- Version 7<br>
  9.2 Ensure Only Approved Ports, Protocols, and Services Are Running<br>
     Ensure that only network ports, protocols, and services listening on each system are those required by validated business needs.