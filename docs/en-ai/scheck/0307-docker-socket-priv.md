# 0307-docker-socket-priv-docker.socket file permissions are not set to 644 or stricter
---

## Rule ID

- 0307-docker-socket-priv


## Category

- Container


## Level

- Warn


## Compatible Versions

- Linux


## Description

- If Docker is used on a computer managed by systemd, verify that the ownership and group ownership of the 'docker.socket' file are correctly set to 'root'.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis

- The docker.socket file contains sensitive parameters that can alter the behavior of the Docker remote API. Therefore, it should only be writable by root to maintain the integrity of the file.



## Risk Items

- Container Security


## Audit Method
- Execute the following command to verify that the file permissions are correctly set to "644" or stricter:

```bash
stat -c %a /usr/lib/systemd/system/docker.socket
```
The above command should return no output.



## Remediation
- Execute the following command:
```bash
#> chmod 644 /usr/lib/systemd/system/docker.socket
```
This sets the file permissions of this file to "644".



## Impact

- None



## Default Value

- This file may not exist on the system. In such cases, this recommendation does not apply. By default, if the file exists, the file permissions for this file will be correctly set to '644'.



## References

- [docker-unix-socket](https://docs.docker.com/articles/basics/#bind-docker-to-another-hostport-or-a-unix-socket)

- [docker-fedora-atomic-packer](https://github.com/YungSang/fedora-atomic-packer/blob/master/oem/docker.socket)

- [docker-on-boot](http://daviddaeschler.com/2014/12/14/centos-7rhel-7-and-docker-containers-on-boot/)


## CIS Controls

- None