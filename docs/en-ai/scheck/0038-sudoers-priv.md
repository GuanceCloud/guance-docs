# 0038-sudoers-priv-sudoers File Permissions Change Detection
---

## Rule ID

- 0038-sudoers-priv


## Category

- System


## Severity

- Critical


## Compatible Versions

- Linux


## Description

- Monitor whether the permissions of the host file `/etc/sudoers` have been modified.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- The host file `/etc/sudoers` allows specific users to execute a wide variety of commands with root privileges without needing the root password.


## Risk Items

- Function Unavailability


## Audit Method

- Run the following command and verify that Uid and Gid are both 0/root, and Access does not grant permissions to groups or others:

```bash
stat /etc/sudoers
Access: (0440/-r--r-----) Uid: ( 0/root) Gid: ( 0/root)
```


## Remediation

- If it is detected that the permissions of the `/etc/sudoers` file have changed, log in to the server as the root user and restore the permissions. Audit this change.


## Impact

- Function Unavailability


## Default Value

- None


## References

- [Emergency Response and Investigation Ideas for Hacker Intrusions (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [A Real Case of Mining Malware Intrusion Investigation and Analysis (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)


## CIS Controls

- None