# 0010-kernel-modules-add-Kernel Modules Added
---

## Rule ID

- 0010-kernel-modules-add


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitor kernel modules being added to the host



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- The kernel consists of a series of programs, including interrupt service routines responsible for responding to interrupts, schedulers responsible for managing multiple processes to share processor time, memory management programs responsible for managing address spaces, network services, and inter-process communication system services. The kernel manages the system's hardware devices. Adding kernel modules can cause instability and security risks in system services, increasing the likelihood of malicious code injection.



## Risk Items


- Hacker penetration

- Data leakage

- Network security

- Mining risk

- Botnet risk



## Audit Method
- Verify that kernel modules have been added to the host. You can run the following command to verify:

```bash
lsmod
```



## Remediation
- If kernel modules have been added to the host, you can run the following commands to view and remove the modules:
> ```bash
> lsmod
> rmmod hello
> ```
> Carefully inspect the host environment for any signs of intrusion and change the host user passwords.



## Impact


- None




## Default Value


- None




## References


- [Emergency Response to Hacker Intrusion](https://www.sohu.com/a/236820450_99899618)

- [A Real Case Study of Mining Intrusion Analysis](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS Controls


- None