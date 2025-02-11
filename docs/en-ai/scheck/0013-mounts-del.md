# 0013-mounts-del-Path Unmounted
---

## Rule ID

- 0013-mounts-del


## Category

- Storage


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitors when a host path is unmounted.


## Scan Frequency
- 1 */5 * * *

## Theoretical Basis

- A bind mount provides an additional view of a related directory tree. Typically, mounts create a tree-like view for storage devices. Bind mounts, however, duplicate an existing directory tree under another mount point. Directories and files obtained through bind mounts are identical to the original directories and files. Changes made from either the mount directory or the original directory are immediately reflected on the other side. In short, this means that any mount point, regular directory, or file can be mounted elsewhere. If it is maliciously unmounted, it can cause data inconsistency and service unavailability.


## Risk Items

- Data inconsistency

- Service unavailability


## Audit Method
- Verify if the path has been unmounted. You can run the following command to check:

```bash
mount
```


## Remediation
- If the main path was maliciously unmounted, carefully inspect the host environment to prevent service unavailability.


## Impact

- None


## Default Value

- None


## References

- [Emergency Response and Investigation Process for Hacker Intrusion (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [A Real Case Study of Cryptojacking Intrusion Investigation (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)


## CIS Controls

- None