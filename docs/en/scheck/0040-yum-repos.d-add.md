# 0040-yum-repos.d-add-Add New YUM Repository File
---

## Rule ID

- 0040-yum-repos.d-add


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- Monitor the addition of configurations in the /etc/yum.repos.d directory on the host.



## Scan Frequency
- Disable

## Theoretical Basis


- A repo file is a configuration file for YUM repositories (software repositories) in Fedora. Typically, one repo file defines the details of one or more software repositories, such as where we will download the packages needed for installation or upgrades from. The settings in the repo file will be read and applied by YUM. If configured incorrectly, it can cause services to be unavailable.



## Risk Items


- Services may become unusable



## Audit Method
- Verify if any files have been added under the /etc/yum.repos.d directory on the host. You can use the following command to verify:

```bash
ls -l /etc/yum.repos.d
```



## Remediation
- If files have been added to /etc/yum.repos.d on the host, carefully check the host environment to ensure there has been no intrusion and change the host user passwords.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None