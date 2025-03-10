# 0143-crontab-del-crontab scheduled task deleted
---

## Rule ID

- 0143-crontab-del


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- A crontab scheduled task has been deleted



## Scan Frequency
- disable

## Theoretical Basis


- Whether the host deletes crontab scheduled tasks. If the host deletes unknown crontab scheduled tasks, it may lead to information security breaches on the host, so this needs to be within the audit scope.




## Risk Items


- Hacker penetration



- Data leakage



- Network security



- Mining risk



- Botnet risk



## Audit Method
- Verify whether the host has deleted crontab scheduled tasks. You can run the following command to verify:

```bash
cat /etc/passwd | cut -f 1 -d : |xargs -I {} crontab -l -u {}
```



## Remediation
- If the host has deleted crontab scheduled tasks, carefully review the user's crontab scheduled tasks. If any suspicious crontab scheduled tasks exist, delete them.
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