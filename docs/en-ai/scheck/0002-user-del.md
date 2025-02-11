# 0002-user-del-Host User Deleted
---

## Rule ID

- 0002-user-del


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- Monitor whether the host has deleted a user



## Scan Frequency
- Disable

## Theoretical Basis


- Deleting a user on the host is a normal operation. However, if an unknown user is deleted from the host, it may lead to information security breaches. Therefore, this action should be within the scope of audits.




## Risk Items


- Hacker Penetration

- Data Leakage

- Network Security

- Mining Risk

- Botnet Risk



## Audit Method
- Verify whether the host has deleted a user. You can run the following command for verification:

```bash
cat /etc/passwd |cut -f 1 -d :
```



## Remediation
- If the host has deleted a user, carefully review the user information.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None