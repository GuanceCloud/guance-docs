# 0009-kernel-version-Host Kernel Version Change
---

## Rule ID

- 0009-kernel-version


## Category

- system


## Severity

- critical


## Compatible Versions

- Linux


## Description

- Monitor for changes in the kernel version.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- The kernel is composed of a series of programs, including interrupt service routines responsible for responding to interrupts, schedulers responsible for managing multiple processes to share processor time, memory management programs responsible for managing address spaces, network services, and inter-process communication system services. The kernel manages the system's hardware devices. Changes in the kernel version can cause instability and security issues in system services.


## Risk Items

- Application Denial of Service


## Audit Method

- Verify that the kernel version has changed. You can execute the following command to verify:

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