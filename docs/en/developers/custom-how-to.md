# Users Define Their Own Rule Files and Lib Libraries
---

- Version: 1.0.7-5-gb83de2d
- Release date: 2022-08-30 03:31:26
- Accessible operating system: windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64

## Introduction to scheck Rules
*Introduction to lua rules*:

The rule script consists of two files: the lua file and the manifest file, both of which must exist at the same time, and the file prefix is the same.

- `<rule-name>.lua`: This is a rule-judging script, implemented based on lua syntax. But it cannot reference or reference standard lua libraries, using only built-in lua libraries and built-in functions.

- `<rule-name>.manifest`: This is the rule manifest file. When the corresponding lua script detects a problem (result == true), there is a set of corresponding behavior definitions in the manifest file

### Manifest File Field Description

| manifest Field | Field Description | Configuration Description |
| :--- | :---- | :---- |
| id | Name | Add the functional name of the script according to the id rule. |
| category | system | You can use several types: system,os,net,file,db,docker... |
| level | Alarm level | You can use several types: debug,info,warn,error |
| title | Rule header name | It is generally named after the function of this rule. |
| desc | Description | Show and specify the operation results of the rules in words. |
| cron | Customize the interval between runs | See: [write a cron example](#编写cron) |
| disabled | Switch | Optional fields: true or false |
| os_arch | Supported operating systems | Array type; you can select: "windows" "linux" |


 scheck built-in rules are in the installation directory `rules.d`

## User-defined Proprietary Rules and Lua Libraries
Take a rule that looks at the hostname at regular intervals as an example:

1、 Write a lua file
Create a file named 10001-hostname.lua under the user directory `custom.rules.d`. The code is as follows:
``` lua
local function check()
    local cache_key = "hostname"
    local old = get_cache(cache_key) --get_cache(key) 是go内置函数 用于lua脚本缓存，搭配set_cache(cache_key, current)使用
    if old == nil then
        local current = hostname()   -- go内置函数 获取主机名
        set_cache(cache_key, current)
        return
    end
    local current =  hostname()
    if old ~= current then
        trigger({Content=current})   -- go内置函数 用于将消息发送到datakit或者本机日志中
        set_cache(cache_key, current)
    end
end
check()
```

> Note: scheck expects user-defined [rule names](#lua规则命名规范) o follow the same specification.

2、 Write a manifest file
Create a file named `10001-hostname.manifest` under the user directory `custom.rules.d`. The contents are as follows:

``` toml
id="10001-hostname"
category="system"
level="info"
title="主机名被修改"
desc="主机名被修改成： {{.Content}}"
cron="0 */1 * * *"
# 开关
disabled=false
os_arch=["Linux"]

```

The current rule manifest file is configured to execute every minute.


3、 Restart the server

```shell
systemctl restart scheck.service
```

4、 Send a message

After restarting the server, the script is executed every minute, and the hostname can be modified after one minute.

The static hostname is saved in the /etc/hostname file and can be modified by name.

``` shell
   hostnamectl set-hostname  myclient1
```

5、 Observation

Log in to the [Guance](https://www.guance.com) Console->Navigation Bar->Scheck: Check the installation sheck information and find a message that the host name has been modified

   ![](img/image-hostname.png)


## Rule Base
*lua library files and user-defined libraries*:

scheck's own lua reference library file is in the installation directory `rules.d/libs`, and the function list and interface documentation can be [viewed online](../scheck/funcs.md).

The manifest file is not required for the lib library file, and the reference in lua needs to be declared once, for example, the reference to directorymonitor in libs needs to be declared once:

```lua
local directorymonitor = require("directorymonitor")

local function check()

directorymonitor.add("/usr/bin")
end
check()
```

> Note: Users cannot modify the lib library and lua rule files that come with scheck, and the rule files will be overwritten every time the service is installed, updated and restarted.


User-defined rules and library files can be placed in the `custom.rules.d`, and if there are custom lua reference library files, they can be placed in the `custom.rules.d/libs` directory.

When pointing to another path, you only need to modify the configuration file `scheck.conf`:

``` toml
[system]
  # ##(Required) The directory in which the system holds the instrumentation scripts
  rule_dir = "/usr/local/scheck/rules.d"
  # ##Customized catalog
  custom_dir = "/usr/local/scheck/custom.rules.d"
  #Optional user-defined lua library unavailable rule_dir system defaults to libs in user directory
  custom_rule_lib_dir = "/usr/local/scheck/custom.rules.d/libs"
```
Then restart the service.

-------------------
# Appendix

## Naming Convention for Lua Rules

The lua that comes with scheck is named by type, and the ID before the name indicates that it belongs to a certain rule type.

User rule names should begin with a number and should not be less than 10000 for example: 10001-xxx.lua

scheck comes with its own rule naming convention:

| ID Range | Rule Type |
| :---: | :----: |
| 0000 | System cache |
| 0001~0199 | System |
| 0200~0299 | Network |
| 0300~0310 | Container correlation |
| 0500~0510 | Database |
| 10000以上 | User-defined |

> If user-defined lua is not named according to the naming convention, the rule would fail to load.

## Manifest File Sets the Timing Cron Field
Scheck supports two operation modes: interval execution and long-term type. Fixed-time execution is not supported at present!

### Interval Execution Cron
```shell
cron="* */1 * * *"  # Execute it every minute
cron="* * */1 * *"  # Execute it every hour
cron="* * * */1 *"  # Execute it every day
```
### Long-term Rule

```shell
cron="disable" or cron=""  
```

The long-term rule will be implemented all the time, and the message will be reported in 1 second when it is triggered. For example, the file changes.
