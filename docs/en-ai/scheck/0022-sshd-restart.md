# 0022-sshd-restart-sshd Service Restarted
---

## Rule ID

- 0022-sshd-restart


## Category

- system


## Level

- critical


## Compatible Versions

- Linux


## Description

- Monitor the restart of the sshd service.


## Scan Frequency

- disable

## Theoretical Basis

- In Linux system operations, it is often necessary to connect to other hosts. The service for connecting to other hosts is openssh-server, which allows remote hosts to access the sshd service via the network. If the sshd service has been restarted, it may have been maliciously modified.

## Risk Items

- Hacker penetration

- Data leakage

- Network security

- Mining risk

- Botnet risk


## Audit Method

- Verify that the sshd service on the host has been restarted. You can run the following command to verify:

```bash
systemctl status sshd
```

## Remediation

- If the sshd service has been restarted, check all configuration files under /etc/ssh. Carefully examine the host environment to ensure it has not been compromised and change the host user passwords.

## Impact

- None

## Default Value

- None

## References

- None

## CIS Controls

- None