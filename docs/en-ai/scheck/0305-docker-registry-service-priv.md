# 0305-docker-registry-service-priv-docker.registry.service File Permissions Not Set to 644 or More Restrictive
---

## Rule ID

- 0305-docker-registry-service-priv


## Category

- Container


## Level

- Warn


## Compatible Versions


- Linux




## Description


- If you are using Docker on a computer that manages services with systemd, verify that the permissions for the Docker registry.service file are correctly set to "644" or more restrictive.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- The docker registry.service file contains sensitive parameters that may alter the behavior of the Docker daemon. Therefore, no user other than root should have write access to maintain the integrity of the file.



## Risk Items


- Container Security



## Audit Method
- Execute the following command to verify if the file permissions are set to "644" or more restrictive:

```bash
stat -c %a /usr/lib/systemd/system/docker-registry.service
```



## Remediation
- Execute the following command:
```bash
#> chmod 644 /usr/lib/systemd/system/docker-registry.service
```
This will set the file permissions to 644.



## Impact


- None




## Default Value


- This file may not exist on the system. In such cases, this recommendation does not apply. By default, if the file exists, its permissions will be correctly set to 644.




## References


- [docker-systemd](https://docs.docker.com/articles/systemd/)



- [docker-registry](https://github.com/docker/docker-registry)



## CIS Controls


- None