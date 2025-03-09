# 0006-user-passwdstatus - Host User Password Status Change

---

## Rule ID

- 0006-user-passwdstatus


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitors changes in the status of host user passwords.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Account password status can be LK (locked), NP (no password set), or PS (password set). Information about the password status of host accounts is critical for user login. If an unknown operation causes a change in the account password status, it is important to check whether the host environment has been compromised.


## Risk Items

- Hacker penetration
- Data leakage
- Network security
- Mining risk
- Botnet risk


## Audit Method

- Verify if the host account password status has been illegally modified. You can run the following command to verify:

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