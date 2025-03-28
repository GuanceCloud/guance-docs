# 0080-issue.net-priv

---

## Rule ID

- 0080-issue.net-priv


## Category

- system


## Level

- warn


## Compatible Versions

- Linux




## Description

- The content of the `/etc/issue.net` file will be displayed to users before a remote connection login from the configured service.



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis

- If the `/etc/issue.net` file does not have the correct ownership, unauthorized users may modify it with incorrect or misleading information.



## Risk Items

- Hacker penetration

- Data leakage

- Mining risk

- Botnet risk



## Audit Method
- Run the following command and verify that Uid and Gid are both 0/root, and Access is 644:

```bash
 # stat /etc/issue.net
Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)
```



## Remediation
- Run the following commands to set permissions for `/etc/issue.net`:
```bash
 # chown root:root /etc/issue.net
# chmod u-x,go-wx /etc/issue.net
```



## Impact

- None




## Default Value

- None




## References


## CIS Controls

- Version 7
 14.6 Protect information through access control lists
    Use access control lists for file systems, network shares, claims, applications, or database-specific access control lists to protect all information stored on the system. These controls enforce the principle that only authorized individuals have access to information as part of their responsibilities.