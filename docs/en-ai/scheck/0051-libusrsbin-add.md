# 0051-libusrsbin-add-/usr/sbin Directory Added Files
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

- Monitor the addition of new files in the host directory /usr/sbin.


## Scan Frequency

- disable

## Theoretical Basis

- The /usr/sbin directory contains critical executable files for basic system commands. If new files are added, it is necessary to determine whether they are normal system commands.


## Risk Items

- Function unavailable


## Audit Method

- None


## Remediation

- If files in the /sbin directory are detected to be deleted, check if they are normal system commands.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Control

- None