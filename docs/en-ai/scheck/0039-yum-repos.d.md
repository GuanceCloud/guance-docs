# 0039-yum-repos.d-yum Repository Configuration Modified
---

## Rule ID

- 0039-yum-repos.d


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitors whether the configuration in the `/etc/yum.repos.d` directory on the host has been modified.



## Scan Frequency
- disable

## Theoretical Basis


- Repo files are configuration files for yum repositories (software repositories) in Fedora. Typically, one repo file defines the details of one or more software repositories, such as where we will download the required installation or upgrade packages from. The settings in the repo files are read and applied by yum. If configured incorrectly, it can lead to service unavailability.



## Risk Items


- Service unusability



## Audit Method
- Verify if the `/etc/yum.repos.d` directory on the host has been illegally modified. You can run the following command to verify:

```bash
ls -l /etc/yum.repos.d
```



## Remediation
- If the `/etc/yum.repos.d` directory on the host has been illegally modified, carefully examine the host environment to determine if there has been a breach, and change the host user passwords.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None