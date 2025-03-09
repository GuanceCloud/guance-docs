# 0002-user-del-Host User Deleted
---

## Rule ID

- 0002-user-del


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitor whether the host deletes users



## Scan Frequency
- disable

## Theoretical Basis


- Deleting users on a host can be a normal operation. However, if unknown users are deleted from the host, it may lead to information security breaches on the host. Therefore, this action should fall within the audit scope.




## Risk Items


- Hacker penetration



- Data leakage



- Network security



- Mining risk



- Compromised machine risk



## Audit Method
- Verify whether the host has deleted users. You can run the following command for verification:

```bash
cat /etc/passwd |cut -f 1 -d :
```



## Remediation
- If the host has deleted users, carefully review the user information.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Control


- None