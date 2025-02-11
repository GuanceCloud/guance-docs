# 0027-ssh-tunnel-Existence of SSH Tunnel
---

## Rule ID

- 0027-ssh-tunnel


## Category

- Network


## Severity

- Critical


## Compatible Versions


- Linux




## Description


- Monitor whether the host has an SSH tunnel



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- An SSH tunnel, or SSH port forwarding, establishes a secure connection between an SSH client and an SSH server. Network data is forwarded through this tunnel to a specified port for communication. SSH tunnels automatically provide encryption and decryption services, ensuring secure data transmission. If unknown SSH tunnels exist on the host, there is a risk of data leakage, so this should be within the audit scope.



## Risk Items


- Hacker Penetration

- Data Leakage

- Network Security

- Mining Risk

- Botnet Risk



## Audit Method
- Verify the host process list to check if there is a process with `cmdline` as `sshd: root@notty`. You can use the following command to verify:

```bash
ps -ef | grep -v grep| grep "sshd: root@notty"
```



## Remediation
- If there is an unknown process with `cmdline` as `sshd: root@notty`, execute `kill -9 <tunnel_pid>` to terminate the risky process.



## Impact


- None




## Default Value


- By default, processes with `cmdline` as `sshd: root@notty` are not allowed to exist.




## References


- [Emergency Response and Investigation Process for Hacking (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [Analysis of a Real Incident Involving Mining Malware Intrusion (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS Controls


- None