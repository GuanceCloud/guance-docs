# 0088-cups-uninstalled-CUPS is Installed
---

## Rule ID

- 0088-cups-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- The Common Unix Printing System (CUPS) provides the ability to print to local and network printers. Systems running CUPS can also accept print jobs from remote systems and print them on local printers. It also offers web-based remote management capabilities.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- System functions typically do not require automatic discovery of network services. It is recommended to remove this package to reduce potential attack surfaces.


## Risk Items

- Increase in attack surface


## Audit Method

- Run the following command to verify that the corresponding component is not installed:
```bash
# rpm -q cups
package cups is not installed
```


## Remediation

- Run the following command to remove the corresponding package:
```bash
# yum remove cups
```


## Impact

- Disabling CUPS will prevent printing from the system, which is a common task for workstation systems.


## Default Value

- None


## References

- None


## CIS Controls

- Version 7
    2.6 Address unauthorized software
    Ensure unauthorized software is removed or inventory is updated timely