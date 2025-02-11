# 0018-hosts-hosts Modified
---

## Rule ID

- 0018-hosts


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitoring the hosts file on the host has been modified.


## Scan Frequency

- Disable

## Theoretical Basis

- The hosts file is a file in Linux systems responsible for the quick resolution of IP addresses to domain names, saved in ASCII format under the “/etc” directory with the filename “hosts”. The hosts file contains mappings between IP addresses and hostnames, including aliases for hostnames. In the absence of a domain name server, all network programs on the system resolve IP addresses corresponding to hostnames by querying this file; otherwise, DNS services are required. Commonly used domain names and IP address mappings can be added to the hosts file for fast and convenient access.
  Malicious modifications to the hosts file can cause service unavailability.



## Risk Items

- Service Unavailability



## Audit Method

- Verify if the /etc/hosts file has been illegally modified. You can use the following command to verify:

```bash
ls -l /etc/hosts
```



## Remediation

- If the /etc/hosts file has been illegally modified, carefully examine the host environment for signs of intrusion and change the host user passwords.



## Impact

- None



## Default Value

- None



## References

- None



## CIS Controls

- None