# 0005-user-group-exist-Host /etc/group Not Exist
---

## Rule ID

- 0005-user-group-exist


## Category

- system


## Level

- critical


## Compatible Versions

- Linux


## Description

- Monitor whether the host /etc/group exists.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- In Linux, each user has a corresponding record line in the /etc/group file, which records some basic attributes of this user. System administrators frequently modify this file to manage users. Deleting /etc/group can cause the host to fail to log in, indicating malicious damage.


## Risk Items

- Hacker penetration

- Data leakage


## Audit Method

- Verify if the host /etc/group exists. You can use the following command for verification:

```bash
ls /etc/group
```


## Remediation

- If /etc/group is deleted without restarting the system, you can execute the following command to remediate:
```bash
cp /etc/group /etc/group
```
If the system was shut down after deleting the file and then turned on again, it will not be accessible.
>
>
During GRUB boot, press e to enter edit mode, change ro to rw rd.break on the linux16 line.
>
>
Press ctrl+x to execute.
>
>
After entering single-user mode, modify the root path and copy the init program.
>
>     ```bash
>     chroot /sysroot
>
>     cp /etc/group /etc/group
>     ```
>
>
Since the security context of the copied file does not match the current directory, we need to disable SELinux.
>
>     ```bash
>     vim /etc/sysconfig/selinux
>
>     selinux = disabled
>     ```
>
>
Exit twice and restart the host to restore normal operation.


## Impact

- None


## Default Value

- None


## References

- [Emergency Response and Investigation of Hacker Intrusion (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [A Real Case of Mining Intrusion Investigation Analysis (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)


## CIS Controls

- None