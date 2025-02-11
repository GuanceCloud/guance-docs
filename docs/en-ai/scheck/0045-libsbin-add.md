# 0045-libsbin-add-/sbin Directory Added Files
---

## Rule ID

- 0045-libsbin-add


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitoring detects new files added under the host directory `/sbin`.


## Scan Frequency

- Disable


## Theoretical Basis

- The `/sbin` directory contains essential system commands. If new files are added, it is necessary to determine whether they are legitimate system commands.


## Risk Items

- Function Unavailability


## Audit Method

- None


## Remediation

- If files in the `/sbin` directory are found to be deleted, check if they were legitimate system commands.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None