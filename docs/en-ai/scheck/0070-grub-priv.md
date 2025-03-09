# 0070-grub-priv-Ensure the boot loader configuration is configured with permissions (-rw-------)
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


- GRUB is a multi-operating system boot program from the GNU project. GRUB is an implementation of the multiboot specification, which allows users to have multiple operating systems on their computer and choose which one to run at startup. GRUB can be used to select different kernels on the operating system partition or to pass boot parameters to these kernels.
>



## Scan Frequency
- disable

## Theoretical Basis


- The grub configuration file contains information about boot settings as well as passwords used to unlock boot options. The grub2 configuration is typically stored in /boot/grub2/ as grub.cfg.



## Risk Items


- Exploited by hackers to gain unauthorized access to the system



## Audit Method
- Run the following command and verify that Uid and Gid are both 0/root, and Access does not grant permissions to groups or others:
>

``` bash
stat /boot/grub2/grub.cfg Access: (0600/-rw-------)
Uid: ( 0/root)
Gid: ( 0/root)
```



## Remediation
- Run the following commands to set the ownership and permissions for the grub configuration:
>

``` bash
chown root:root /boot/grub2/grub.cfg
chmod 600 /boot/grub2/grub.cfg
```



## Impact


- After setting the permissions, only the superuser can read this file.




## Default Values


- By default, the permissions are root:root -rw-------




## References


- None



## CIS Controls


- Version 7
>   5.1 Establish Secure Configurations 
>
>   Maintain documented, standard security configuration standards for all authorized operating systems and software.