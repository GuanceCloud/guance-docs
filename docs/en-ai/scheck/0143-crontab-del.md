# 0143-crontab-del-Crontab Scheduled Task Deleted
---

## Rule ID

- 0143-crontab-del


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- A crontab scheduled task has been deleted.



## Scan Frequency
- Disable

## Theoretical Basis


- Whether the host deletes crontab scheduled tasks. If the host deletes unknown crontab scheduled tasks, it may lead to information security breaches on the host. Therefore, this needs to be within the audit scope.




## Risk Items


- Hacker Infiltration

- Data Leakage

- Network Security

- Mining Risk

- Botnet Risk



## Audit Method
- Verify whether the host has deleted crontab scheduled tasks. You can use the following command for verification:

```bash
cat /etc/passwd | cut -f 1 -d : |xargs -I {} crontab -l -u {}
```



## Remediation
- If the host has deleted crontab scheduled tasks, carefully review the user's crontab scheduled tasks. If there are any suspicious crontab scheduled tasks, delete them.
```bash
crontab -e
```



## Impact


- None




## Default Value


- None




## References


- None



## CIS Control


- None