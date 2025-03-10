# 0044-libbin-del-/bin Directory Has Files Deleted
---

## Rule ID

- 0044-libbin-del


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitor whether files under the host's /bin directory have been deleted



## Scan Frequency
- disable

## Theoretical Basis


- The /bin directory contains essential executable files for critical system commands. If these files are deleted, it may cause the system to fail to operate normally.



## Risk Items


- Function Unavailability



## Audit Method
- None



## Remediation
- If it is detected that files under the /bin directory have been deleted, check if they are critical system commands



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None