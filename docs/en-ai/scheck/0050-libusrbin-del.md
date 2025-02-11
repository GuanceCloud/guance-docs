# 0050-libusrbin-del-/usr/bin Directory Files Deleted
---

## Rule ID

- 0050-libusrbin-del


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor whether files under the `/usr/bin` directory are deleted.


## Scan Frequency

- Disable


## Theoretical Basis

- The `/usr/bin` directory contains essential executable files for system commands. If these files are deleted, it may cause the system to fail to operate normally.


## Risk Items

- Function Unavailability


## Audit Method

- None


## Remediation

- If files under the `/sbin` directory are detected as deleted, check if they are critical system commands.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None