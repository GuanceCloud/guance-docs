# 0301-docker-lxc-notuse - Containers Must Not Use LXC Execution Driver
---

## Rule ID

- 0301-docker-lxc-notuse


## Category

- Container


## Level

- Warn


## Compatible Versions

- Linux


## Description

- The default Docker execution driver is 'libcontainer'. LXC as an execution driver is optional and only has legacy support.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Kernels earlier than 3.10 lack some features required to run Docker containers. It is well known that these older versions have bugs that can cause data loss and frequent crashes in certain situations. Therefore, it is recommended to use the latest minor version (3.x.y) of the 3.10 (or newer maintenance version) Linux kernel. Additionally, using a more recent Linux kernel ensures that critical kernel bugs discovered previously have been fixed.


## Risk Items

- Container Security


## Audit Method

- Execute the following command to determine the Linux kernel version:

```bash
uname -r
```
Ensure that the found kernel version is 3.10 or newer.


## Remediation

- Review Docker's kernel and operating system requirements and appropriately select your kernel and operating system.


## Impact

- None


## Default Value

- None


## References

- [Check Kernel Dependencies](https://docs.docker.com/installation/binaries/#check-kernel-dependencies)

- [Installation List](https://docs.docker.com/installation/#installation-list)


## CIS Control

- None