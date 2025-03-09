# 0104-talk-uninstalled-talk Client Installed
---

## Rule ID

- 0104-talk-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- The talk software allows users to send and receive messages across systems through terminal sessions. By default, the talk client that enables session initialization is installed.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Since the software communicates using unencrypted protocols, there are security risks.


## Risk Items

- Hacker penetration

- Data leakage

- Network security

- Mining risk

- Zombie machine risk


## Audit Method

- Run the following command to verify if the talk package is not installed:

```bash
 # rpm -q talk
package talk is not installed
```


## Remediation

- Run the following command to remove the talk package:

```bash
# yum remove talk
```


## Impact

- Many insecure service clients are used as troubleshooting tools and test environments. Uninstalling them will inhibit testing and troubleshooting capabilities. If necessary, it is recommended to remove the client after use to prevent accidental or intentional misuse.


## Default Value

- None


## References

- None


## CIS Control

- Version 7
2.6 Unapproved Software Address
Ensure unauthorized software is removed or resource catalogs are updated in a timely manner