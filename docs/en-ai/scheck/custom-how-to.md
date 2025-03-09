# User-defined Rule Files and Libraries
---

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## scheck Rule Introduction
*Lua Rule Introduction*:

The rule script consists of two files: a Lua file and a manifest file. Both files must exist simultaneously, and they must share the same prefix!

- `<rule-name>.lua`: This is the rule evaluation script implemented in Lua syntax. However, it cannot reference or use standard Lua libraries; only built-in Lua libraries and functions are available.

- `<rule-name>.manifest`: This is the rule manifest file. When the corresponding Lua script detects an issue (result == true), the manifest file contains a set of defined actions.

### Manifest File Field Description

| Manifest Field | Field Description | Configuration Description |
| :--- | :---- | :---- |
| id | Name | Named according to the functionality of the script with the ID rule |
| category | system | Multiple types can be used: system, os, net, file, db, docker... |
| level | Alert Level | Available types: debug, info, warn, error |
| title | Rule Title | Generally named based on the rule's functionality |
| desc | Description | Text to display and explain the rule's execution result |
| cron | Custom Execution Interval | Refer to: [Writing cron examples](#writing-cron) |
| disabled | Switch | Optional field: true or false |
| os_arch | Supported Operating Systems | Array type, options: "windows" "linux" |

scheck built-in rules are located in the `rules.d` directory under the installation path.

## User-defined Exclusive Rules and Lua Libraries
This example demonstrates a scheduled check for the hostname:
1. Write a Lua file
Create a file named `10001-hostname.lua` in the user directory `custom.rules.d`. The code is as follows:
``` lua
local function check()
    local cache_key = "hostname"
    local old = get_cache(cache_key) -- get_cache(key) is a built-in Go function used for Lua script caching, paired with set_cache(cache_key, current)
    if old == nil then
        local current = hostname()   -- Built-in Go function to retrieve the hostname
        set_cache(cache_key, current)
        return
    end
    local current = hostname()
    if old ~= current then
        trigger({Content=current})   -- Built-in Go function to send messages to datakit or local logs
        set_cache(cache_key, current)
    end
end
check()
```

> Note: scheck expects user-defined rule names to follow these [conventions](#lua-rule-naming-convention)

2. Write a manifest file
Create a file named `10001-hostname.manifest` in the user directory `custom.rules.d`. The content is as follows:

``` toml
id="10001-hostname"
category="system"
level="info"
title="Hostname Modified"
desc="Hostname modified to: {{.Content}}"
cron="0 */1 * * *"
# Switch
disabled=false
os_arch=["Linux"]

```

The current manifest configuration runs the rule every minute.

3. Restart the server

```shell
systemctl restart scheck.service
```

4. Send the message

After restarting the server, the script will run every minute. You can modify the hostname after one minute.

The static hostname is stored in `/etc/hostname`, which can be modified using the following command.

``` shell
hostnamectl set-hostname myclient1
```

5. Observation

Log in to the [<<< custom_key.brand_name >>>](https://www.guance.com) console -> Navigation Bar -> Security Check: View inspection information and find a message indicating that the hostname has been modified.

   ![](img/image-hostname.png)

## Rule Library
*Lua Library Files and User-defined Libraries*:

scheck's built-in Lua library files are located in the `rules.d/libs` directory under the installation path. The list of functions and API documentation can be viewed [online](funcs.md).

Library files do not require a manifest file. In Lua, you need to declare the library once when referencing it, for example, to reference `directorymonitor` from `libs`:

```lua
local directorymonitor = require("directorymonitor")

local function check()

directorymonitor.add("/usr/bin")
end
check()
```

> Note: Users should not modify scheck's built-in lib libraries and Lua rule files, as they will be overwritten during each installation update and service restart.

User-defined rules and library files can be placed in the `custom.rules.d` directory. If there are custom Lua libraries, they can be placed in the `custom.rules.d/libs` directory.

When pointing to other paths, simply modify the configuration file `scheck.conf`:

``` toml
[system]
  # ##(Required) Directory for storing detection scripts
  rule_dir = "/usr/local/scheck/rules.d"
  # ##Custom directory
  custom_dir = "/usr/local/scheck/custom.rules.d"
  # Optional User-defined Lua library directory, default is the libs directory under the user directory
  custom_rule_lib_dir = "/usr/local/scheck/custom.rules.d/libs"
```
Then restart the service.

-------------------
# Appendix

## Lua Rule Naming Convention

scheck's built-in Lua follows naming conventions based on types, with the ID prefix indicating the rule category.

User rule names should start with a number and must be greater than or equal to 10000, such as `10001-xxx.lua`.

scheck's built-in rule naming convention:

| ID Range | Rule Type |
| :---: | :----: |
| 0000 | System Cache |
| 0001~0199 | System |
| 0200~0299 | Network |
| 0300~0310 | Container-related |
| 0500~0510 | Database |
| 10000 and above | User-defined |

> User-defined Lua that does not follow the naming convention will fail to load.

## Setting the Cron Field in Manifest Files
Scheck supports two execution modes: interval-based and long-running. Fixed-time execution is currently not supported!

### Interval-based Cron
```shell
cron="* */1 * * *"  # Executes every minute
cron="* * */1 * *"  # Executes every hour
cron="* * * */1 *"  # Executes daily
```

### Long-running Rules

```shell
cron="disable" or cron=""  
```

Long-running rules will continuously execute, reporting messages within one second when triggered. For example, when a file changes.