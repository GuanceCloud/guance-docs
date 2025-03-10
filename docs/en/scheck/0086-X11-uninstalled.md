# 0086-X11-uninstalled-X11 Uninstalled
---

## Rule ID

- 0086-X11-uninstalled


## Category

- system


## Level

- warn


## Compatible Versions

- Linux


## Description

- The X Windows system provides a graphical user interface (GUI), where users can have multiple windows to run programs and various add-ons. The X Windows system is typically used on workstations for user login, but it is not suitable for servers where users typically do not log in.


## Scan Frequency

- 0 */30 * * *


## Theoretical Basis

- Unless your organization specifically requires access to graphical login via XWindows, remove it to reduce the potential attack surface.


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

- Many Linux systems run applications that require the Java runtime. Some Linux Java packages depend on specific X Windows xorg-x11 fonts. One solution to avoid this dependency is to use "headless" Java packages for specific Java runtimes.


## Default Value

- None


## References

- None


## CIS Controls

- Version 7
    2.6 Address Unauthorized Software
    Ensure unauthorized software is removed or inventory is updated promptly.

- 9.2 Ensure Only Approved Ports, Protocols, and Services Are Running
    Ensure only network ports, protocols, and services with validated business needs are running on each system.