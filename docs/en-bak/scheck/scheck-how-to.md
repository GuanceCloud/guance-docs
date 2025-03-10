# SCheck Introduction

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

This document mainly introduces how to use the basic functions of SCheck after [SCheck Installation](scheck-install.md), including the following aspects:

## SCheck Directory Introduction {#dir}

SCheck currently supports two mainstream platforms: Linux and Windows:

| Operating System                            | Architecture        | Installation Path                                                                                |
| ---------                           | ---                 | ------                                                                                       |
| Linux kernel 2.6.23 or higher            | amd64/386/arm/arm64 | `/usr/local/scheck`                                                      |
| Windows 7, Server 2008R2 or higher       | amd64/386           | 64-bit: `C:\Program Files\scheck`<br />32-bit: `C:\Program Files(32)\scheck` |

> Tips: Check kernel version

- Linux: `uname -r`
- Windows: Open `cmd` command (hold Win key + `r`, enter `cmd` and press Enter), enter `winver` to get system version information

After installation, the SCheck directory list is approximately as follows:

```txt
├── [   6]  custom.rules.d
├── [ 12K]  rules.d
├── [ 17M]  scheck
├── [ 664]  scheck.conf
└── [ 222]  version
```

Where:

- *scheck*: SCheck main program, *scheck.exe* for Windows
- *custom.rules.d*: User-defined directory
- *rules.d*: SCheck system directory
- *scheck.conf*: SCheck main configuration file
- *version*: SCheck version information

> Note: Under Linux, SCheck running logs are in the */var/log/scheck* directory.

## Related Commands {#commands}

View help:

```sh
$ scheck -h
Usage of scheck:
  -check-md5
        md5 checksum
  -config string
        configuration file to load
  -config-sample
        show config sample
  -funcs
        show all supported lua-extend functions
  -test string
        the name of a rule, without file extension
  -testc int
        test rule count
  -version
        show version
  -doc
        Generate doc document from manifest file
  -tpl
        Generate doc document from template file
  -dir
        use with `-doc` `-tpl` to output files to the specified directory
  -luastatus
        display all lua running status and output to the current directory, file format suitable for Markdown.
  -sort
        use with `-luastatus`, sorting parameters include: name, time, count, default to use count
     ./scheck -luastatus -sort=time
  -check
        precompile all lua files in the user directory to check for syntax errors.
  -box
        display the list of all files loaded into the binary
```

## Detection Rules {#rules}

Detection rules are placed in the rule directory: specified by the `rule_dir` in the configuration file or the custom user directory `custom_dir`. Each rule corresponds to two files:

