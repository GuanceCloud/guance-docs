# 0003-user-passwd - Host User Password Modified
---

## Rule ID

- 0003-user-passwd


## Category

- System


## Level

- Warning


## Compatible Versions

- Linux


## Description

- Monitor whether the host user password has been modified.


## Scan Frequency

- Disabled


## Theoretical Basis

- The `/etc/shadow` file is used to store password information for users in a Linux system and is also known as the "shadow file." The `/etc/passwd` file, which allows all users to read it, can easily lead to password leaks. Therefore, Linux systems separate user password information from the `/etc/passwd` file and place it into this file. Only the root user has read permissions for the `/etc/shadow` file; other users have no access, ensuring the security of user passwords. If the permissions of this file change, it may indicate a potential malicious attack.


## Risk Items

- Hacker Penetration
- Data Leakage
- Network Security
- Mining Risk
- Botnet Risk


## Audit Method

- Verify if `/etc/shadow` has been illegally modified. You can use the following command to check:

```bash
ls -l /etc/shadow
```


## Remediation

- If `/etc/shadow` has been illegally modified, carefully inspect the host environment to determine if there has been an intrusion and change the host user password.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None