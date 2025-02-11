# 0039-yum-repos.d-yum Repository Configuration Modified
---

## Rule ID

- 0039-yum-repos.d


## Category

- System


## Severity

- Warn


## Compatible Versions


- Linux




## Description


- Monitors changes in the configuration files under the host's `/etc/yum.repos.d` directory.



## Scan Frequency
- Disabled

## Theoretical Basis


- Repo files are configuration files for Fedora's yum repositories (software repositories). Typically, one repo file defines the details of one or more software repositories, such as where to download the required installation or upgrade packages from. The settings in the repo files will be read and applied by yum. Incorrect configurations can lead to service unavailability.



## Risk Items


- Service Unavailability



## Audit Method
- Verify whether the `/etc/yum.repos.d` directory on the host has been illegally modified. You can run the following command to check:

```bash
ls -l /etc/yum-repos.d
```



## Remediation
- If the `/etc/yum.repos.d` directory on the host has been illegally modified, carefully inspect the host environment for any signs of intrusion and change the host user passwords.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None