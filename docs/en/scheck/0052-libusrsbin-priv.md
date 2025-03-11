# 0052-libusrsbin-priv-/usr/sbin Directory File Permissions Modified

---

## Rule ID

- 0052-libusrsbin-priv


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor whether the file permissions in the /usr/sbin directory on the host have been modified.


## Scan Frequency

- disable

## Theoretical Basis

- The /usr/sbin directory contains executable files of critical system commands. If permissions change, it may prevent commands from executing, affecting the system.


## Risk Items

- Function Unavailability


## Audit Method

- Run the following command on the specified file to verify that Uid and Gid are both 0/root and the permission is 755. For example, using the `ss` file:

```bash
stat /usr/sbin/users
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
```


## Remediation

- If it is detected that the file permissions in the /usr/sbin directory have changed, log in to the server as the root user and restore the permissions, then audit this change.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None