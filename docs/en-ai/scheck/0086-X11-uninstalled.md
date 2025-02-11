# 0086-X11-uninstalled-X11 Installed

---

## Rule ID

- 0086-X11-uninstalled


## Category

- System


## Level

- Warn


## Compatible Versions

- Linux


## Description

- The X Windows system provides a graphical user interface (GUI), where users can have multiple windows to run programs and various additions. The X Windows system is typically used on workstations for user logins but is not suitable for servers where users usually do not log in.


## Scan Frequency
- 0 */30 * * *

## Theoretical Basis

- Unless your organization specifically requires access to graphical login via XWindows, it should be removed to reduce the potential attack surface.


## Risk Items

- Hacker penetration

- Data leakage


## Audit Method
- Run the following commands to verify that the x11 package is not installed:
```bash
# rpm -q x11
# rpm -qa xorg-x11-server*
```


## Remediation
- Run the following command to remove the xorg-x11-server packages:
```bash
# yum remove xorg-x11-server*
```


## Impact

- Many Linux systems run applications that require the Java Runtime Environment (JRE). Some Linux Java packages depend on specific X Windows xorg-x11 fonts. One solution to avoid this dependency is to use "headless" Java packages for specific Java runtimes.


## Default Value

- None


## References

- None


## CIS Controls

- Version 7
    2.6 Address unauthorized software
    Ensure unauthorized software is removed or inventories are updated in a timely manner.

- 9.2 Ensure only approved ports, protocols, and services are running
    Ensure only network ports, protocols, and services with validated business needs are running on each system.