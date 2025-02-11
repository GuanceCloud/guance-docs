# 0069-sudo-logfile-sudo Log Not Configured or Deleted
---

## Rule ID

- 0069-sudo-logfile


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- Sudo can use a custom log file to record the commands executed by each user.
>   Note: visudo edits the sudoers file in a secure manner similar to vipw (8). visudo locks the sudoers file to prevent multiple simultaneous edits, provides basic integrity checks, and checks for parsing errors. If the current user is editing the sudoers file, you will receive a prompt message to try again later.



## Scan Frequency
- Disable

## Theoretical Basis


- Used to record commands executed by users






## Risk Items


- Unable to identify which user executed illegal commands



## Audit Method
- Verify whether sudo has configured a custom log file. Run the following command:

``` bash
grep -Ei "^\s*Defaults\s+([^#;]+,\s*)?logfile\s*=\s*(")?[^#;]+(")?" /etc/sudoers
or
grep -Ei '^\s*Defaults\s+([^#;]+,\s*)?logfile\s*=\s*(")?[^#;]+(")?' /etc/sudoers.d/*
# It should output the following information. If not, it is recommended to add the sudo.log configuration
logfile ="/var/log/sudo.log"
```



## Remediation
- Use visudo or visudo -f <PATH TO FILE> to edit the file /etc/sudoers

``` bash
logfile="/var/log/sudo.log"
```



## Impact


- After configuring the sudo log, detailed records of commands executed by users, including execution time, login time, and login points, can be viewed.




## Default Value


- By default, it is not configured




## References


- [sudo Command Usage and Log Management (Unofficial)](https://blog.51cto.com/lifeng/976879) 



## CIS Controls


- Version 7
   6.3 Enable Detailed Logging
   Enable system logging to include detailed information such as an event source, date, user, timestamp, source addresses, destination addresses, and other useful elements.