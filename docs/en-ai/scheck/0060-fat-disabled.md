# 0060-fat-disabled-vfat is Enabled
---

## Rule ID

- 0060-fat-disabled


## Category

- storage


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor the host to ensure that fat / vfat / msdos are not enabled.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Disabling support for unnecessary file system types can reduce the local attack surface of the system. If this file system type is not required, disable it.


## Risk Items

- Hacker penetration

- Data leakage


## Audit Method

- Verify whether fat / vfat / msdos is enabled on the host. You can run the following command to verify:

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


## CIS Controls

- None