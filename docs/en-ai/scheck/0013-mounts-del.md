# 0013-mounts-del-Path Unmounted
---

## Rule ID

- 0013-mounts-del


## Category

- storage


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitor the situation where a host path is unmounted.



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- A bind mount provides an additional view of a related directory tree. Typically, mounts create a tree-like view for storage devices. A bind mount duplicates an existing directory tree to another mount point. Directories and files obtained through a bind mount are identical to the original directories and files. Changes made from either the mounted directory or the original directory will immediately reflect on the other end. In short, it allows mounting any mount point, regular directory, or file to another location. If unmounted maliciously, it can lead to incomplete data and service unavailability.



## Risk Items


- Data inconsistency

- Service unavailability



## Audit Method
- Verify if the path has been unmounted. You can run the following command to check:

```bash
mount
```



## Remediation
- If the main path was maliciously unmounted, carefully examine the host environment to prevent service unavailability.



## Impact


- None




## Default Value


- None




## References


- [Emergency Response Thought Process and Procedure for Hacker Intrusion (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [A Real Case Study of Mining Malware Intrusion Analysis (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS Controls


- None