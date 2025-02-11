# 0082-xinetd-uninstalled-xinetd Installed

---

## Rule ID

- 0082-xinetd-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

Extended Internet Daemon (xinetd) is an open-source super daemon that replaces the original inetd daemon. The xinetd daemon listens for known services and dispatches the appropriate daemons to correctly respond to service requests.


## Scan Frequency
- 0 */30 * * *


## Theoretical Basis

- If network services are not required, it is recommended to remove the package to reduce the system's attack surface.

- Note: If network services or services are required, ensure that any unnecessary services are stopped and disabled.


## Risk Items

- Data Leakage


## Audit Method
Run the following command to verify that the xinetd package is not installed:
```bash
# rpm -q xinetd
package xinetd is not installed
```


## Remediation
Run the following command to remove the xinetd package:
```bash
# yum remove xinetd
```


## Impact

- Services dependent on xinetd may encounter anomalies or process termination.


## Default Values



## References

- None


## CIS Controls

- Version 7
    2.6 Address Unauthorized Software
    Ensure unauthorized software is removed or inventory is updated in a timely manner.

- 9.2 Ensure Only Approved Ports, Protocols, and Services Are Running
    Ensure only network ports, protocols, and services with validated business needs are running on each system.