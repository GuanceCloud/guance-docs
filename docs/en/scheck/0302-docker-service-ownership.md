# 0302-docker-service-ownership-docker.service File Ownership Not Set to root:root
---

## Rule ID

- 0302-docker-service-ownership


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- If Docker is used on a computer that manages services using systemd, verify that the ownership and group ownership of the docker.service file are correctly set to root.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- The docker.service file contains sensitive parameters that may alter the behavior of the Docker daemon. Therefore, it should be owned by root, and the group should also be owned by root to maintain the integrity of the file.


## Risk Items

- Container Security


## Audit Method

- Execute the following command to verify that the file and group belong to root:

```bash
stat -c %U:%G /usr/lib/systemd/system/docker.service | grep -v root:root
```
The above command should not return any output.


## Remediation

- Execute the following command:
```bash
#> chown root:root /usr/lib/systemd/system/docker.service
```
This will set the ownership and group ownership of the file to root.


## Impact

- None


## Default Values

- This file may not exist on the system. In this case, this recommendation does not apply. By default, if the file exists, the ownership and group ownership of the file will be correctly set to root.


## References

- [docker-systemd](https://docs.docker.com/articles/systemd/)


## CIS Controls

- None