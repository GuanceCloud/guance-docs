# 0144-crontab - Crontab Scheduled Task Modified
---

## Rule ID

- 0144-crontab


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- A crontab scheduled task has been added.


## Scan Frequency

- disable


## Theoretical Basis

- If the host's crontab scheduled tasks are modified, it can lead to information security breaches on the host. Therefore, this needs to be within the audit scope.


## Risk Items

- Hacker penetration
- Data leakage
- Network security
- Mining risk
- Compromised machine risk


## Audit Method

- Verify whether the host's crontab scheduled tasks have been modified. You can run the following command for verification:

```bash
cat /etc/passwd | cut -f 1 -d : |xargs -I {} crontab -l -u {}
```


## Remediation

- If the host's crontab scheduled tasks have been modified, carefully review the user's crontab scheduled tasks. If any suspicious crontab scheduled tasks exist, delete them.

```bash
crontab -e
```


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None