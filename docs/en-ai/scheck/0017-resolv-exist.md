# 0017-resolv-exist-DNS resolv 文件被删除
---

## Rule ID

- 0017-resolv-exist


## Category

- system


## Severity

- critical


## Compatible Versions


- Linux




## Description


- Monitor whether the file `/etc/resolv.conf` exists.



## Scan Frequency
- disable

## Theoretical Basis


- `/etc/resolv.conf` is a DNS client configuration file used to set the IP address of the DNS server and the DNS domain name. It also includes the host's domain search order. This file is used by the resolver (a library that resolves hostnames to IP addresses). Its format is simple, with each line starting with a keyword followed by one or more parameters separated by spaces. If this file is deleted, it can cause services to be unavailable or DNS resolution failures.




## Risk Items


- Services become unavailable



## Audit Method
- Verify the existence of `/etc/resolv.conf`. You can run the following command to verify:

```bash
ls /etc/resolv.conf
```



## Remediation
- If `/etc/resolv.conf` has been deleted, execute the `touch /etc/resolv.conf` command to recreate the file.



## Impact


- None




## Default Value


- None




## References


- [Emergency Response and Investigation Process for Hacker Intrusions (Unofficial)](https://www.sohu.com/a/236820450_99899618)



- [A Real Incident Analysis of Mining Malware Intrusion Investigation (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS Controls


- None