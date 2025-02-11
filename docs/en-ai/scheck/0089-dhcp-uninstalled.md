# 0089-dhcp-uninstalled-DHCP Uninstalled

---

## Rule ID

- 0089-dhcp-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- The Dynamic Host Configuration Protocol (DHCP) is a service that allows dynamic allocation of IP addresses to computers.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Unless the system is specifically configured to act as a DHCP server, it is recommended to remove the dhcp package to reduce potential attack surfaces



## Risk Items


- Increased risk of being attacked



## Audit Method
- Run the following command to verify that the corresponding component is not installed:
```bash
# rpm -q dhcp
package dhcp is not installed
```



## Remediation
- Run the following command to remove the corresponding package:
```bash
# yum remove dhcp
```



## Impact


- Servers within the cluster may have some risk of not automatically obtaining IP addresses and subnet masks assigned by the server.




## Default Value


- None




## References


- None



## CIS Controls


- Version 7
    2.6 Address Unauthorized Software
    Ensure unauthorized software is removed or inventory is updated in a timely manner