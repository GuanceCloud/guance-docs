# 0072-coredumps-restricted-Core Dumps Restricted
---

## Rule ID

- 0072-coredumps-restricted


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux




## Description


- Core dumps are memory images of executable programs, typically used to determine why a program terminated. They can also be used to collect confidential information from core files. The system provides the ability to set a soft limit for core dumps, but users can ignore this limit.



## Scan Frequency
- 0 */30 * * *

## Theory


- Setting a hard limit on core dumps prevents users from overriding the soft limit. If core dumps are necessary, consider setting limits for user groups. Additionally, setting the fs.suid_dumpable variable to 0 will prevent setuid programs from dumping the kernel.
>






## Risk Items


- Preventing users from overriding the soft limit



## Audit Method
- Run the following commands and verify that the output matches:

```bash
# grep -E "^\s*\*\s+hard\s+core" /etc/security/limits.conf /etc/security/limits.d/*
* hard core 0
# sysctl fs.suid_dumpable
fs.suid_dumpable = 0
# grep "fs\.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*
fs.suid_dumpable = 0
```

Run the following command to check if systemd-coredump is installed:

``` bash
# systemctl is-enabled coredump.service
```

If it returns enabled or disabled, then systemd-coredump is installed



## Remediation
- Add the following line to /etc/security/limits.conf or /etc/security/limits.d/* files:

``` bash
* hard core 0
```
Set the following parameter in /etc/sysctl.conf or /etc/sysctl.d/* files:
>

``` bash
fs.suid_dumpable = 0
```
Run the following command to set the active kernel parameters:
>

``` bash
# sysctl -w fs.suid_dumpable=0
```
If systemd-coredump is installed:
>
Edit /etc/systemd/coredump.conf and add/modify the following lines:

``` bash
Storage=none
ProcessSizeMax=0
```

> Run the command:

``` bash
systemctl daemon-reload
```



## Impact


- Setting a hard limit on core dumps prevents users from overriding the soft limit




## Default Value


- By default, there is no configuration.




## References


- None



## CIS Controls


- Version 7
>   5.1 Establish Secure Configurations 
>
>   Maintain documented, standard security configuration standards for all authorized operating systems and software.