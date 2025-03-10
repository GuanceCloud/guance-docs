# 0087-avahi-uninstalled-Avahi Uninstalled

---

## Rule ID

- 0087-avahi-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Avahi is a free zeroconf implementation that includes a system for multicast DNS/DNS-SD service discovery. Avahi allows programs to publish and discover services and hosts running on the local network. For example, users can plug their computer into a network, and Avahi will automatically find printers to print to, files to view, people to chat with, as well as network services running on the machine.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- System functionality typically does not require automatic discovery of network services. It is recommended to remove this package to reduce the potential attack surface.


## Risk Items

- Increase in attack surface


## Audit Method

- Run the following command to verify that the corresponding component is not installed:
```bash
# rpm -q avahi-autoipd avahi
package avahi-autoipd is not installed
package avahi is not installed
```


## Remediation

- Run the following commands to remove the corresponding packages:
```bash
# systemctl stop avahi-daemon.socket avahi-daemon.service
# yum remove avahi-autoipd avahi
```


## Impact

- Systems that rely on Avahi as an alternative to DNS may lose domain name resolution support.


## Default Value

- None


## References

- None


## CIS Controls

- Version 7
    2.6 Address Unauthorized Software
    Ensure unauthorized software is removed or inventory is updated timely