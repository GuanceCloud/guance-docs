# 0028-fstab-fstab Modified
---

## Rule ID

- 0028-fstab


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor changes to the host's /etc/fstab file.


## Scan Frequency

- disable


## Theoretical Basis

- The file /etc/fstab contains filesystem information for the system. Incorrect or malicious modifications can prevent the host from booting properly.


## Risk Items

- Service Unavailability


## Audit Method

- Verify whether /etc/fstab has been illegally modified. You can run the following command to check:

```bash
ls -l /etc/fstab
```


## Remediation

- If /etc/fstab has been illegally modified, carefully examine the host environment to ensure it has not been compromised and change the host user passwords. If /etc/fstab is incorrect and prevents access to the Linux system, enter rescue mode and correct the /etc/fstab file.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None