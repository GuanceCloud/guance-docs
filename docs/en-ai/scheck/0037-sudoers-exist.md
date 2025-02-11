# 0037-sudoers-exist-Host /etc/sudoers Does Not Exist
---

## Rule ID

- 0037-sudoers-exist


## Category

- Storage


## Level

- Critical


## Compatible Versions


- Linux




## Description


- Monitor whether the host /etc/sudoers exists



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- In Linux, the /etc/sudoers file allows users to execute commands as superuser or other users according to the specified security policy. The security policy determines what privileges a user must have to run sudo. This policy may require users to authenticate themselves using a password or other authentication mechanisms.



## Risk Items


- Hacker Penetration

- Data Leakage



## Audit Method
- Verify whether the host /etc/sudoers exists. You can use the following command to verify:

```bash
ls /etc/sudoers
```



## Remediation
- 


## Impact


- The system may not log in properly




## Default Value


- None




## References


- None



## CIS Controls


- None