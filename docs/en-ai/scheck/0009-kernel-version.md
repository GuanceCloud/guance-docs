# 0009-kernel-version-Host Kernel Version Change
---

## Rule ID

- 0009-kernel-version


## Category

- System


## Level

- Critical


## Compatible Versions

- Linux


## Description

- Monitor for changes in the kernel version.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- The kernel is a collection of programs, including interrupt service routines that respond to interrupts, schedulers that manage multiple processes to share processor time, memory management programs responsible for managing address spaces, network services, and inter-process communication system services. The kernel manages the system's hardware devices. Modifying the kernel version can lead to instability and security issues in system services.


## Risk Items

- Application Denial of Service


## Audit Method

- Verify if the kernel version has changed. You can run the following command to check:

```bash
uname -srm
```


## Remediation

- If the kernel version has been illegally modified, carefully inspect the host environment for signs of intrusion and change the host user passwords.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None