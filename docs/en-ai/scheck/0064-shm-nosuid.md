# 0064-shm-nosuid-/dev/shm partition does not have the nosuid option set
---

## Rule ID

- 0064-shm-nosuid


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- The `nosuid` mount option specifies that the file system cannot contain setuid files.
>

- Note: `/dev/shm` is automatically mounted by systemd. However, even if `/dev/shm` has been mounted at startup, it still needs to add mount options in `/etc/fstab`.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Setting this option on a file system can prevent users from introducing privileged programs into the system and executing these programs as non-root users






## Risk Items


- Hacker penetration



- Data leakage



- Mining risk



- Botnet risk



## Audit Method
- Run the following command to check if the `nosuid` option is set:

```bash
# mount | grep -E "\s/dev/shm\s" | grep -v nosuid
Nothing should be returned
```



## Remediation
- Edit the `/etc/fstab` file and add `nosuid` to the fourth field of the `/dev/shm` partition mount options.
For more information, see the fstab(5) manual page.
Execute the following command to remount `/dev/shm`.
```bash
# mount -o remount,noexec,nodev,nosuid /dev/shm
```



## Impact


- None




## Default Value



## References


## CIS Control


- Version 7

> **5.1 Establish Secure Configurations**
>
> Maintain documented, standardized secure configuration standards for all authorized operating systems and software.
>
> **13 Data Protection**
>
> Data protection