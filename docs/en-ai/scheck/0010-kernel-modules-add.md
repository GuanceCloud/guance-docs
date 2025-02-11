# 0010-kernel-modules-add-Kernel Modules Added
---

## Rule ID

- 0010-kernel-modules-add


## Category

- System


## Level

- Warn


## Compatible Versions


- Linux




## Description


- Monitor the addition of kernel modules on the host



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- The kernel is composed of a series of programs, including interrupt service routines responsible for responding to interrupts, schedulers responsible for managing multiple processes to share processor time, memory management programs responsible for managing address spaces, network services, and system services for inter-process communication. The kernel manages the system's hardware devices. Adding kernel modules can cause instability and security risks in system services, with the potential for malicious code injection.



## Risk Items


- Hacker Penetration

- Data Leakage

- Network Security

- Mining Risk

- Botnet Risk



## Audit Method
- Verify if kernel modules have been added on the host. You can run the following command to verify:

```bash
lsmod
```



## Remediation
- If kernel modules have been added to the host, you can run the following commands to check and remove the modules:
> ```bash
> lsmod
> rmmod hello
> ```
> Please carefully inspect the host environment for signs of intrusion and change the host user password.



## Impact


- None




## Default Value


- None




## References


- [Emergency Response and Investigation Process for Hacker Intrusion (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [Real Incident Analysis of Mining Intrusion (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS Controls


- None