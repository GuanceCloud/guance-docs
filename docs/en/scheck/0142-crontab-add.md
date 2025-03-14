# 0142-crontab-add - Crontab Scheduled Task Added
---

## Rule ID

- 0142-crontab-add


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

- Whether the host adds a crontab scheduled task. If an unknown crontab scheduled task is added to the host, it can cause information security breaches on the host. Therefore, this should be within the audit scope.


## Risk Items

- Hacker penetration

- Data leakage

- Network security

- Mining risk

- Zombie machine risk


## Audit Method

- Verify whether the host has added a crontab scheduled task. You can run the following command for verification:

```bash
cat /etc/passwd | cut -f 1 -d : |xargs -I {} crontab -l -u {}
```


## Remediation

- If a crontab scheduled task has been added to the host, carefully review the user's crontab scheduled tasks. If any suspicious crontab scheduled tasks exist, delete them.
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