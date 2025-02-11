# 0104-talk-uninstalled-talk Client Installed
---

## Rule ID

- 0104-talk-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- The talk software allows users to send and receive messages across systems via terminal sessions. By default, the talk client that enables session initialization is installed.



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- Since the software communicates using unencrypted protocols, there are security risks.



## Risk Items


- Hacker Penetration

- Data Leakage

- Network Security

- Mining Risk

- Botnet Risk



## Audit Method
- Run the following command to verify that the talk package is not installed:

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


- Many insecure service clients are used as troubleshooting tools and test environments. Uninstalling them can limit testing and troubleshooting capabilities. If necessary, it is recommended to remove the client after use to prevent accidental or intentional misuse.




## Default Value



## References


- None



## CIS Controls


- Version 7
2.6 Unauthorized Software
Ensure unauthorized software is removed or resource inventory is updated promptly