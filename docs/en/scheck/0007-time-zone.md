# 0007-time-zone-Host Time Zone Change
---

## Rule ID

- 0007-time-zone


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- Monitor the change in the host time zone.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis

- Time zone settings are one of the most important basic system configurations. If the time zone is set incorrectly, it may cause online services or applications to be inaccessible, and may even refuse to provide services. If the host's time zone is maliciously modified, it can affect the normal operation of the host system.


## Risk Items

- Application Denial of Service


## Audit Method

- Verify whether the host time zone has been illegally modified. You can execute the following command for verification:

```bash
timedatectl
```


## Remediation

- If the host time zone has been illegally modified, use `timedatectl set-timezone` to restore the host time zone. Be sure to carefully check the host environment for any signs of intrusion and change the host user passwords.


## Impact

- None


## Default Value

- None


## References

- None


## CIS Controls

- None