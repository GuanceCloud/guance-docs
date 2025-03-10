# 0092-dns-uninstalled-DNS is Uninstalled
---

## Rule ID

- 0092-dns-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- The Domain Name System (DNS) is a hierarchical naming system that maps names to IP addresses of computers, services, and other resources connected to the network.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Unless a system is specifically designated as a DNS server, it is recommended to remove this package to reduce potential attack surfaces.



## Risk Items


- Increased risk of being attacked



## Audit Method
- Run the following command to verify that the corresponding component is not installed:
```bash
# rpm -q bind
package bind is not installed
```



## Remediation
- Run the following command to remove the corresponding package:
```bash
# yum remove bind
```



## Impact


- If you are using this server for DNS, the cluster may lose its domain name resolution capability.




## Default Value


- None




## References


- None



## CIS Controls


- Version 7
  9.2 Ensure only approved ports, protocols, and services are running  
  Ensure that only network ports, protocols, and services with validated business needs are listening on each system.