# 0200-listening-ports-add - New Port Opened on Host
---

## Rule ID

- 0200-listening-ports-add


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- A port is the translation of the English word "port" and can be considered as an outlet for communication between a device and the outside world. Ports can be divided into virtual ports and physical ports, where virtual ports refer to ports within a computer or switch/router that are not visible. For example, port 80, port 21, and port 23 in a computer. Physical ports, also known as interfaces, are visible ports such as RJ45 network ports on the back panel of a computer, or RJ45 ports on switches/routers/hubs. Telephone RJ11 jacks also fall under the category of physical ports.


## Scan Frequency
- 1 */5 * * *

## Theoretical Basis

- Adding an unknown port to a host poses a risk of data leakage.


## Risk Items

- Hacker Penetration

- Data Leakage

- Network Security

- Mining Risk

- Botnet Risk


## Audit Method
- Execute the following command to find the port numbers on a Linux system:
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