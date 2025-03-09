# 0016-resolv-resolv Modified
---

## Rule ID

- 0016-resolv


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor if the host's resolv configuration has been modified.


## Scan Frequency

- disable


## Theoretical Basis

- `/etc/resolv.conf` is a DNS client configuration file used to set the IP address of DNS servers and DNS domain names. It also includes the domain name search order for the host. This file is used by the resolver (a library that resolves hostnames to IP addresses). Its format is simple, with each line starting with a keyword followed by one or more parameters separated by spaces. If this file is illegally modified, it can cause service unavailability or DNS resolution failure.


## Risk Items

- Hacker penetration

- Data leakage

- Network security

- Mining risk

- Botnet risk


## Audit Method

- Verify whether `/etc/resolv.conf` on the host has been illegally modified. You can run the following command to check:

```bash
ls -l /etc/resolv.conf
```


## Remediation

- If `/etc/resolv.conf` on the host has been illegally modified, carefully inspect the host environment for signs of intrusion and change the host user passwords.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None