# 0059-udf-disabled-UDF is Enabled
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

- Monitor the host to ensure that UDF is not enabled.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Disabling support for unnecessary file system types can reduce the local attack surface of the system. If this file system type is not required, disable it.


## Risk Items

- Hacker渗透

- Data Leakage


## Audit Method

- Verify whether UDF is enabled on the host. You can run the following command to verify:

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

Please note that "黑客渗透" was left untranslated as it seems to be a term that should be clarified or corrected in the original text. If you want it translated, please specify the correct term in English.