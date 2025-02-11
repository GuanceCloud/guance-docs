# 0078-motd-priv-Ensure MOTD Permissions (-rw-r--r--)
---

## Rule ID

- 0078-motd-priv


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- After login, the content of the `/etc/motd` file will be displayed to users as the message of the day for authenticated users.



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- If the `/etc/motd` file does not have the correct ownership, unauthorized users may modify it with incorrect or misleading information.



## Risk Items


- Hacker penetration

- Data leakage

- Mining risk

- Botnet risk



## Audit Method
- Run the following command and verify that Uid and Gid are both 0 root, and Access is 644:

```bash
 # stat /etc/motd
Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)
```



## Remediation
- Run the following commands to set the permissions for `/etc/motd`:
```bash
# chown root:root /etc/motd
# chmod u-x,go-wx /etc/motd
```



## Impact


- None




## Default Value


- None




## References


## CIS Controls


- Version 7
14.6 Protect Information Through Access Control Lists
    Use access control lists for file systems, network shares, claims, applications, or database-specific access control lists to protect all information stored on the system. These controls enforce the principle that only authorized individuals have access to information as part of their duties.