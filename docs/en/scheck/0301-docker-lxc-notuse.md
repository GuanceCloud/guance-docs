# 0301-docker-lxc-notuse-Containers must not use the lxc execution driver
---

## Rule ID

- 0301-docker-lxc-notuse


## Category

- container


## Level

- warn


## Compatible Versions


- Linux




## Description


- The default Docker execution driver is 'libcontainer'. LXC as an execution driver is optional and only has legacy support.



## Scan Frequency
- 1 */5 * * *

## Theory


- Kernels earlier than 3.10 lack some features required to run Docker containers. It is well known that these older versions have bugs that can lead to data loss, and in some cases frequent crashes. Therefore, it is recommended to use the latest minor version of the 3.10 (or newer maintenance version) Linux kernel (3.x.y). Additionally, using a newer Linux kernel ensures that critical kernel bugs discovered previously are fixed.



## Risk Items


- Container Security



## Audit Method
- Execute the following command to find out the Linux kernel version:

```bash
uname -r
```
Ensure that the found kernel version is 3.10 or newer.



## Remediation
- Review Docker kernel and operating system requirements and appropriately choose your kernel and operating system.



## Impact


- None




## Default Value


- None




## References


- [check-kernel-dependencies](https://docs.docker.com/installation/binaries/#check-kernel-dependencies)



- [installation-list](https://docs.docker.com/installation/#installation-list)



## CIS Controls


- None