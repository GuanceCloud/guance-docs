# 0062-shm-noexec-/dev/shm Partition Does Not Have the noexec Option Set
---

## Rule ID

- 0062-shm-noexec


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- The noexec mount option specifies that the file system cannot contain executable binary files.
>

- Note: /dev/shm is automatically mounted by systemd. However, even if /dev/shm has been mounted at startup, it still needs to add mount options in /etc/fstab.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Setting this option on a file system will prevent users from executing programs from shared memory.
    >
    >   This can prevent users from introducing potentially malicious software onto the system



## Risk Items


- Hacker penetration



- Data leakage



- Mining risk



- Botnet risk



## Audit Method
- Run the following command to check if the noexec option is set:

```bash
# mount | grep -E "\s/dev/shm\s" | grep -v noexec
Nothing should be returned
```



## Remediation
- Edit the /etc/fstab file and add noexec to the fourth field of the /dev/shm partition mount options. For more information, see the fstab(5) manual page.
Remount /dev/shm with the following command:
```bash
# mount -o remount,noexec,nodev,nosuid /dev/shm
```



## Impact


- None




## Default Value


- None




## References


## CIS Controls


- Version 7

> 2.6 Handle Unapproved Software
>
> Ensure unauthorized software is removed or directories are updated promptly
>
> 13 Data Protection
>
> Data protection