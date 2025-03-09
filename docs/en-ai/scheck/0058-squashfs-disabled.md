# 0058-squashfs-disabled-squashfs Enabled

---

## Rule ID

- 0058-squashfs-disabled


## Category

- Storage


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor the host to ensure that squashfs is not enabled.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Disabling support for unnecessary file system types can reduce the local attack surface of the system. If this file system type is not required, disable it.


## Risk Items

- Hacker Penetration

- Data Breach


## Audit Method

- Verify whether squashfs is enabled on the host. You can run the following command to verify:

```bash
lsmod | grep squashfs
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