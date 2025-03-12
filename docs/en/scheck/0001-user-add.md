# 0001-user-add-Host Addition of New Users
---

## Rule ID

- 0001-user-add


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor whether the host adds unknown users.


## Scan Frequency

- Disable


## Theoretical Basis

- Adding users to a host is a normal behavior. However, adding unknown users can lead to information security breaches on the host, so it needs to be within the audit scope.


## Risk Items

- Hacker Penetration
- Data Leakage
- Network Security
- Mining Risk
- Botnet Risk


## Audit Method

- Verify if the host has added any users. You can use the following command to verify:

```bash
cat /etc/passwd |cut -f 1 -d :
```


## Remediation

- If the host has added an unknown user, carefully review the user information. If there are suspicious users, delete the user and change the login passwords for other users.
```bash
userdel xxx
```


## Impact

- None


## Default Value

- None


## References

- None


## CIS Control

- None