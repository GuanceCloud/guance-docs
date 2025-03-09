# 0093-vsftpd-uninstalled-vsftpd Installed

---

## Rule ID

- 0093-vsftpd-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- FTP (File Transfer Protocol) is a traditional and widely used standard tool for transferring files between servers and clients over a network, especially in cases where authentication is not required (allowing anonymous users to connect to the server).


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- FTP does not protect the confidentiality of data or authentication credentials. If file transfer is necessary, it is recommended to use SFTP. Unless running as an FTP server is required (e.g., allowing anonymous downloads), it is recommended to remove this package to reduce potential attack surfaces.
> Note: There are other FTP servers that should be removed if they are not needed.


## Risk Items

- Increases the risk of being attacked


## Audit Method

- Run the following command to verify that the corresponding component is not installed:
```bash
# rpm -q vsftpd
package vsftpd is not installed
```


## Remediation

- Run the following command to remove the corresponding package:
```bash
# yum remove vsftpd
```


## Impact

- If you are using this server for FTP services, applications that rely on FTP may lose their ability to store data.


## Default Value

- None


## References

- None


## CIS Controls

- Version 7
  9.2 Ensure only approved ports, protocols, and services are running  
  Ensure that network ports, protocols, and services that are listening on each system have validated business needs before being allowed to run.