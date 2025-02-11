# User-Defined Rule Files and Libraries
---

- Version: 1.0.7-5-gb83de2d
- Release Date: 2022-08-30 03:31:26
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## scheck Rule Introduction
*Lua Rule Introduction*:

The rule script consists of two files: a Lua file and a manifest file. Both files must exist simultaneously and share the same prefix.

- `<rule-name>.lua`: This is the rule evaluation script implemented using Lua syntax. However, it cannot reference or use standard Lua libraries; only built-in Lua libraries and functions are available.

- `<rule-name>.manifest`: This is the rule manifest file. When the corresponding Lua script detects an issue (result == true), the manifest file defines a set of corresponding actions.

### Manifest File Field Descriptions

| Manifest Field | Description | Configuration Notes |
| :--- | :---- | :---- |
| id | Name | Named according to the ID rule and the functionality of the script |
| category | system | Multiple types can be used: system, os, net, file, db, docker... |
| level | Alert Level | Available types: debug, info, warn, error |
| title | Rule Title | Typically named based on the rule's functionality |
| desc | Description | Text to display and explain the rule's execution results |
| cron | Custom Execution Interval | Refer to: [Cron Examples](#cron-examples) |
| disabled | Switch | Optional field: true or false |
| os_arch | Supported Operating Systems | Array type, options: "windows", "linux" |

scheck built-in rules are located in the `rules.d` directory under the installation path.

## User-Defined Exclusive Rules and Lua Libraries
This example demonstrates a scheduled rule to check the hostname:

1. **Create a Lua File**
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
       local current = hostname()
       if old ~= current then
           trigger({Content=current})   -- Built-in Go function to send messages to DataKit or local logs
           set_cache(cache_key, current)
       end
   end
   check()
   ```

   > Note: scheck expects user-defined rule names to follow this [naming convention](#lua-rule-naming-convention)

2. **Create a Manifest File**
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

   The current rule manifest file configuration runs every minute.

3. **Restart the Server**

   ```shell
   systemctl restart scheck.service
   ```

4. **Send Messages**

   After restarting the server, the script will run every minute. Modify the hostname after one minute.

   The static hostname is stored in `/etc/hostname` and can be changed via command:

   ``` shell
      hostnamectl set-hostname myclient1
   ```

5. **Observation**

   Log in to the [Guance](https://www.guance.com) console -> Navigation Bar -> Security Check: View inspection information, and you will find a message indicating that the hostname has been modified.

   ![](img/image-hostname.png)

## Rule Library
*Lua Library Files and User-Defined Libraries*:

scheck's built-in Lua library files are located in the `rules.d/libs` directory under the installation path. Function lists and interface documentation can be viewed [online](../scheck/funcs.md).

Library files do not require a manifest file. In Lua, you need to declare the library once when referencing it. For example, to reference `directorymonitor` from `libs`, you would declare it as follows:

```lua
local directorymonitor = require("directorymonitor")

local function check()

directorymonitor.add("/usr/bin")
end
check()
```

> Note: Users should not modify scheck's built-in libraries or Lua rule files, as they will be overwritten during each installation update and service restart.

User-defined rules and library files can be placed in the `custom.rules.d` directory. If there are user-defined Lua libraries, place them in the `custom.rules.d/libs` directory.

If pointing to another path, modify the configuration file `scheck.conf`:

``` toml
[system]
  # ##(Required) Directory for storing detection scripts
  rule_dir = "/usr/local/scheck/rules.d"
  # ##Custom directory
  custom_dir = "/usr/local/scheck/custom.rules.d"
  # Optional User-defined Lua library directory (default is `libs` under the user directory)
  custom_rule_lib_dir = "/usr/local/scheck/custom.rules.d/libs"
```
Then restart the service.

-------------------
# Appendix

## Lua Rule Naming Convention

scheck's built-in Lua files are named based on their type. The ID at the beginning indicates the rule type.

User rule names should start with a number and must be greater than or equal to 10000, such as `10001-xxx.lua`.

scheck's built-in rule naming conventions:

| ID Range | Rule Type |
| :---: | :----: |
| 0000 | System Cache |
| 0001~0199 | System |
| 0200~0299 | Network |
| 0300~0310 | Container-related |
| 0500~0510 | Database |
| 10000 and above | User-Defined |

> User-defined Lua files not following the naming convention will fail to load.

## Setting the Cron Field in the Manifest File
Scheck supports two execution modes: interval execution and long-running types. Fixed-time execution is currently not supported!

### Interval Execution Cron
```shell
cron="* */1 * * *"  # Executes every minute
cron="* * */1 * *"  # Executes every hour
cron="* * * */1 *"  # Executes every day
```

### Long-Running Rules

```shell
cron="disable" or cron=""  
```

Long-running rules execute continuously and report messages within one second when triggered. For example, when a file changes.