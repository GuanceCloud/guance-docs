# 0029-fstab-exist-fstab has been deleted
---

## Rule ID

- 0029-fstab-exist


## Category

- system


## Level

- critical


## Compatible Versions

- Linux


## Description

- Monitor whether the /etc/fstab file on the host exists.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- The file /etc/fstab contains filesystem information for the system. If /etc/fstab is deleted, it can cause the host to fail to boot.


## Risk Items

- Service unavailability


## Audit Method

- Verify the existence of /etc/fstab on the host. You can execute the following command to verify:

```bash
ls /etc/fstab
```


## Remediation

- If /etc/fstab has been deleted, please execute the following commands:

```bash
# blkid
/dev/sda1: UUID="a8fbf99f-407e-4f33-86c4-a983349aaf62" TYPE="xfs"
/dev/sda2: UUID="wB8keG-qwiy-ZAID-zW7M-tZfQ-0mR2-TiB3VD" TYPE="LVM2_member"
/dev/mapper/CentOS-root: UUID="280ae35c-e119-478c-b762-326a356f25e0" TYPE="xfs"
/dev/mapper/CentOS-swap: UUID="6f9182c7-9794-41d3-b01c-825c3274a964" TYPE="swap"
# touch /etc/fstab
# vim /etc/fstab
/dev/mapper/CentOS-root /                       xfs     defaults        0 0
UUID=a8fbf99f-407e-4f33-86c4-a983349aaf62 /boot                   xfs     defaults        0 0
# reboot
```


## Impact

- None


## Default Value

- None


## References

- [Emergency Response and Investigation Ideas for Hacker Intrusions (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [Real Case Analysis of a Mining Intrusion Investigation (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)


## CIS Controls

- None