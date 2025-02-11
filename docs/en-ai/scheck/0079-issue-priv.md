# 0079-issue-priv-Ensure issue Permissions (-rw-r--r--)
---

## Rule ID

- 0079-issue-priv


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- Before logging in locally, the contents of the /etc/issue file will be displayed to the user.



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- If the /etc/issue file does not have the correct ownership, unauthorized users may modify it with incorrect or misleading information.



## Risk Items


- Hacker Penetration

- Data Leakage

- Mining Risk

- Botnet Risk



## Audit Method
- Run the following command and verify that Uid and Gid are both 0/root, and Access is 644:

```bash
 # stat /etc/issue
Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)
```



## Remediation
- Run the following commands to set permissions for /etc/issue:
```bash
# chown root:root /etc/issue
# chmod u-x,go-wx /etc/issue
```



## Impact


- None




## Default Value


- None




## References


## CIS Controls


- Version 7
 14.6 Protect Information Through Access Control Lists
    Use access control lists for file systems, network shares, claims, applications, or database-specific controls to protect all information stored on the system. These controls enforce the principle that only authorized individuals have access to information as part of their responsibilities.