# Scheck Version History

## 1.0.8 (2022/03/11)
### Release Notes

Script related:
  None

New features:

- Added scheck [System Script Blacklist](scheck-configure.md#how-to-disable-system-rules)

## 1.0.7 (2021/12/7)

### Release Notes

Code related

- Added 14 Nginx inspection rules
- Fixed errors in the descriptions of some manifest files
- Added an interval duration field to the `luastatus` command
- Developer mode, based on version 1.0.6, adds functionality: all rules are unified to run every five minutes. Log level is automatically reduced to `debug`

## 1.0.6 (2021/11/19)

### Release Notes

Code related
- Reports version and input information when sending data to DataKit
- Added `readme-en`, available for download and compilation from [GitHub](https://github.com/DataFlux-cn/scheck)
- Added documentation on [How to Use Lua Standard Library and Lua-lib](lualib.md)
- Fixed bugs in some rules
- Added developer mode to view runtime memory, CPU, and Lua cache status. This feature is off by default and will be further improved. Refer to the documentation: [How to Use Developer Mode to View Cache](cachedev.md)

## 1.0.5 (2021/11/03)

### Release Notes

Code related
- Added container-related [go-openlib](funcs.md#container-related-functions) interface functions
- Added 21 container-related script rules
- Optimized unit tests: use mocks for testing when specific environmental requirements are needed

Script related:
- Added [Kubernetes-related scripts: kube-apiserver, kubelet, etcd detection scripts](0400-k8s-node-conf-priv.md)
- Added [Docker-related scripts: container start commands, container list detection scripts](0310-docker-runlike.md)

----

## 1.0.4 (2021/10/14)

### Release Notes

- Fixed file permission issues with version and other files after scheck installation
- Fixed rule execution anomalies caused by DataKit's inability to report information
- Adjusted the way Lua references Golang libraries [usage](funcs.md)
- Changed the `-luastatus` command to no longer generate local HTML or MD files
- Moved data type files (password library) to the `data` directory under the current directory, preventing them from being overwritten during process restarts
- Added user [rule ID specification](custom-how-to.md#lua-rule-naming-specification) checks
- Added methods to delete cache and global cache [functions](funcs.md#del_cache)
- Optimized memory usage
- Improved smoothness of Lua rule execution

Security monitoring script related:

- Added [crontab detection script](0142-crontab-add.md)
- [Increased user detection frequency](0001-user-add.md) (from polling to real-time monitoring)

----

## 1.0.3 (2021/09/27)

### Release Notes

- Fixed fsnotify manifest file errors.

----

## 1.0.2 (2021/09/23)

### Release Notes

This release made significant adjustments to Scheck, mainly focusing on performance and stability.

- Memory performance optimization
- Adjusted file listening detection method, replacing the previous file caching form
- Added a persistent running category for rule scripts, used primarily for monitoring scenarios such as [file changes](funcs.md#sc_path_watch)
- Added Lua script execution timeout control
- Added Lua runtime [statistics](scheck-how-to.md#c5609495)
- Added `-check` [command-line functionality](scheck-how-to.md#c5609495)

----

## v1.0.0-67-gd445240 (2021/08/27)
### Release Notes

Script related:

- Added multiple container detection scripts

New features:

- Modified scheck configuration
- Added Alibaba Cloud log integration
- Added custom rule path and user-defined lua.libs path
- Added cgroup functionality
- Added automatic update functionality for user-defined rule scripts
- Added PowerShell installation for Windows and shell installation for Linux environments
- Sends info messages on the first service startup
- Output supports multi-endpoint message delivery

Optimization:

- CPU performance optimization
- Restructured Yuque documentation

----

## v1.0.1-67-gd445240 (2021/06/18)
### Release Notes

Script related:

- Added MySQL weak password scanning

New features:

- Added 3 new func

----

## v1.0.1-62-g7715dc6
### Release Notes

This release standardized the naming of Security Checker operations to scheck and fixed related bugs.

Script related:

- Modified the spacing in desc content
- Adjusted script execution frequency

New features:

- Added an MD5 option for scheck itself

### Bug Fixes

- Optimized script execution performance

%!(EXTRA string=1.0.7-7-g251eead, string=2023-04-06 11:17:57)