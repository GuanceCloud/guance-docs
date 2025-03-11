# User-defined Rule Files and Libraries

---

- Version: 1.0.7-5-gb83de2d
- Release Date: 2022-08-30 03:31:26
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## scheck Rule Introduction
*Lua Rule Introduction*:

The rule script consists of two files: a Lua file and a manifest file. Both files must exist simultaneously, and they must share the same prefix!

- `<rule-name>.lua`: This is the evaluation script for the rule, implemented using Lua syntax. However, it cannot reference or use standard Lua libraries; only built-in Lua libraries and functions can be used.

- `<rule-name>.manifest`: This is the rule manifest file. When the corresponding Lua script detects an issue (result == true), a set of predefined actions in the manifest file will be triggered.

### Manifest File Field Descriptions

| Manifest Field | Description | Configuration Notes |
| :--- | :---- | :---- |
| id | Name | Named according to the functionality of the script, prefixed by the ID |
| category | system | Multiple types can be used: system, os, net, file, db, docker... |
| level | Alert Level | Options include: debug, info, warn, error |
| title | Rule Title | Typically named based on the rule's functionality |
| desc | Description | Provides detailed information about the rule's execution results |
| cron | Custom Execution Interval | Refer to: [Cron Examples](#writing-cron) |
| disabled | Toggle | Optional field: true or false |
| os_arch | Supported Operating Systems | Array type, options: "windows", "linux" |

scheck's built-in rules are located in the `rules.d` directory under the installation path.

## User-defined Exclusive Rules and Lua Libraries
This example demonstrates creating a rule that periodically checks the hostname:

1. Create a Lua File
Create a file named `10001-hostname.lua` in the user directory `custom.rules.d`. The code is as follows:
``` lua
local function check()
    local cache_key = "hostname"
    local old = get_cache(cache_key) -- get_cache(key) is a Go built-in function used for caching in Lua scripts, paired with set_cache(cache_key, current)
    if old == nil then
        local current = hostname()   -- Go built-in function to retrieve the hostname
        set_cache(cache_key, current)
        return
    end
    local current = hostname()
    if old ~= current then
        trigger({Content=current})   -- Go built-in function to send messages to datakit or local logs
        set_cache(cache_key, current)
    end
end
check()
```

> Note: scheck expects user-defined rule names to follow this [naming convention](#lua-naming-convention)

2. Create a Manifest File
Create a file named `10001-hostname.manifest` in the user directory `custom.rules.d`. The content is as follows:

``` toml
id="10001-hostname"
category="system"
level="info"
title="Hostname Modified"
desc="Hostname changed to: {{.Content}}"
cron="0 */1 * * *"
# Toggle
disabled=false
os_arch=["Linux"]

```

The current manifest configuration sets the rule to execute every minute.

3. Restart the Server

```shell
systemctl restart scheck.service
```

4. Send Messages

After restarting the server, the script will run every minute. You can change the hostname after one minute.

The static hostname is stored in `/etc/hostname`, which can be modified using the command:

``` shell
hostnamectl set-hostname myclient1
```

5. Monitor

Log in to the [<<< custom_key.brand_name >>>](https://www.guance.com) console -> Navigation Bar -> Security Check: View inspection information and find a message indicating the hostname has been changed.

![](img/image-hostname.png)

## Rule Library
*Lua Library Files and User-defined Libraries*:

scheck's built-in Lua library files are located in the `rules.d/libs` directory under the installation path. The function list and API documentation can be viewed [online](../scheck/funcs.md).

Library files do not require a manifest file. In Lua, you need to declare the library once when referencing it, such as requiring `directorymonitor` from `libs`:

```lua
local directorymonitor = require("directorymonitor")

local function check()

directorymonitor.add("/usr/bin")
end
check()
```

> Note: Users should not modify scheck's built-in libraries or Lua rule files. Each installation update and service restart will overwrite the rule files.

User-defined rules and libraries can be placed in the `custom.rules.d` directory. If there are custom Lua libraries, place them in the `custom.rules.d/libs` directory.

If pointing to another path, simply modify the configuration file `scheck.conf`:

``` toml
[system]
  # ##(Required) Directory where system detection scripts are stored
  rule_dir = "/usr/local/scheck/rules.d"
  # ##Custom directory
  custom_dir = "/usr/local/scheck/custom.rules.d"
  # Optional User-defined Lua library directory, default is libs under the user directory
  custom_rule_lib_dir = "/usr/local/scheck/custom.rules.d/libs"
```
Then restart the service.

-------------------
# Appendix

## Lua Rule Naming Convention

scheck's built-in Lua rules are named based on their type, with the ID prefix indicating the rule category.

User-defined rule names should start with a number greater than or equal to 10000, for example: `10001-xxx.lua`.

scheck's naming conventions for built-in rules:

| ID Range | Rule Type |
| :---: | :----: |
| 0000 | System Cache |
| 0001~0199 | System |
| 0200~0299 | Network |
| 0300~0310 | Container-related |
| 0500~0510 | Database |
| 10000 and above | User-defined |

> User-defined Lua rules that do not follow the naming convention will fail to load.

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

Long-running rules will continuously execute and report messages within one second when triggered. For example, when a file changes.