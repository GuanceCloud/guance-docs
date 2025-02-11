# 0041-yum-repos.d-del Repository Configuration File Deleted
---

## Rule ID

- 0041-yum-repos.d-del


## Category

- System


## Severity

- Warning


## Compatible Versions


- Linux




## Description


- Monitor the deletion of configurations in the `/etc/yum.repos.d` directory on the host.



## Scan Frequency
- Disabled

## Background


- Repo files are configuration files for yum repositories (software repositories) in Fedora. Typically, a repo file defines the details of one or more software repositories, such as where to download the required installation or upgrade packages from. The settings in the repo files will be read and applied by yum. If configured incorrectly, this can cause services to become unavailable.



## Risk Items


- Services may become unusable



## Audit Method
- Verify whether any files have been deleted from the `/etc/yum.repos.d` directory on the host. You can use the following command to check:

```bash
ls -l /etc/yum.repos.d
```



## Remediation
- If the `/etc/yum.repos.d` directory on the host has been deleted, carefully inspect the host environment for signs of intrusion and change the host user passwords.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None