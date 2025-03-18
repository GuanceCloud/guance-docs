# 0041-yum-repos.d-del Repository Configuration File Deleted

---

## Rule ID

- 0041-yum-repos.d-del


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitor the deletion of configurations in the /etc/yum.repos.d directory on the host.



## Scan Frequency
- disable

## Theoretical Basis


- A repo file is a configuration file for yum repositories (software repositories) in Fedora. Typically, one repo file defines the details of one or more software repositories, such as where we will download the required installation or upgrade packages from. The settings in the repo file are read and applied by yum. If configured incorrectly, it can cause services to be unavailable.



## Risk Items


- Services become unusable



## Audit Method
- Verify if any files have been deleted from the /etc/yum.repos.d directory on the host. You can run the following command to check:

```bash
ls -l /etc/yum.repos.d
```



## Remediation
- If files in /etc/yum.repos.d on the host have been deleted, carefully inspect the host environment to ensure there has been no intrusion, and change the host user passwords.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None