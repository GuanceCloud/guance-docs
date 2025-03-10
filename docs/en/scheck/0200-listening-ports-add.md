# 0200-listening-ports-add - New Port Opened on Host
---

## Rule ID

- 0200-listening-ports-add


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- A port is the English term "port" translated into Chinese, which can be considered as an exit for communication between a device and the outside world. Ports can be divided into virtual ports and physical ports. Virtual ports refer to those inside computers or routers/switches, which are invisible. For example, port 80, port 21, and port 23 in computers. Physical ports, also known as interfaces, are visible ports such as RJ45 network ports on computer backplates, switches, routers, hubs, etc. Telephone RJ11 jacks also fall under the category of physical ports.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Adding unknown ports to a host can pose a risk of data leakage.


## Risk Items

- Hacker penetration

- Data leakage

- Network security

- Mining risk

- Compromised machine risk


## Audit Method

- Execute the following command to find out the port numbers on Linux:
```bash
netstat -nltp
```
Ensure that the port is one you are aware of.


## Remediation

- Please execute the following commands to clear unknown risky ports:
```bash
netstat -anp | grep your_port
kill -9 PID
```


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None