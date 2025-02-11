# 0036-sudoers-sudoers Modified
---

## Rule ID

- 0036-sudoers


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- Monitor whether the host /etc/sudoers has been modified



## Scan Frequency
- Disable

## Theoretical Basis


- In Linux, the /etc/sudoers file allows users to execute commands as superuser or other users according to specified security policies. Security policies determine the privileges a user must have to run sudo. The policy may require users to authenticate themselves using a password or other authentication mechanisms.



## Risk Items


- Hacker penetration

- Data leakage



## Audit Method
- Verify if the host /etc/sudoers exists. You can use the following command for verification:

```bash
cat /etc/sudoers
```



## Remediation
- 


## Impact


- The system may fail to log in normally




## Default Value


- None




## References


- None



## CIS Control


- None