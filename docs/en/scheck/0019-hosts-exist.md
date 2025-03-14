# 0019-hosts-exist-hosts Deleted
---

## Rule ID

- 0019-hosts-exist


## Category

- system


## Severity

- critical


## Compatible Versions

- Linux


## Description

- Monitor whether the file /etc/hosts exists on the host.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- The hosts file is a file in Linux systems responsible for rapid resolution of IP addresses and domain names. It is stored in ASCII format under the “/etc” directory with the filename “hosts”. The hosts file contains mappings between IP addresses and hostnames, including aliases for hostnames. Without a domain name server, all network programs on the system resolve the IP address corresponding to a hostname by querying this file; otherwise, DNS services are required. Commonly used domain names and IP address mappings can be added to the hosts file for quick and convenient access. Malicious deletion of the hosts file can cause services to become unavailable.


## Risk Items

- Service unavailability


## Audit Method

- Verify the existence of /etc/hosts on the host. You can run the following command to verify:

```bash
ls /etc/hosts
```


## Remediation

- If /etc/hosts has been deleted, execute the `touch /etc/hosts` command to recreate /etc/hosts.


## Impact

- None


## Default Values

- None


## References

- [Emergency Response and Investigation Process for Hacker Intrusions (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [A Real Case Study of Mining Intrusion Investigation and Analysis (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)


## CIS Controls

- None