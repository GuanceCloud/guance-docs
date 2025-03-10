# 0304-docker-registry-ownership-registry.service File Ownership Not Set to root:root
---

## Rule ID

- 0304-docker-registry-ownership


## Category

- Container


## Level

- Warn


## Compatible Versions


- Linux




## Description


- If you are using Docker on a computer that manages services with systemd, verify that the ownership and group ownership of the Docker registry.service file are correctly set to root.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- The docker.service file contains sensitive parameters that may change the behavior of the Docker daemon. Therefore, it should be owned by root, and the group should also be owned by root to maintain the integrity of the file.



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




## Default Value


- This file may not exist on the system. In this case, this recommendation does not apply. By default, if the file exists, its ownership and group ownership will be correctly set to root.




## References


- [docker-systemd](https://docs.docker.com/articles/systemd/)



- [docker-registry](https://github.com/docker/docker-registry)



## CIS Controls


- None