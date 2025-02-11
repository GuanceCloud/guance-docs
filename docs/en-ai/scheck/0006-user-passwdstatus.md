# 0006-user-passwdstatus - Host User Password Status Change

---

## Rule ID

- 0006-user-passwdstatus


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitors changes in the status of host user passwords.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Account password status can be one of three states: LK (Locked), NP (No Password Set), PS (Password Set). Information about the status of host account passwords is critical for user login. If an unknown operation causes a change in the password status, it is important to check if the host environment has been compromised.


## Risk Items

- Hacker Infiltration
- Data Breach
- Network Security
- Mining Risk
- Botnet Risk


## Audit Method

- Verify whether the host account password status has been illegally modified. You can run the following command to verify:

```bash
ls -l /etc/shadow
```

## Remediation

- If the host account password status has been illegally modified, carefully inspect the host environment for signs of compromise and change the host user password.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None