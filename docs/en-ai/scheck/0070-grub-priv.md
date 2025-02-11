# 0070-grub-priv - Ensure GRUB bootloader configuration file permissions are set to (-rw-------)
---

## Rule ID

- 0070-grub-priv


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- GRUB is a multi-operating system boot loader from the GNU project. It is an implementation of the multiboot specification, allowing users to have multiple operating systems on their computer and choose which one to run during system startup. GRUB can be used to select different kernels on the operating system partition or pass boot parameters to these kernels.


## Scan Frequency

- disable

## Theoretical Basis

- The GRUB configuration file contains information about boot settings as well as passwords for unlocking boot options. The grub2 configuration is typically stored in `/boot/grub2/grub.cfg`.



## Risk Items

- Exploitation by hackers to gain unauthorized access to the system



## Audit Method

- Run the following command and verify that Uid and Gid are both 0/root, and Access does not grant permissions to group or others:

``` bash
stat /boot/grub2/grub.cfg 
Access: (0600/-rw-------)
Uid: ( 0/root)
Gid: ( 0/root)
```



## Remediation

- Run the following commands to set the ownership and permissions of the GRUB configuration:

``` bash
chown root:root /boot/grub2/grub.cfg
chmod 600 /boot/grub2/grub.cfg
```



## Impact

- After setting the permissions, only the superuser can read this file.



## Default Values

- By default, the permissions are set to root:root -rw-------



## References

- None



## CIS Controls

- Version 7
  5.1 Establish Secure Configurations 
  Maintain documented, standard security configuration standards for all authorized operating systems and software.