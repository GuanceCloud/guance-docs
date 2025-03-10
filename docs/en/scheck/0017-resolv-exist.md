# 0017-resolv-exist-DNS resolv File Deleted
---

## Rule ID

- 0017-resolv-exist


## Category

- system


## Level

- critical


## Compatible Versions

- Linux


## Description

- Monitor whether `/etc/resolv.conf` exists on the host.

## Scan Frequency

- disable

## Theoretical Basis

- `/etc/resolv.conf` is a DNS client configuration file used to set the IP address of the DNS server and the DNS domain name. It also includes the domain name search order for the host. This file is used by the resolver (a library that resolves hostnames to IP addresses). Its format is simple, with each line starting with a keyword followed by one or more parameters separated by spaces. If this file is deleted, it can cause services to be unavailable or DNS resolution to fail.


## Risk Items

- Services Unavailable

## Audit Method

- Verify the existence of `/etc/resolv.conf` on the host. You can use the following command to check:

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

- [Emergency Response Steps and Procedures for Hacker Intrusion (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [A Real Incident Analysis of Mining Malware Intrusion (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)

## CIS Controls

- None