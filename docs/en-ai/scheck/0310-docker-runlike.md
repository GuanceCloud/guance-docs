# 0310-docker-runlike - Obtain Docker Runtime Run Parameters
---

## Rule ID

- 0310-docker-runlike


## Category

- Container


## Level

- Warn


## Compatible Versions

- Linux


## Description

- The Docker daemon uses the Docker environment file to set up its runtime environment. If Docker is used on a computer managed by systemd, the file is `/etc/sysconfig/docker`. On other systems, the environment file is `/etc/default/docker`. Verify that the permissions of the environment file are correctly set to "644" or stricter.


## Scan Frequency
- 0 */30 * * *


## Theoretical Basis

- The Docker environment file contains sensitive parameters that can change the behavior of the Docker daemon at runtime. Therefore, it should only be writable by "root" to maintain the integrity of the file.


## Risk Items

- Container Security


## Audit Method
- Execute the following command to verify that the environment file permissions are set to "644" or stricter:

```bash
stat -c %a /etc/sysconfig/docker
```

## Remediation
- Execute the following command:
```bash
#> chmod 644 /etc/sysconfig/docker
```
This sets the file permissions of the environment file to "644".


## Impact

- None


## Default Values

- By default, the file permissions of this file are correctly set to "644".


## References

- [systemd](https://docs.docker.com/articles/systemd/)


## CIS Controls

- None