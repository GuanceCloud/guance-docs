# 0062-shm-noexec-/dev/shm Partition Does Not Have the noexec Option Set
---

## Rule ID

- 0062-shm-noexec


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- The noexec mount option specifies that the filesystem cannot contain executable binaries.
>
> Note: /dev/shm is automatically mounted by systemd. However, even if /dev/shm has been mounted at startup, it still needs to add mount options in /etc/fstab.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Setting this option on a filesystem will prevent users from executing programs from shared memory.
    >
    >   This can prevent users from introducing potentially malicious software into the system



## Risk Items


- Hacker Penetration

- Data Leakage

- Mining Risk

- Botnet Risk



## Audit Method
- Run the following command to check if the noexec option is set:

```bash
# mount | grep -E "\s/dev/shm\s" | grep -v noexec
Nothing should be returned
```



## Remediation
- Edit the /etc/fstab file and add noexec to the fourth field of the /dev/shm partition mount options.
For more information, see the fstab(5) manual page.
Run the following command to remount /dev/shm.
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

> 2.6 Address Unapproved Software
>
> Ensure unauthorized software is removed or directories are updated in a timely manner
>
> 13 Data Protection
>
> Data protection