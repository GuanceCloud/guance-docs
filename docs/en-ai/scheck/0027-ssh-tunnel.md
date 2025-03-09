# 0027-ssh-tunnel-Exist
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


- Monitor whether the host has an SSH tunnel.



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- An SSH tunnel, or SSH port forwarding, establishes a tunnel between an SSH client and an SSH server, forwarding network data through this tunnel to a specified port to enable network communication. SSH tunnels automatically provide corresponding encryption and decryption services, ensuring the security of data transmission. If there is an unknown SSH tunnel on the host, the host may be at risk of data leakage, so it should be within the audit scope.



## Risk Items


- Hacker Penetration

- Data Leakage

- Network Security

- Mining Risk

- Botnet Risk



## Audit Method
- Verify the host process list to check if there is a process with `cmdline` as `sshd: root@notty`. You can execute the following command for verification:

```bash
ps -ef | grep -v grep| grep "sshd: root@notty"
```



## Remediation
- If there is an unknown process with `cmdline` as `sshd: root@notty`, please execute `kill -9 <tunnel_pid>` to terminate the dangerous process.



## Impact


- None




## Default Value


- By default, processes with `cmdline` as `sshd: root@notty` are not allowed.




## References


- [Emergency Response Thoughts and Procedures for Hacker Intrusion (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [Recording a Real Mining Intrusion Investigation Analysis (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS Controls


- None