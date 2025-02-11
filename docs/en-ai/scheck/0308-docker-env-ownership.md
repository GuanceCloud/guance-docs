# 0308-docker-env-ownership-Docker Environment File Ownership Not Set to root:root
---

## Rule ID

- 0308-docker-env-ownership


## Category

- Container


## Level

- Warn


## Compatible Versions

- Linux


## Description

- The Docker daemon uses the Docker environment file to set up the runtime environment for the Docker daemon. If Docker is used on a machine that manages services with systemd, the file is `/etc/sysconfig/docker`. On other systems, the environment file is `/etc/default/docker`. Verify that the ownership and group ownership of the environment file are correctly set to `root`.


## Scan Frequency
- 0 */30 * * *


## Theoretical Basis

- Docker environment files contain sensitive parameters that can alter the behavior of the Docker daemon at runtime. Therefore, it should be owned by `root`, and the group should also be owned by `root` to maintain the integrity of the file.


## Risk Items

- Container Security


## Audit Method

- Execute the following command to verify that the environment file is owned by `root` and the group is owned by `root`:

```bash
stat -c %U:%G /etc/sysconfig/docker | grep -v root:root
```
The above command should not return any output.


## Remediation

- Execute the following command:
```bash
#> chown root:root /etc/sysconfig/docker
```
This will set the ownership and group ownership of the environment file to `root`.


## Impact

- None


## Default Values

- By default, the ownership and group ownership of this file are correctly set to `root`.


## References

- [systemd](https://docs.docker.com/articles/systemd/)


## CIS Controls

- None