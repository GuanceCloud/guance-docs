# 0201-listening-ports-del - Host Port Closed

---

## Rule ID

- 0201-listening-ports-del


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- A port is the translation of the English word "port," which can be considered as an exit for communication between a device and the outside world. Ports can be divided into virtual ports and physical ports, where virtual ports refer to ports within a computer or inside switches and routers that are not visible. For example, port 80, port 21, and port 23 in computers. Physical ports, also known as interfaces, are visible ports such as RJ45 network ports on the back panel of a computer, or RJ45 ports on switches, routers, and hubs. Telephone RJ11 jacks also fall under the category of physical ports.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- If a host port is closed, it can cause services to become unavailable.


## Risk Items

- Service unavailability


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