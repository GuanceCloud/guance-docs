# 0060-fat-disabled-vfat is Enabled
---

## Rule ID

- 0060-fat-disabled


## Category

- Storage


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor the host to ensure that fat / vfat / msdos are not enabled.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Disabling support for unnecessary file system types can reduce the local attack surface of the system. If this file system type is not required, disable it.


## Risk Items

- Hacker Penetration

- Data Leakage


## Audit Method

- Verify whether fat / vfat / msdos are enabled on the host. You can execute the following command for verification:

```bash
lsmod | egrep "msdos|vfat|fat"
```


## Remediation

- 


## Impact

- 


## Default Value

- None


## References

- None


## CIS Control

- None