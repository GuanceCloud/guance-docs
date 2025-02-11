# 0068-sudo-use-pty - sudo command not using pty
---

## Rule ID

- 0068-sudo-use-pty


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- An attacker can use sudo to run malicious programs (such as viruses or malware), which will fork and retain background processes on the user's terminal device, even after the main program has completed execution.
>   
>   To prevent this, you can configure sudo to run other commands only from a pseudo-pty using the use_pty parameter, regardless of whether I/O logging is enabled.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- An attacker can use sudo to run a malicious program that restarts a background process, which remains active even after the main program has finished executing.
>   This situation can be mitigated by configuring sudo to run other commands only from a pseudo-pty.



## Risk Items


- Exploitation by hackers using sudo to run malicious programs



## Audit Method
- Verify that sudo runs other commands only from a pseudo-pty by running the following command:

``` bash
grep -Ei "^\s*Defaults\s+([^#]\S+,\s*)?use_pty\b" /etc/sudoers /etc/sudoers.d/*

Defaults use_pty
```



## Remediation
- Edit the file /etc/sudoers using visudo or visudo -f <PATH TO FILE> and add the following line: Defaults use_pty

``` bash
Defaults use_pty
```



## Impact


- Configuring sudo to use pty can effectively prevent hackers from exploiting sudo to run malicious programs.




## Default Value


- By default, it is not configured.




## References


- [5 Tips for Setting 'sudo' in Linux (Unofficial)](https://jingyan.baidu.com/article/47a29f24753254c0142399df.html) 



## CIS Controls


- Version 7
>   4 Controlled Use of Administrative Privileges 
>
>   Controlled Use of Administrative Privileges