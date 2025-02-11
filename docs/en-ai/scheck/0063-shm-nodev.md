# 0063-shm-nodev-Ensure the nodev option is set on /dev/shm partition
---

## Rule ID

- 0063-shm-nodev


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- The nodev mount option specifies that the filesystem cannot contain special devices.



- Note: /dev/shm is automatically mounted by systemd. However, even if /dev/shm has been mounted at startup, it still needs to add mount options in /etc/fstab.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Since the /dev/shm filesystem is not intended to support devices, this option should be set to ensure users cannot attempt to create special devices in the /dev/shm partition.



## Risk Items


- Hacker penetration



- Data leakage



- Mining risk



- Botnet risk



## Audit Method
- Run the following command to check if the nodev option is set:

```bash
# mount | grep -E "\s/dev/shm\s" | grep -v nodev
Nothing should be returned
```



## Remediation
- Edit the /etc/fstab file and add nodev to the fourth field of the /dev/shm partition mount options.
For more information, see the fstab(5) manual page.
Run the following command to remount /dev/shm.
```bash
# mount -o remount,noexec,nodev,nosuid /dev/shm
```



## Impact


- None




## Default Value



## References


## CIS Controls


- Version 7
  **5.1 Establish Secure Configurations**
  Maintain documented, standardized secure configuration standards for all authorized operating systems and software.
  **13 Data Protection**
  Data protection