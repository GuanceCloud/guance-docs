# 0049-libusrbin-priv-/usr/bin Directory File Permissions Modified
---

## Rule ID

- 0049-libusrbin-priv


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor whether the file permissions in the /usr/bin directory have been modified.


## Scan Frequency

- disable

## Theoretical Basis

- The /usr/bin directory contains essential executable files for system commands. If the permissions are changed, it may prevent these commands from executing, potentially impacting the system.


## Risk Items

- Functionality Unavailable


## Audit Method

- Run the following command on the specified files to verify that Uid and Gid are both 0/root, and the permissions are 755. Here we use the users file as an example:

```bash
stat /usr/bin/users
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
```


## Remediation

- If it is detected that the file permissions in the /usr/bin directory have been changed, log in to the server as the root user and restore the permissions. Audit this change.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None