# 0020-profile-Host Profile Modified
---

## Rule ID

- 0020-profile


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor whether the host `/etc/profile` has been modified.


## Scan Frequency

- Disable


## Theoretical Basis

- Linux is a multi-user operating system. When each user logs in, they have a dedicated runtime environment. Typically, the default environment for each user is the same, which is essentially a set of defined environment variables. Users can customize their runtime environment by modifying the corresponding system environment variables. If `/etc/profile` is maliciously modified, it can cause services to become unavailable.


## Risk Items

- Services Unavailable


## Audit Method

- Verify if the host `/etc/profile` has been illegally modified. You can use the following command to verify:

```bash
ls -l /etc/profile
```


## Remediation

- If the host `/etc/profile` has been modified, carefully check the host environment to determine if there has been a breach and change the host user passwords.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None