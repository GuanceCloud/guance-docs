# User-defined rule files and lib libraries
---

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64

## scheck Rule Introduction
*Lua rule introduction*:

The rule script consists of two files: a lua file and a manifest file, both of which must exist simultaneously! And the file prefixes must be the same!

- `<rule-name>.lua`: This is the judgment script for the rule, implemented based on Lua syntax, but it cannot reference or use standard Lua libraries. Only built-in Lua libraries and built-in functions can be used.

- `<rule-name>.manifest`: This is the rule list file. When the corresponding Lua script detects an issue (result == true), there is a set of corresponding behavior definitions in the manifest file.

### Manifest File Field Description

| Manifest Field | Field Description | Configuration Description |
| :--- | :---- | :---- |
| id | Name | Named according to the ID rule plus the functionality of this script |
| category | system | Multiple types can be used: system, os, net, file, db, docker... |
| level | Alert Level | Optional types include: debug, info, warn, error |
| title | Rule Title | Generally named after the functionality of the rule |
| desc | Description | Displays and specifically explains the results of the rule's execution |
| cron | Custom Execution Interval | Refer to: [Writing cron examples](#writing-cron) |
| disabled | Switch | Optional field: true or false |
| os_arch | Supported Operating Systems | Array type, optional: "windows" "linux" |


scheck built-in rules are located in the `rules.d` directory under the installation directory.

## User-defined Exclusive Rules and Lua Libraries
This example uses a scheduled check of the hostname as an example:
1. Write a lua file
Create a file named `10001-hostname.lua` in the user directory `custom.rules.d`. The code is as follows:
``` lua
local function check()
    local cache_key = "hostname"
    local old = get_cache(cache_key) -- `get_cache(key)` is a go built-in function used for Lua script caching, paired with `set_cache(cache_key, current)`
    if old == nil then
        local current = hostname()   -- Go built-in function to retrieve the hostname
        set_cache(cache_key, current)
        return
    end
    local current =  hostname()
    if old ~= current then
        trigger({Content=current})   -- Go built-in function used to send messages to datakit or local logs
        set_cache(cache_key, current)
    end
end
check()
```

> Note: scheck expects user-defined rule names to follow such a [standard](#lua-rule-naming-standard)

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

The current rule list file configuration runs once per minute.


3. Restart the server

```shell
systemctl restart scheck.service
```

4. Send the message

After restarting the server, the script will run once every minute. You can modify the hostname after one minute.

The static hostname is saved in the `/etc/hostname` file and can be modified via a command.

``` shell
   hostnamectl set-hostname myclient1
```

5. Observe

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>) console -> navigation bar -> Security Check: View inspection information, find a message indicating that the hostname has been modified.

   ![](img/image-hostname.png)


## Rule Library
*Lua library files and user-defined libraries*:

The Lua reference library files included with scheck are located in the `rules.d/libs` directory under the installation directory. The function list and interface documentation can be [viewed online](funcs.md).

Libraries do not require a manifest list file; they need to be declared once in Lua when referenced. For example, to reference `directorymonitor` from the libs, declare it once:

```lua
local directorymonitor = require("directorymonitor")

local function check()

directorymonitor.add("/usr/bin")
end
check()
```

> Note: Users should not modify the lib libraries and Lua rule files that come with scheck, as they will be overwritten during each installation update and service restart.


User-defined rules and library files can be placed in the `custom.rules.d` directory. If there are user-defined Lua reference libraries, they can be placed in the `custom.rules.d/libs` directory.

When pointing to another path, just modify the configuration file `scheck.conf`:

``` toml
[system]
  # ##(Required) Directory where the system stores detection scripts
  rule_dir = "/usr/local/scheck/rules.d"
  # ##Custom directory
  custom_dir = "/usr/local/scheck/custom.rules.d"
  # Optional User-defined Lua library directory (cannot use `rule_dir`, default is the libs subdirectory under the user directory)
  custom_rule_lib_dir = "/usr/local/scheck/custom.rules.d/libs"
```
Then restart the service.

-------------------
# Appendix

## Lua Rule Naming Standard

The Lua provided by scheck is named according to its type, with the ID at the beginning representing a specific rule type.

User rule names should start with numbers and must not be less than 10000, for example: `10001-xxx.lua`

scheck's rule naming standard:

| ID Range | Rule Type |
| :---: | :----: |
| 0000 | System Cache |
| 0001~0199 | system |
| 0200~0299 | NETWORK |
| 0300~0310 | CONTAINERS related |
| 0500~0510 | DATABASE |
| 10000 and above | User-defined |

> User-defined Lua not following the naming standard will cause the rule to fail to load.

## Setting the Cron Field in the Manifest File
Scheck supports two execution modes: interval execution and long-term type. Currently, fixed-time execution is not supported!

### Interval Execution Cron
```shell
cron="* */1 * * *"  # Executes once per minute
cron="* * */1 * *"  # Executes once per hour
cron="* * * */1 *"  # Executes once per day
```
### Persistent Rules

```shell
cron="disable" or cron=""  
```

Persistent rules will keep running, reporting messages within one second when triggered. For example: when a file changes.