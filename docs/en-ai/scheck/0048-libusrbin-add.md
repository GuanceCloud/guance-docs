# 0048-libusrbin-add-/usr/bin Directory Has New Files Added
---

## Rule ID

- 0048-libusrbin-add


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitor the /usr/bin directory on the host for new files being added.



## Scan Frequency
- disable

## Theoretical Basis


- The /usr/bin directory contains essential executable files for system commands. If new files are added, it is necessary to determine whether they are legitimate system commands.



## Risk Items


- Functionality unavailable



## Audit Method
- None



## Remediation
- If files in the /usr/bin directory are detected as deleted, check if they are legitimate system commands.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Control


- None