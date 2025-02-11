# 0016-resolv-resolv Modified
---

## Rule ID

- 0016-resolv


## Category

- System


## Level

- Warning


## Compatible Versions

- Linux


## Description

- Monitoring of the host's resolv configuration being modified.


## Scan Frequency

- Disabled


## Theoretical Basis

- `/etc/resolv.conf` is a DNS client configuration file used to set the IP addresses of DNS servers and DNS domain names. It also includes the domain name search order for the host. This file is used by the resolver (a library that resolves hostnames to IP addresses). Its format is simple, with each line starting with a keyword followed by one or more parameters separated by spaces. If this file is illegally modified, it can cause service unavailability or DNS resolution failure.


## Risk Items

- Hacker Penetration
- Data Leakage
- Network Security
- Mining Risk
- Botnet Risk


## Audit Method

- Verify whether `/etc/resolv.conf` has been illegally modified. You can use the following command to check:

```bash
ls -l /etc/resolv.conf
```


## Remediation

- If `/etc/resolv.conf` has been illegally modified, carefully inspect the host environment for signs of intrusion and change the host user passwords.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None