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

- Monitor whether the file permissions in the /usr/bin directory on the host have been modified.


## Scan Frequency

- disable


## Theoretical Basis

- The /usr/bin directory contains executable files for essential system commands. If permissions change, it may prevent commands from executing and impact the system.


## Risk Items

- Function Unavailability


## Audit Method

- Run the following command on the specified file to verify that Uid and Gid are both 0/root, and the permissions are 755. For example, using the users file:

```bash
stat /usr/bin/users
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
```


## Remediation

- If a file permission in the /usr/bin directory has been changed, log in as the root user and restore the permissions. Audit this change.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None