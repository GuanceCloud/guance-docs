# 0095-samba-uninstalled - Ensure Samba is Not Installed
---

## Rule ID

- 0095-samba-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- The Samba daemon allows system administrators to configure their Linux systems to share file systems and directories with Windows desktops. Samba will publish file systems and directories via the Server Message Block (SMB) protocol. Windows desktop users will be able to mount these directories and file systems as lettered drives on their systems.



## Scan Frequency
- 0 * * * *

## Theoretical Basis





## Risk Items


- Hacker Penetration



- Data Leakage



- Network Security



- Mining Risk



- Zombie Machine Risk



## Audit Method
- Execute the following command to verify if samba is installed.

```bash
# rpm -q samba
package samba is not installed
```



## Remediation
- Run the command to remove samba.
```bash
# yum remove samba
```



## Impact


- None




## Default Value


- None




## References


- None



## CIS Control


- Version 7<br>
  9.2 Ensure only approved ports, protocols, and services are running<br>
     Ensure that only network ports, protocols, and services listening on each system have validated business needs and are running on each system.