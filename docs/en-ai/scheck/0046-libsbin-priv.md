# 0046-libsbin-priv-/sbin Directory File Permissions Modified

---

## Rule ID

- 0046-libsbin-priv


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor whether the file permissions in the host's /sbin directory have been modified.


## Scan Frequency

- disable


## Theoretical Basis

- The /sbin directory contains essential system commands that are critical for system operation. If the permissions change, it may prevent these commands from executing properly, impacting the system.


## Risk Items

- Function Unavailability


## Audit Method

- Run the following command on the specified files to verify that Uid and Gid are both 0/root and the permissions are 755. For example, using the ss file:

```bash
stat /usr/sbin/ss
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
```


## Remediation

- If a permission change is detected in the /sbin directory, log in as the root user and restore the permissions. Also, audit this change.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None