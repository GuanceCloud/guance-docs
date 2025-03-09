# Ensure Address Space Layout Randomization (ASLR) is Enabled
---

## Rule ID

- 0073-addressspac-randomization-enable


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Address Space Layout Randomization (ASLR) is a vulnerability mitigation technique that randomizes the address space of critical data regions within a process.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Randomizing the placement of virtual memory regions makes memory page attacks more difficult because memory locations will continuously change.
>






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

``` bash
kernel.randomize_va_space = 2
```
Run the following command to set the active kernel parameters:
``` bash
sysctl -w kernel.randomize_va_space=2
```



## Impact


- None




## Default Value


- None




## References


- None



## CIS Control


- Version 7
>   8.3 Enable Operating System Anti-Attack Features / Deploy Anti-Attack Technologies
    Enable anti-attack features available in the operating system, such as Data Execution Prevention (DEP) or Address Space Layout Randomization (ASLR), or deploy appropriate toolkits that can be configured to apply protection to a broader set of applications and executables.