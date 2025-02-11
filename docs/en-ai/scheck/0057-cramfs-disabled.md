# 0057-cramfs-disabled-cramfs is Enabled
---

## Rule ID

- 0057-cramfs-disabled


## Category

- Storage


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor the host to ensure that cramfs is not enabled.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- The cramfs file system type is a compressed, read-only Linux file system embedded in small systems. It can be used with cramfs images without needing to decompress the image first.

- Removing support for unnecessary file system types can reduce the local attack surface of the server. If this file system type is not required, disable it.


## Risk Items

- Hacker penetration

- Data leakage


## Audit Method

- Verify whether cramfs is enabled on the host. You can run the following command to check:

```bash
lsmod | grep cramfs
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