# 0073-address-space-randomization-enable - Ensure Address Space Layout Randomization (ASLR) is Enabled
---

## Rule ID

- 0073-address-space-randomization-enable


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Address Space Layout Randomization (ASLR) is a security feature that mitigates vulnerabilities by randomizing the memory address space of key data regions in a process.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- Randomly placing virtual memory regions makes it more difficult for attacks that write to memory pages, as the memory locations will continuously change.


## Risk Items

- Service Unavailability


## Audit Method

- Run the following commands and verify if the output matches:

```bash
# sysctl kernel.randomize_va_space
kernel.randomize_va_space = 2
# grep "kernel\.randomize_va_space" /etc/sysctl.conf /etc/sysctl.d/*
kernel.randomize_va_space = 2
```


## Remediation

- Add the following line to `/etc/security/limits.conf` or `/etc/security/limits.d/*` files:

```bash
kernel.randomize_va_space = 2
```
Run the following command to set the active kernel parameter:
```bash
sysctl -w kernel.randomize_va_space=2
```


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- Version 7
>   8.3 Enable Operating System Anti-Attack Features / Deploy Anti-Attack Technologies
    Enable anti-attack features available in the operating system, such as Data Execution Prevention (DEP) or Address Space Layout Randomization (ASLR), or deploy appropriate toolkits that can be configured to apply protection to a broader set of applications and executables.