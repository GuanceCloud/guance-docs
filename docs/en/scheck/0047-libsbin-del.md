# 0047-libsbin-del-/sbin Directory Has Files Deleted
---

## Rule ID

- 0047-libsbin-del


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitor whether files under the host directory /sbin have been deleted



## Scan Frequency
- disable

## Theoretical Basis


- The /sbin directory contains critical executable files for system commands. If these files are deleted, it may cause the system to fail to operate normally.



## Risk Items


- Function Unavailability



## Audit Method
- None



## Remediation
- If it is detected that files under the /sbin directory have been deleted, check if they are critical system commands



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None