# 0067-sudo-install-sudo Not Installed
---

## Rule ID

- 0067-sudo-install


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- Sudo is a system management command in Linux that allows system administrators to grant regular users the ability to execute some or all root commands, such as halt, reboot, su, etc. This reduces the login and management time for the root user while enhancing security. Sudo is not a shell replacement; it operates on a per-command basis.



- Note: visudo edits the sudoers file in a secure manner similar to vipw (8). Visudo locks the sudoers file to prevent multiple simultaneous edits, provides basic integrity checks, and checks for parsing errors. If the current user is editing the sudoers file, you will receive a prompt message to try again later.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Better distribution of user permissions, reducing root user management operations, thereby improving system security.



## Risk Items


- Increased root management operations significantly reduce system security.



## Audit Method
- Verify if sudo is installed. Run the following command:

``` bash
# rpm -q sudo
sudo-<VERSION>
```



## Remediation
- Run the following command to install sudo.

``` bash
# yum install sudo
```



## Impact


- After installation, business permissions can be granted to regular users based on business needs, minimizing root user-related operations.




## Default Value


- By default, sudo is installed.




## References


- None



## CIS Controls


- Version 7
    >   4 Controlled Use of Administrative Privileges
    >
    >   Controlled Use of Administrative Privileges