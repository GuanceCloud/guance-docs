# 0034-ssh-keys-authorized_keys Public Key Differences
---

## Rule ID

- 0034-ssh-keys


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- Monitor changes in the authorized_keys public key file on the host.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- authorized_keys is a critical file for SSH passwordless login. If keys are maliciously added, it can lead to data breaches or hacker infiltration.


## Risk Items

- Hacker Infiltration
- Data Breach
- Network Security
- Mining Risk
- Compromised Machine Risk


## Audit Method

- Verify if the authorized_keys file on the host has been illegally modified. You can run the following command to check:

```bash
ls /root/.ssh/authorized_keys && ls /home/*/.ssh/authorized_keys
```


## Remediation

- If the authorized_keys file on the host has been illegally modified, carefully inspect the host environment to determine if there has been an intrusion and change the host user passwords.


## Impact

- None


## Default Value

- None


## References

- [Emergency Response and Investigation Process for Hacker Intrusion (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [Real Case Analysis of Mining Intrusion Investigation (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)


## CIS Controls

- None