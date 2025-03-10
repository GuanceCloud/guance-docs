# 0020-profile-Host Profile Modified
---

## Rule ID

- 0020-profile


## Category

- system


## Level

- warn


## Compatible Versions

- Linux




## Description


- Monitors whether the host /etc/profile has been modified.



## Scan Frequency
- disable

## Theoretical Basis


- Linux is a multi-user operating system. When each user logs into the system, they have a dedicated runtime environment. Typically, the default environment for each user is the same, which is essentially a set of environment variable definitions. Users can customize their runtime environment by modifying the corresponding system environment variables. If /etc/profile is maliciously modified, it can cause services to become unavailable.



## Risk Items


- Services become unavailable



## Audit Method
- Verify if the host /etc/profile has been illegally modified. You can run the following command to verify:

```bash
ls -l /etc/profile
```



## Remediation
- If the host /etc/profile has been modified, carefully check the host environment to determine if there has been an intrusion and change the host user passwords.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Controls


- None