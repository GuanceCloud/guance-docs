# 0046-libsbin-priv-/sbin Directory File Permissions Modified
---

## Rule ID

- 0046-libsbin-priv


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor whether the file permissions in the host's /sbin directory have been modified.


## Scan Frequency

- Disabled


## Theoretical Basis

- The /sbin directory contains critical system executable files. If the permissions change, it may prevent commands from executing and impact the system.


## Risk Items

- Function Unavailable


## Audit Method

- Run the following command on the specified file to verify that Uid and Gid are both 0/root, and the permissions are 755. Here, we use the `ss` file as an example:

```bash
stat /usr/sbin/ss
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
```


## Remediation

- If it is detected that file permissions in the /sbin directory have changed, log in to the server as the root user to restore the permissions and audit this change.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None