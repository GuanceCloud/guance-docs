# 0008-hostname-Hostname has been modified
---

## Rule ID

- 0008-hostname


## Category

- system


## Level

- warn


## Compatible Versions


- Linux



- Windows




## Description


- Monitor changes in the hostname



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- In the Linux operating system, the hostname is a kernel variable that can be viewed using the `hostname` command. It can also be checked by running `cat /proc/sys/kernel/hostname`. If the hostname is set incorrectly, it may cause online services or applications to fail to access normally, and may even refuse to provide services. If the hostname is maliciously modified, it can affect the normal operation of the host system.



## Risk Items


- Application Denial of Service



## Audit Method
- Verify whether the hostname has been illegally modified. You can run the following command to verify:

```bash
hostname
```



## Remediation
- If the hostname has been illegally modified, use `hostnamectl set-hostname` to restore the hostname. Be sure to carefully inspect the host environment for any signs of intrusion and change the host user password.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Control


- None