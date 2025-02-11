# 0144-crontab-crontab定时任务被修改
---

## Rule ID

- 0144-crontab


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- Crontab scheduled tasks have been added



## Scan Frequency
- Disable

## Theoretical Basis


- The crontab scheduled task on the host has been modified. If the crontab scheduled task on the host is modified, it may lead to information security breaches on the host, so it needs to be within the audit scope






## Risk Items


- Hacker penetration



- Data leakage



- Network security



- Mining risk



- Botnet risk



## Audit Method
- Verify whether the crontab scheduled task on the host has been modified. You can execute the following command for verification:

```bash
cat /etc/passwd | cut -f 1 -d : |xargs -I {} crontab -l -u {}
```



## Remediation
- If the crontab scheduled task on the host has been modified, carefully review the user's crontab scheduled tasks. If there are any suspicious crontab scheduled tasks, please delete them.
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