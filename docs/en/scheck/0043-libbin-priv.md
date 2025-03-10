# 0043-libbin-priv-/bin Directory File Permissions Modified

---

## Rule ID

- 0043-libbin-priv


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor whether the file permissions in the host's /bin directory have been modified.


## Scan Frequency

- disable


## Theoretical Basis

- The /bin directory contains executable files for critical system commands. If permissions change, it may prevent commands from executing, affecting the system.


## Risk Items

- Function Unavailability


## Audit Method

- Run the following command on the specified file to verify that the Uid and Gid are both 0/root and the permissions are 755. For example, using the users file:

```bash
stat /bin/users
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
```


## Remediation

- If a permission change is detected in the /bin directory, log in as the root user and restore the permissions. Also, audit this change.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None