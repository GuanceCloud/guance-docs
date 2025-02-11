# 0303-docker-service-priv-docker.service File Permissions Not Set to 644 or More Restrictive
---

## Rule ID

- 0303-docker-service-priv


## Category

- Container


## Level

- Warn


## Compatible Versions

- Linux


## Description

- If you are using Docker on a computer that manages services with systemd, verify that the permissions for the docker.service file are correctly set to 644 or more restrictive.


## Scan Frequency
- 0 */30 * * *

## Theoretical Basis

- The docker.service file contains sensitive parameters that can alter the behavior of the Docker daemon. Therefore, no user other than root should be able to write to it to maintain the integrity of the file.


## Risk Items

- Container Security


## Audit Method
- Execute the following command to verify if the file permissions are set to "644" or more restrictive:

```bash
stat -c %a /usr/lib/systemd/system/docker.service
```


## Remediation
- Execute the following command:
```bash
#> chmod 644 /usr/lib/systemd/system/docker.service
```
This will set the file permissions to "644".


## Impact

- None


## Default Values

- This file may not exist on the system. In such cases, this recommendation does not apply. By default, if the file exists, its permissions will be correctly set to 644.


## References

- [docker-systemd](https://docs.docker.com/articles/systemd/)


## CIS Controls

- None