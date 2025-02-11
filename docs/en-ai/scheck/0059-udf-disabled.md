# 0059-udf-disabled-udf Enabled

---

## Rule ID

- 0059-udf-disabled


## Category

- Storage


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor the host to ensure that udf is not enabled.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Disabling support for unnecessary file system types can reduce the local attack surface of the system. If this file system type is not required, disable it.


## Risk Items

- Hacker penetration
- Data leakage


## Audit Method

- Verify whether udf is enabled on the host. You can run the following command to verify:

```bash
lsmod | grep udf
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