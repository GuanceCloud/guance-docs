# 0201-listening-ports-del-Host Port Closed
---

## Rule ID

- 0201-listening-ports-del


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- A port is the transliteration of the English word "port," which can be considered an outlet for communication between a device and the outside world. Ports can be classified into virtual ports and physical ports, where virtual ports refer to those within computers or inside switches and routers, which are invisible. For example, port 80, port 21, and port 23 in computers. Physical ports, also known as interfaces, are visible ports such as the RJ45 network port on the backplate of a computer, or the RJ45 ports on switches, routers, and hubs. The RJ11 port used by telephones also falls under the category of physical ports.



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- When a host port is closed, it will cause services to be unavailable






## Risk Items


- Services Unavailable



## Audit Method
- Execute the following command to find the port numbers on a Linux system:
```bash
netstat -nltp
```
Ensure that the port is one you are aware of.



## Remediation
- None



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None