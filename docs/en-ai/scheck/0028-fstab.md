# 0028-fstab-fstab has been modified
---

## Rule ID

- 0028-fstab


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- Monitor the modification of the host's `/etc/fstab` file.



## Scan Frequency
- Disable

## Theoretical Basis


- The file `/etc/fstab` contains information about the file systems in the system. If it is misconfigured or maliciously modified, it can prevent the host from booting properly.



## Risk Items


- Service Unavailability



## Audit Method
- Verify whether the host's `/etc/fstab` has been illegally modified. You can use the following command to verify:

```bash
ls -l /etc/fstab
```



## Remediation
- If the host's `/etc/fstab` has been illegally modified, carefully inspect the host environment for signs of intrusion and change the host user passwords.
If `/etc/fstab` is incorrect, the Linux system cannot be accessed; enter rescue mode and modify the `/etc/fstab` file.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None