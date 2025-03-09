# 0018-hosts-hosts Modified
---

## Rule ID

- 0018-hosts


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor the modification of the hosts file on the host.

## Scan Frequency

- disable

## Theoretical Basis

- The hosts file is a file in Linux systems responsible for fast resolution between IP addresses and domain names, saved in ASCII format in the “/etc” directory with the filename “hosts”. The hosts file contains mappings between IP addresses and hostnames, including aliases for hostnames. Without a domain name server, all network programs on the system resolve IP addresses corresponding to hostnames by querying this file; otherwise, DNS services are required. Commonly used domain names and IP address mappings can be added to the hosts file for quick and convenient access. Malicious modifications to the hosts file can cause services to become unavailable.


## Risk Items

- Service unavailability


## Audit Method

- Verify whether the /etc/hosts file has been illegally modified. You can execute the following command to verify:

```bash
ls -l /etc/hosts
```

## Remediation

- If the /etc/hosts file has been illegally modified, carefully inspect the host environment to determine if it has been compromised and change the host user passwords.

## Impact

- None

## Default Value

- None

## References

- None

## CIS Controls

- None