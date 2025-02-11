# 0019-hosts-exist-hosts Deleted
---

## Rule ID

- 0019-hosts-exist


## Category

- System


## Level

- Critical


## Compatible Versions

- Linux




## Description


- Monitor whether the host `/etc/hosts` file exists



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- The hosts file is a file in Linux systems responsible for quick resolution of IP addresses to domain names, saved in ASCII format in the “/etc” directory with the filename “hosts”. 
  The hosts file contains mappings between IP addresses and hostnames, including aliases for hostnames. Without a domain name server, all network programs on the system resolve IP addresses corresponding to hostnames by querying this file; otherwise, DNS services are required. Commonly used domain names and IP address mappings can be added to the hosts file for faster and more convenient access.
  Malicious deletion of the hosts file can cause services to become unavailable.



## Risk Items


- Service Unavailability



## Audit Method
- Verify the host’s `/etc/hosts`. You can run the following command to verify:

```bash
ls /etc/hosts
```



## Remediation
- If `/etc/hosts` is deleted, execute the `touch /etc/hosts` command to recreate `/etc/hosts`.



## Impact


- None




## Default Value


- None




## References


- [Emergency Response Thoughts and Procedures for Hacker Intrusion (Unofficial)](https://www.sohu.com/a/236820450_99899618)



- [A Real Incident Analysis of Mining and Intrusion Investigation (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS Controls


- None