1. Script file: Written in [Lua](http://www.lua.org/){:target="_blank"}, must end with the `.lua` suffix.
2. Manifest file: In [TOML](https://toml.io/en/){:target="_blank"} format, must end with the `.manifest` suffix, see [Manifest File](scheck-how-to.md#manifest).

The script file and the manifest file **must have the same name**.

SChecker will periodically execute the detection scripts according to the `cron` specified in the manifest file. Each time the Lua script code is executed, it checks whether any security events (such as file changes, new user logins, etc.) are triggered. If triggered, it uses the `trigger()` function to send the event (in line protocol format) to the address specified by the `output` field in the configuration file.

SChecker defines several Lua extension functions and, to ensure security, disables some Lua packages or functions, only supporting the following Lua built-in packages/functions:

- The following basic built-in packages are supported

    - `table`
    - `math`
    - `string`
    - `debug`

- In the `os` package, all can be used **except the following functions**:

    - `execute()`
    - `remove()`
    - `rename()`
    - `setenv()`
    - `setlocale()`

> Adding/modifying rule manifest files and Lua code **does not require restarting the service**, SChecker scans the rule directory every 10 seconds.

### Manifest File {#manifest}

The manifest file is a description of the content detected by the current rule, such as file changes, port starts and stops, etc. The final line protocol data will only include the fields in the manifest file. The detailed content is as follows:

```toml
# ---------------- Required fields ----------------

# The rule number of the event, such as k8s-pod-001, will be used as the metric name in the line protocol
id = ''

# The category of the event, customized according to the business
category = ''

# The danger level of the current event, customized according to the business, such as warn, error
level = ''

# The title of the current event, describing the content of the detection, such as "Sensitive file change"
title = ''

# The content of the current event (supports templates, details below)
desc = ''

# Configure the execution period of the event (using the syntax rules of linux crontab)
cron = ''

# Platform support
os_arch = ["Linux", "Windows"]
# ---------------- Optional fields ----------------

# Disable the current rule
#disabled = false

# Default to add hostname in tags
#omit_hostname = false

# Explicitly set hostname
#hostname = ''

# ---------------- Custom fields ----------------

# Support for adding custom key-value, and the value must be a string
#instanceID=''
```

### Cron Rules {#cron}

Currently, only interval execution is supported

``` txt
# ┌───────────── Second
# │ ┌───────────── Miniute
# │ │ ┌───────────── Hour
# │ │ │ ┌───────────── Day-of-Month
# │ │ │ │ ┌───────────── Month
# │ │ │ │ │
# │ │ │ │ │
# │ │ │ │ │
# * * * * *
```

Example:

`*/10 * * * *`: Run every 10 seconds.
`* */5 * * *`: Run once every 5 minutes.
`disable`: If set to disable or an empty character, the lua is long-lasting, such as: listening for file changes. Once this type of lua is running, it will not stop.

### Template Support {#template}

The `desc` string in the manifest file supports setting template variables, with the syntax `{{.<Variable>}}`, for example

```txt
File {{.FileName}} was modified, and the modified content is: {{.Content}}
```

Indicates that `FileName` and `Diff` are template variables, which will be replaced (including the preceding dot `.`). When calling the `trigger()` function, the variable is replaced. This function can pass in a Lua `table` variable, which contains the replacement values for the template variables. Suppose the following parameters are passed:

```lua
tmpl_vals={
    FileName = "/etc/passwd",
    Content = "delete user demo"
}
trigger(tmpl_vals)
```

Then the final `desc` value is:

```txt
File /etc/passwd was modified, and the modified content is `delete user demo`
```

## Test Rules {#test}

When writing rule code, you can use `scheck --test` to test if the code is correct. Suppose there is a *demo* rule in the *rules.d* directory:

```shell
$ scheck --test  ./rules.d/demo
```

The `--test` test can also test multiple at the same time, assuming that the script runs based on another script execution:

```shell
$ scheck --test  rules.d/0000-global-cache,rules.d/0400-k8s-node-conf-priv
```

## Lua Functions {#lua-funcs}

See [Functions](funcs.md)

## Create Common Libraries {#common-rules}

SChecker allows the use of the `require` function to import Lua modules in detection scripts, and module files can only be stored in the *rules.d/lib* directory. Some commonly used functions can be modularized and placed in this lib subdirectory for use in detection scripts.

Suppose you create a Lua module *common.lua*:

``` lua
module={}

function modules.Foo()
    -- Function body...
end

return module
```

Place *common.lua* in the */usr/local/scheck/rules.d/lib* directory.

Suppose there is a rule script *demo.lua* that uses this common module:

``` lua
common=require("common") --No need to write the suffix name
common.Foo()
```

## Line Protocol {#line-proto}

SCheck's output is in line protocol format. The rule ID is used as the metric name.

### Tag List {#tags}

| Name        | Type   | Description                                    | Required |
| ---         | :----: | ----                                           | :---:    |
| `title`     | string | Security event title                           | true     |
| `category`  | string | Event category                                 | true     |
| `level`     | string | Security event level, supports: `info`, `warn`, `critical` | true     |
| `host`      | string | Event source hostname (default has)            |          |
| `os_arch`   | string | Host platform                                   | true     |
| Custom tags | string | Custom tags in the manifest file               | false    |

Current `category` classifications

- `network`: Network related, mainly involving connections, ports, firewalls, etc.
- `storage`: Storage related, such as disks, HDFS, etc.
- `db`: Various database related (MySQL/Redis/...)
- `system`: Mainly related to the operating system
- `container`: Including Docker and Kubernetes

### Metric List {#fields}

| Metric Name  | Type   | Description |
| ---          | :---:  | ----        |
| `message`    | string | Event details |

## SCheck Limit Running Resources {#cgroup}

Limit SCheck running resources (such as CPU usage) through cgroup (only supports the Linux operating system). Enter the SCheck installation directory and modify the scheck.conf configuration file. Set enable to true, example is as follows:

```toml
[cgroup]
# Optional, default closed, can control cpu and mem
enable = false
cpu_max = 30.0
cpu_min = 5.0
mem = 0
```
