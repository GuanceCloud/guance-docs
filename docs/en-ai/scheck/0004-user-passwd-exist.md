# 0004-user-passwd-exist-Host /etc/passwd Not Exist
---

## Rule ID

- 0004-user-passwd-exist


## Category

- System


## Level

- Critical


## Compatible Versions

- Linux


## Description

- Monitor whether the host's `/etc/passwd` file exists.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- In Linux, each user has a corresponding record line in the `/etc/passwd` file, which records some basic attributes of the user. System administrators frequently modify this file to manage users. Deleting `/etc/passwd` can cause the host to be unable to log in, which is considered malicious damage.


## Risk Items

- Hacker Penetration
- Data Leakage


## Audit Method

- Verify whether the host's `/etc/passwd` file exists. You can use the following command for verification:

```bash
ls /etc/passwd
```


## Remediation

- If `/etc/passwd` was deleted without restarting the system, you can execute the following commands to remediate:
```bash
cp /etc/passwd /etc/passwd
```
If the system was shut down after deleting the file, it will not boot properly.

When booting from GRUB, press `e` to enter edit mode and change `ro` to `rw rd.break` on the `linux16` line.

Press `ctrl+x` to execute.

After entering single-user mode, modify the root path and copy the init program:

```bash
chroot /sysroot
cp /etc/passwd /etc/passwd
```

Since the security context of the copied file does not match the current directory, we need to disable SELinux:

```bash
vim /etc/sysconfig/selinux
selinux = disabled
```

Exit twice and reboot the host to restore normal operation.


## Impact

- None


## Default Value

- None


## References

- [Emergency Response Thoughts and Procedures for Hacker Intrusion (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [A Real Incident of Mining Intrusion Investigation Analysis (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)


## CIS Controls

- None