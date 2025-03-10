# 0091-rpcbind-uninstalled-rpcbind is Installed
---

## Rule ID

- 0091-rpcbind-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- The rpcbind utility maps RPC services to the ports they listen on. When RPC processes start, they notify rpcbind, registering the ports they are listening on and the RPC program numbers they wish to provide services for. Client systems then contact rpcbind on the server with a specific RPC program number. The rpcbind service redirects the client to the correct port number so it can communicate with the requested service.
> Portmapper is an RPC service that always listens on TCP and UDP port 111 and is used to map other RPC services (such as NFS, nlockmgr, quotad, mountd, etc.) to their corresponding port numbers on the server. When a remote host makes an RPC call to this server, it first consults portmap to determine where the RPC server is listening.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- Small requests sent to the port mapper (~82 bytes) can generate large responses (7 to 28 times amplification), making it a suitable tool for DDoS attacks. If rpcbind is not required, it is recommended to remove the rpcbind package to reduce the attack surface of the system.
> Note: Many libvirt packages used by enterprise Linux virtualization and nfs-utils packages used by Network File System (NFS) depend on the rpcbind package. If rpcbind is required as a dependency, the rpcbind.service and rpcbind.socket services should be stopped and masked to reduce the attack surface of the system.


## Risk Items

- Increased risk of being attacked


## Audit Method

- Run the following command to verify that the component is not installed:
```bash
# rpm -q rpcbind
package rpcbind is not installed
```
If the corresponding package is required as a dependency: Run the following commands to verify if the risky services are masked:
```bash
# systemctl is-enabled rpcbind
masked
# systemctl is-enabled rpcbind.socket
masked
```


## Remediation

- Run the following command to remove the package:
```bash
# yum remove rpcbind
```
If the corresponding package is required as a dependency: Run the following commands to stop and mask the risky services:
```bash
# systemctl --now mask rpcbind
# systemctl --now mask rpcbind.socket
```


## Impact

- Processes dependent on this component may experience anomalies.


## Default Value

- None


## References

- None


## CIS Controls

- Version 7
>    9.2 Ensure only approved ports, protocols, and services are running  
>    Ensure that only network ports, protocols, and services with validated business needs are listening on each system.