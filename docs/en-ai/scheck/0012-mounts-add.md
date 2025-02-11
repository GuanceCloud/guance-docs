# 0012-mounts-add-New Path Mounted
---

## Rule ID

- 0012-mounts-add


## Category

- Storage


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor new paths being mounted on the host.


## Scan Frequency
- 1 */5 * * *


## Theoretical Basis

- A bind mount is an alternative view of a related directory tree. Typically, mounts create a tree-like view for storage devices. A bind mount, however, duplicates an existing directory tree to another mount point. Directories and files obtained through a bind mount are identical to the original directories and files; changes made from either the mount directory or the original directory are immediately reflected at the other end. In short, this means that any mount point, regular directory, or file can be mounted elsewhere. If maliciously mounted, it can lead to risks such as data leakage.


## Risk Items

- Data Leakage

- Network Security


## Audit Method
- Verify that a new path has been mounted. You can run the following command to verify:

```bash
mount
```

## Remediation
- If a new path has been maliciously mounted, thoroughly inspect the host environment to prevent data leakage.


## Impact

- None


## Default Value

- None


## References

- [Emergency Response and Investigation Process for Hacker Intrusions (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [A Real Incident Analysis of Cryptojacking Intrusion (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)


## CIS Controls

- None