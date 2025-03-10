# 0075-SETroubleshoot-uninstalled - Ensure SETroubleshoot is Not Installed
---

## Rule ID

- 0075-SETroubleshoot-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Prelink is a program that modifies ELF shared libraries and ELF dynamically linked binaries to significantly reduce the time required by the dynamic linker to perform relocations at startup.



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- The prelink feature may interfere with AIDE operations because it changes binary files. If a malicious user can compromise common libraries such as libc, prelinking also increases system vulnerabilities.



## Risk Items


- Service unavailability



## Audit Method
- Verify that prelink is not installed. Run the following command:

```bash
 # rpm -q prelink
package prelink is not installed
```




## Remediation
- Run the following command to restore binaries to their normal state:

``` bash
# prelink -ua
```
Verify that prelink is not installed. Run the following command:
``` bash
yum remove prelink
```



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- Version 7
>   14.9 Enforce detailed logging for access to or changes of sensitive data
   Enforce detailed audit logging for access to or changes of sensitive data (using tools such as file integrity monitoring or security information and event monitoring).