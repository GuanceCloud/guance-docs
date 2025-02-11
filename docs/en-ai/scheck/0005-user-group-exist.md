# 0005-user-group-exist-Host /etc/group Not Exist
---

## Rule ID

- 0005-user-group-exist


## Category

- System


## Severity

- Critical


## Compatible Versions

- Linux


## Description

- Monitor whether the host's `/etc/group` file exists.

## Scan Frequency

- 1 */5 * * *

## Theoretical Basis

- In Linux, each user has a corresponding record line in the `/etc/group` file, which records some basic attributes of the user. System administrators often modify this file to manage users. Deleting `/etc/group` can cause the host to be unable to log in, which is considered malicious damage.


## Risk Items

- Hacker Penetration
- Data Leakage


## Audit Method

- Verify whether the host's `/etc/group` file exists. You can use the following command to verify:

```bash
ls /etc/group
```

## Remediation

- If `/etc/group` was deleted but the system has not been restarted, you can execute the following commands to remediate:
```bash
cp /etc/group.bak /etc/group
```
If the system was shut down after deleting the file, when you try to boot it, you may find that you cannot log in.

In the GRUB bootloader, press `e` to enter edit mode, change `ro` to `rw rd.break` on the `linux16` line.

Press `ctrl+x` to execute.

After entering single-user mode, remount the root filesystem and copy the backup file:
```bash
chroot /sysroot
cp /etc/group.bak /etc/group
```

Since the copied file's security context does not match the current directory, you need to disable SELinux:
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

- [Emergency Response for Hacker Intrusion (Unofficial)](https://www.sohu.com/a/236820450_99899618)
- [A Real Case Study of Mining Intrusion Analysis (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)

## CIS Controls

- None