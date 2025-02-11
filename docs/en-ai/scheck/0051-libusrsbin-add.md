# 0051-libusrsbin-add-/usr/sbin Directory Has New Files Added
---

## Rule ID

- 0051-libusrsbin-add


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor the `/usr/sbin` directory for new files being added.


## Scan Frequency

- disable

## Theoretical Basis

- The `/usr/sbin` directory contains essential system command executables. If new files are added, it is necessary to determine if they are legitimate system commands.


## Risk Items

- Functionality may become unavailable


## Audit Method

- None


## Remediation

- If files in the `/sbin` directory are deleted, verify whether they were legitimate system commands.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None