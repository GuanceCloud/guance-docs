# 0036-sudoers-sudoers Modified
---

## Rule ID

- 0036-sudoers


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitor whether the host's /etc/sudoers has been modified.



## Scan Frequency
- disable

## Theoretical Basis


- In Linux, the /etc/sudoers file allows users to execute commands as a superuser or other users according to specified security policies. Security policies determine the privileges a user must have to run sudo. The policy may require users to authenticate themselves using a password or other authentication mechanisms.



## Risk Items


- Hacker penetration



- Data leakage



## Audit Method
- Verify if the host's /etc/sudoers exists. You can verify it with the following command:

```bash
cat /etc/sudoers
```



## Remediation
- 


## Impact


- The system may fail to log in properly.




## Default Value


- None




## References


- None



## CIS Controls


- None