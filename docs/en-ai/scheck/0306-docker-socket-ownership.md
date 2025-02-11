# 0306-docker-socket-ownership - docker.socket file ownership is not set to root:root
---

## Rule ID

- 0306-docker-socket-ownership


## Category

- Container


## Level

- Warn


## Compatible Versions

- Linux


## Description

- If you are using Docker on a computer that manages services with systemd, verify that the ownership and group ownership of the Docker.socket file are correctly set to root.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- The docker.socket file contains sensitive parameters that may alter the behavior of the Docker remote API. Therefore, it should be owned by root, and the group should also be owned by root to maintain the integrity of the file.


## Risk Items

- Container Security


## Audit Method

- Execute the following command to verify that the file and group are owned by root:

```bash
stat -c %U:%G /usr/lib/systemd/system/docker.socket | grep -v root:root
```
The above command should not return any output.


## Remediation

- Execute the following command:
```bash
#> chown root:root /usr/lib/systemd/system/docker.socket
```
This will set the ownership and group ownership of the file to root.


## Impact

- None


## Default Value

- This file may not exist on the system. In this case, this recommendation does not apply. By default, if the file exists, the ownership and group ownership of this file will be correctly set to root.


## References

- [docker-unix-socket](https://docs.docker.com/articles/basics/#bind-docker-to-another-hostport-or-a-unix-socket)

- [docker-fedora-atomic-packer](https://github.com/YungSang/fedora-atomic-packer/blob/master/oem/docker.socket)

- [docker-on-boot](http://daviddaeschler.com/2014/12/14/centos-7rhel-7-and-docker-containers-on-boot/)


## CIS Controls

- None