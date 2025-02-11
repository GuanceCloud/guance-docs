# Lua Standard Library and Lua-Lib Support List
---
- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Operating System Support: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## Description
Scheck aims to provide a fully functional and easily integrated Lua sandbox environment that uses Golang, to meet the diverse needs and environments of users.
Therefore, we have referenced an excellent open-source Lua VM: [gopher-lua](https://github.com/yuin/gopher-lua), which uses the Lua 5.1 sandbox environment.

For security reasons, we have disabled some functions in the IO and OS modules of the Lua standard library and made corresponding supplements and extensions in lua-lib and go-openlib.

This document focuses on the usage and precautions of various libraries during Lua script development.

Lua scripts can reference libraries from three sources:

- Standard Library: Supports most libraries and functions.
- Lua-lib: Encapsulates some commonly used Lua function libraries for developers to call.
- Go-openlib: Developed using Golang and provides `file`, `system`, `net`, `utils`, etc. See: [func list](funcs.md)

## Standard Library
Disabled function list:

- All IO module functionalities are completely disabled.
- Disabled functions in the OS library: `exit`, `execute`, `remove`, `rename`, `setenv`, `setlocale`
- Available functions in the OS library: `clock`, `difftime`, `date`, `getenv`, `time`, `tmpname`

## Usage of Lua-lib in Scheck
File location: In the `ruls.d/libs` directory under the installation directory. Specific method documentation can be found in the corresponding files.

Method list:

- common
    - watcher(path, enum, func)
- directorymonitor
    - change(dir)     
    - add(dir)
    - del(dir)
    - priv_change(dir)
- filemonitor
    - check(file)
    - exist(file)
    - priv_change(file)
    - priv_fixedchange(file, mode)
    - priv_limit(file, mode_bits)
    - priv_root_ownership(file)
    - priv_ownership(file, user)
- kernelmonitor
    - module_isinstall(module_name, isInstalled)     
- mountflagmonitor
    - check(mountpath, mountflag, value)
- rpmmonitor
    - check(pck_name, switch)
- sysctlmonitor
    - check(param, switch)
    - check_many(params, switch)

### Example:

Using methods from lua-lib

```lua
local filemonitor = require("filemonitor")
local function check(file)
    if filemonitor.exist(file) then
        filemonitor.check(file) -- Monitor file and report changes
    end
end
check('/etc/shadow')
```