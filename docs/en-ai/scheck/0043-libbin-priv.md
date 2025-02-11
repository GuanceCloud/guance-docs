# 0043-libbin-priv-/bin Directory File Permissions Modified
---

## Rule ID

- 0043-libbin-priv


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor whether the file permissions in the host's /bin directory have been modified.


## Scan Frequency

- Disabled


## Theoretical Basis

- The /bin directory contains critical system command executables. If the permissions change, it may prevent commands from executing properly, potentially impacting the system.


## Risk Items

- Functionality Unavailable


## Audit Method

- Run the following command on the specified file to verify that the Uid and Gid are both 0/root and the permissions are 755. For example, using the users file:

```bash
stat /bin/users
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
```


## Remediation

- If a change in file permissions under the /bin directory is detected, log in to the server as the root user, restore the permissions, and audit the change.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None