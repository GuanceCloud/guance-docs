# 0300-docker-kernel - Whether the Container Server Kernel Version is 3.10 or Higher
---

## Rule ID

- 0300-docker-kernel


## Category

- Container


## Level

- Warn


## Compatible Versions

- Linux



## Description

- Docker in daemon mode has specific kernel requirements. The 3.10 Linux kernel is the minimum requirement for Docker.



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis

- Kernels earlier than 3.10 lack some features required to run Docker containers. It is well known that these older versions have bugs that can cause data loss and frequent crashes under certain circumstances. Therefore, it is recommended to use the latest minor version (3.x.y) of the 3.10 (or newer maintenance version) Linux kernel. Additionally, using a more recent Linux kernel ensures that critical kernel errors previously discovered are fixed.



## Risk Items

- Container Security



## Audit Method
- Execute the following command to find out the Linux kernel version:

```bash
uname -r
```
Ensure that the found kernel version is 3.10 or higher.



## Remediation
- Review Docker's kernel and operating system requirements and appropriately select your kernel and operating system.



## Impact

- None



## Default Value

- None



## References

- [check-kernel-dependencies](https://docs.docker.com/installation/binaries/#check-kernel-dependencies)

- [installation-list](https://docs.docker.com/installation/#installation-list)


## CIS Control

- None