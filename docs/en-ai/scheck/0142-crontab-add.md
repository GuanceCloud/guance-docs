# 0142-crontab-add - Crontab scheduled task is added
---

## Rule ID

- 0142-crontab-add


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- A crontab scheduled task has been added.


## Scan Frequency

- Disable

## Theoretical Basis

- Whether the host adds a crontab scheduled task. If the host adds an unknown crontab scheduled task, it can cause information security breaches on the host, so this needs to be within the audit scope.


## Risk Items

- Hacker渗透 (Hacker Infiltration)

- Data Leakage

- Network Security

- Mining Risk

- Botnet Risk


## Audit Method

- Verify whether the host has added a crontab scheduled task. You can use the following command for verification:

```bash
cat /etc/passwd | cut -f 1 -d : |xargs -I {} crontab -l -u {}
```

## Remediation

- If a crontab scheduled task has been added to the host, carefully review the user's crontab scheduled tasks. If there are any suspicious crontab scheduled tasks, please delete them.
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

Note: For items like "Hacker渗透" which do not have direct English equivalents in the provided dictionary, they are translated based on context.