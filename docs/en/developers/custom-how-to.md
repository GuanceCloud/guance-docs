# User-defined rule files and lib libraries
---

- Version: 1.0.7-5-gb83de2d
- Release Date: 2022-08-30 03:31:26
- Supported Operating Systems: windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64

## scheck Rule Introduction
*Lua rule introduction*:

The rule script consists of two files: a lua file and a manifest file, both of which must exist simultaneously! And they must share the same prefix!

- `<rule-name>.lua`: This is the judgment script for the rule, implemented based on Lua syntax, but it cannot reference or use standard Lua libraries; only built-in Lua libraries and built-in functions can be used.

- `<rule-name>.manifest`: This is the rule list file. When the corresponding Lua script detects an issue (result == true), there is a set of corresponding behaviors defined in the manifest file.

### Manifest File Field Description

| Manifest Field | Field Description | Configuration Description |
| :--- | :---- | :---- |
| id | Name | Named according to the id rule plus the functionality of this script |
| category | system | Multiple types can be used: system, os, net, file, db, docker... |
| level | Alert Level | Optional types include: debug, info, warn, error |
| title | Rule Title | Generally named after the function of this rule |
| desc | Description | Displays and explains the operation results of the rule with text |
| cron | Custom Execution Interval | Refer to: [Cron Examples](#cron-examples) |
| disabled | Switch | Optional field: true or false |
| os_arch | Supported Operating Systems | Array type, options: "windows" "linux" |


scheck built-in rules are located in the `rules.d` directory under the installation path.

## User-defined Exclusive Rules and Lua Libraries
This example demonstrates a scheduled rule that checks the hostname:

1. Write a lua file
Create a file named `10001-hostname.lua` in the user directory `custom.rules.d`. The code is as follows:
``` lua
local function check()
    local cache_key = "hostname"
    local old = get_cache(cache_key) --get_cache(key) is a go built-in function used for lua script caching, paired with set_cache(cache_key, current)
    if old == nil then
        local current = hostname()   -- go built-in function to retrieve the hostname
        set_cache(cache_key, current)
        return
    end
    local current =  hostname()
    if old ~= current then
        trigger({Content=current})   -- go built-in function to send messages to datakit or local logs
        set_cache(cache_key, current)
    end
end
check()
```

> Note: scheck expects user-defined rule names to follow these [standards](#lua-rule-naming-standard)

2. Write a manifest file
Create a file named `10001-hostname.manifest` in the user directory `custom.rules.d`. The content is as follows:

``` toml
id="10001-hostname"
category="system"
level="info"
title="Hostname Modified"
desc="Hostname has been modified to: {{.Content}}"
cron="0 */1 * * *"
# Switch
disabled=false
os_arch=["Linux"]

```

The current rule manifest configuration executes every minute.


3. Restart the server

```shell
systemctl restart scheck.service
```

4. Send the message

After restarting the server, the script will run every minute, and you can modify the hostname after one minute.

The static hostname is stored in the `/etc/hostname` file and can be modified via the command.

``` shell
   hostnamectl set-hostname  myclient1
```

5. Observe

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>) Console -> Navigation Bar -> Security Check: View inspection information and find a message indicating that the hostname was modified.

   ![](img/image-hostname.png)


## Rule Library
*Lua library files and user-defined libraries*:

The scheck built-in Lua reference library files are located in the `rules.d/libs` directory under the installation path. The function list and interface documentation can be viewed [online](../scheck/funcs.md).

Libraries do not require a manifest file. In Lua, libraries need to be declared once when referenced, for example, to reference the `directorymonitor` from `libs`, declare it once:

```lua
local directorymonitor = require("directorymonitor")

local function check()

directorymonitor.add("/usr/bin")
end
check()
```

> Note: Users should not modify the built-in lib libraries and Lua rule files of scheck. Each installation update and service restart will overwrite the rule files.


User-defined rules and libraries can be placed in the `custom.rules.d` directory. If there are custom Lua reference libraries, they can be placed in the `custom.rules.d/libs` directory.

When pointing to another path, simply modify the configuration file `scheck.conf`:

``` toml
[system]
  # ##(Required) Directory where the system stores detection scripts
  rule_dir = "/usr/local/scheck/rules.d"
  # ##Customer-defined directory
  custom_dir = "/usr/local/scheck/custom.rules.d"
  # Optional User-defined Lua libraries, not usable by `rule_dir`, default is the `libs` directory under the user directory
  custom_rule_lib_dir = "/usr/local/scheck/custom.rules.d/libs"
```
Then restart the service.

-------------------
# Appendix

## Lua Rule Naming Standards

The Lua included with scheck is named by type, with the ID at the front representing a specific rule type.

User rule names should start with numbers and must not be less than 10000, for example: 10001-xxx.lua

scheck built-in rule naming standards:

| ID Range | Rule Type |
| :---: | :----: |
| 0000 | System Cache |
| 0001~0199 | system |
| 0200~0299 | Network |
| 0300~0310 | Container-related |
| 0500~0510 | Databases |
| 10000 and above | User-defined |

> User-defined Lua that does not follow the naming standards will result in rule loading failure.

## Manifest File Cron Field Settings
Scheck supports two execution modes: interval execution and long-term type. Currently, fixed-time execution is not supported!

### Interval Execution Cron
```shell
cron="* */1 * * *"  # Executes once per minute
cron="* * */1 * *"  # Executes once per hour
cron="* * * */1 *"  # Executes once per day
```
### Long-Term Rules

```shell
cron="disable" or cron=""  
```

Long-term rules keep running continuously, reporting messages within one second upon triggering. For example: when a file changes.