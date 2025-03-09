# 0045-libsbin-add-/sbin Directory Has Added Files
---

## Rule ID

- 0045-libsbin-add


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor the host directory /sbin for new files being added.


## Scan Frequency

- disable

## Theoretical Basis

- The /sbin directory contains critical executable files for system commands. If new files are added, it is necessary to determine whether they are normal system commands.


## Risk Items

- Functionality may become unavailable


## Audit Method

- None


## Remediation

- If files in the /sbin directory are detected as deleted, check if they are normal system commands.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None