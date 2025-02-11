# 0008-hostname-Hostname is Modified
---

## Rule ID

- 0008-hostname


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux
- Windows


## Description

- Monitor changes in the hostname.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- In the Linux operating system, the hostname is a kernel variable that can be viewed using the `hostname` command. You can also directly view it by running `cat /proc/sys/kernel/hostname`. If the hostname is set incorrectly, it may cause online services or applications to fail to access properly, and may even refuse to provide service. If the hostname is maliciously modified, it can affect the normal operation of the host system.


## Risk Items

- Application Denial of Service


## Audit Method

- Verify whether the hostname has been illegally modified. You can execute the following command for verification:

```bash
hostname
```


## Remediation

- If the hostname has been illegally modified, use `hostnamectl set-hostname` to restore the hostname. Be sure to carefully check the host environment to see if it has been compromised, and change the host user password.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None