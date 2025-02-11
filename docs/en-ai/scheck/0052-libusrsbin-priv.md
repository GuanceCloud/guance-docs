# 0052-libusrsbin-priv-/usr/sbin Directory File Permissions Modified
---

## Rule ID

- 0052-libusrsbin-priv


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor whether the file permissions in the `/usr/sbin` directory have been modified.


## Scan Frequency

- Disable

## Theoretical Basis

- The `/usr/sbin` directory contains executable files for essential system commands. If the permissions change, it may prevent these commands from executing properly, potentially impacting the system.


## Risk Items

- Function Unavailability


## Audit Method

- Run the following command on the specified file to verify that the Uid and Gid are both 0/root, and the permissions are 755. Here we use the `users` file as an example:

```bash
stat /usr/sbin/users
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
```


## Remediation

- If it is detected that the file permissions in the `/usr/sbin` directory have been changed, log in to the server as the root user and restore the permissions. Also, audit this change.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None