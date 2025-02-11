# 0097-net-snmp-uninstalled - Ensure net-snmp is not installed
---

## Rule ID

- 0097-net-snmp-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- SNMP servers can communicate using SNMPv1, which transmits data in clear text. SNMPv1 transmits data without authentication for executing commands. SNMPv3 replaced the simple/clear text passwords used in SNMPv2 with more secure parameter encoding. If SNMP services are not required, the net-snmp package should be removed to reduce the system attack surface.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- SNMP (Simple Network Management Protocol) is a widely used network monitoring protocol for managing network devices, computer equipment, and UPS devices.
    Net-SNMP is a suite of applications that implement SNMPv1 (rfc1157), SNMPv2 (RFC . Net-SNMP), and SNMPv3 (rfc3411 -3418) which supports both IPv4 and IPv6. Support for the classic version of SNMPv2 “SNMPv2 historic” (rfc1441 -1452) was dropped in UCD-snmp package version 4.0.
    SNMP (Simple Network Management Protocol) servers listen for SNMP commands, execute commands or collect information, and then send the results back to the requesting system. SNMP (Simple Network Management Protocol) is a widely used network monitoring protocol for managing network devices, computer equipment, and UPS devices.
    Net-SNMP is a suite of applications that implement SNMPv1 (rfc1157), SNMPv2 (RFC . Net-SNMP), and SNMPv3 (rfc3411 -3418) which supports both IPv4 and IPv6. Support for the classic version of SNMPv2 “SNMPv2 historic” (rfc1441 -1452) was dropped in UCD-snmp package version 4.0.
    SNMP (Simple Network Management Protocol) servers listen for SNMP commands, execute commands or collect information, and then send the results back to the requesting system.



## Risk Items


- Hacker penetration



- Data leakage



- Network security



- Mining risk



- Botnet risk



## Audit Method
- Run the following command to verify if net-snmp is installed.

```bash
# rpm -q net-snmp
package net-snmp is not installed
```



## Remediation
- Run the command to remove net-snmp.
```bash
# yum remove net-snmp
```



## Impact


- None




## Default Value



## References


## CIS Controls


- Version 7



- 2.6 Address Unauthorized Software<br>
    Ensure unauthorized software is either deleted or updated in a timely manner.



- 9.2 Ensure Only Approved Ports, Protocols, and Services Are Running<br>
    Ensure only network ports, protocols, and services listening on each system are those validated by business needs.