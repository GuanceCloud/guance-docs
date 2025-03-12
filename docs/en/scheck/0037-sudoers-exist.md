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


- In Linux, the /etc/sudoers file allows users to execute commands as a superuser or another user according to specified security policies. Security policies determine what privileges a user must have to run sudo. The policy may require users to authenticate themselves using a password or other authentication mechanisms.



## Risk Items


- Hacker penetration

- Data leakage



## Audit Method
- Verify whether the host /etc/sudoers exists. You can use the following command to verify:

```bash
ls /etc/sudoers
```



## Remediation
- 


## Impact


- The system may fail to log in properly




## Default Value


- None




## References


- None



## CIS Controls


- None