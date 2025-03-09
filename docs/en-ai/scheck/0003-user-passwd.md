# 0003-user-passwd-Host User Password Changed
---

## Rule ID

- 0003-user-passwd


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitors whether the host user password has been changed



## Scan Frequency
- disable

## Theoretical Basis


- The /etc/shadow file is used to store password information for users in a Linux system and is also known as the "shadow file". The /etc/passwd file, which allows all users read access, can easily lead to password leaks. Therefore, Linux systems separate user password information from the /etc/passwd file and place it into this file. Only the root user has read permissions on the /etc/shadow file; other users have no permissions, ensuring the security of user passwords. If the permissions of this file change, it may indicate a potential malicious attack.






## Risk Items


- Hacker penetration



- Data leakage



- Network security



- Mining risk



- Botnet risk



## Audit Method
- Verify if /etc/shadow has been illegally modified. You can run the following command to check:

```bash
ls -l /etc/shadow
```



## Remediation
- If /etc/shadow has been illegally modified, carefully inspect the host environment to determine if it has been compromised and change the host user password.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None