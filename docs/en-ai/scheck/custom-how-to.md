# User-Defined Rule Files and Libraries
---

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## Introduction to scheck Rules
*Introduction to Lua Rules*:

Rule scripts consist of two files: a Lua file and a manifest file. Both files must exist simultaneously, and they must share the same prefix!

- `<rule-name>.lua`: This is the rule evaluation script, implemented using Lua syntax. However, it cannot reference standard Lua libraries; only built-in Lua libraries and functions can be used.

- `<rule-name>.manifest`: This is the rule manifest file. When the corresponding Lua script detects an issue (result == true), the manifest file contains a set of defined actions.

### Manifest File Field Descriptions

| Manifest Field | Description | Configuration Notes |
| :--- | :---- | :---- |
| id | Name | Named according to the functionality of the script |
| category | system | Multiple types can be used: system, os, net, file, db, docker... |
| level | Alert Level | Optional types: debug, info, warn, error |
| title | Rule Title | Generally named after the functionality of the rule |
| desc | Description | Text describing and explaining the rule's execution results |
| cron | Custom Execution Interval | Refer to: [Writing cron examples](#writing-cron) |
| disabled | Toggle | Optional field: true or false |
| os_arch | Supported Operating Systems | Array type, options: "windows" "linux" |

Built-in scheck rules are located in the installation directory under `rules.d`.

## User-Defined Exclusive Rules and Lua Libraries
This example illustrates a rule that periodically checks the hostname:
1. Write a Lua file
Create a file named `10001-hostname.lua` in the user directory `custom.rules.d`. The code is as follows:
``` lua
local function check()
    local cache_key = "hostname"
    local old = get_cache(cache_key) -- get_cache(key) is a built-in Go function for Lua script caching, used with set_cache(cache_key, current)
    if old == nil then
        local current = hostname()   -- Built-in Go function to get the hostname
        set_cache(cache_key, current)
        return
    end
    local current =  hostname()
    if old ~= current then
        trigger({Content=current})   -- Built-in Go function to send messages to DataKit or local logs
        set_cache(cache_key, current)
    end
end
check()
```

> Note: scheck expects user-defined rule names to follow these [conventions](#lua-rule-naming-conventions)

2. Write a manifest file
Create a file named `10001-hostname.manifest` in the user directory `custom.rules.d`. The content is as follows:

``` toml
id="10001-hostname"
category="system"
level="info"
title="Hostname Changed"
desc="Hostname changed to: {{.Content}}"
cron="0 */1 * * *"
# Toggle
disabled=false
os_arch=["Linux"]
```

The current manifest file configuration runs every minute.

3. Restart the server

```shell
systemctl restart scheck.service
```

4. Send Messages

After restarting the server, the script will run every minute. You can change the hostname after one minute.

Static hostnames are stored in `/etc/hostname`, which can be modified via command.

``` shell
   hostnamectl set-hostname myclient1
```

5. Observation

Log in to the [Guance](https://www.guance.com) console -> Navigation Bar -> Security Check: View inspection information, and you will find a message indicating the hostname has been modified.

   ![](img/image-hostname.png)


## Rule Library
*Lua library files and user-defined libraries*:

scheck's built-in Lua library files are located in the installation directory under `rules.d/libs`. Function lists and interface documentation can be viewed [online](funcs.md).

Library files do not require a manifest file. In Lua, you need to declare them once when referencing. For example, to reference `directorymonitor` from `libs`, you need to declare it once:

```lua
local directorymonitor = require("directorymonitor")

local function check()

directorymonitor.add("/usr/bin")
end
check()
```

> Note: Users should not modify scheck's built-in libraries and Lua rule files. Each installation update and service restart will overwrite the rule files.

User-defined rules and library files can be placed in the `custom.rules.d` directory. If there are custom Lua libraries, place them in `custom.rules.d/libs`.

When pointing to another path, simply modify the configuration file `scheck.conf`:

``` toml
[system]
  # ##(Required) Directory where detection scripts are stored
  rule_dir = "/usr/local/scheck/rules.d"
  # ##Custom directory
  custom_dir = "/usr/local/scheck/custom.rules.d"
  # Optional User-defined Lua library directory. System default is the libs directory under the user directory.
  custom_rule_lib_dir = "/usr/local/scheck/custom.rules.d/libs"
```
Then restart the service.

-------------------
# Appendix

## Lua Rule Naming Conventions

scheck's built-in Lua files are named based on their type. The ID prefix indicates the rule type.

User rule names should start with a number and must not be less than 10000, such as `10001-xxx.lua`.

scheck's built-in rule naming conventions:

| ID Range | Rule Type |
| :---: | :----: |
| 0000 | System Cache |
| 0001~0199 | System |
| 0200~0299 | Network |
| 0300~0310 | Container-related |
| 0500~0510 | Database |
| 10000 and above | User-defined |

> User-defined Lua rules that do not follow the naming conventions will fail to load.

## Setting the Cron Field in Manifest Files
Scheck supports two execution methods: interval execution and long-term execution. Fixed-time execution is currently unsupported!

### Interval Execution Cron
```shell
cron="* */1 * * *"  # Executes every minute
cron="* * */1 * *"  # Executes every hour
cron="* * * */1 *"  # Executes every day
```
### Long-Term Execution Rules

```shell
cron="disable" or cron=""  
```

Long-term execution rules will continuously run and report messages within one second when triggered. For example, when a file changes.