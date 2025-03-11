# 0050-libusrbin-del-/usr/bin Directory Has Files Deleted
---

## Rule ID

- 0050-libusrbin-del


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor whether files under the host directory /usr/bin have been deleted.


## Scan Frequency

- disable

## Theoretical Basis

- The /usr/bin directory contains executable files of critical system commands. If these files are deleted, it may cause the system to fail to operate normally.


## Risk Items

- Function Unavailability


## Audit Method

- None


## Remediation

- If files in the /sbin directory are detected to be deleted, check if they are critical system commands.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None