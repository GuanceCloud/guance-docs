# SCheck Introduction

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

This document primarily introduces how to use the basic functions of SCheck after [SCheck Installation](scheck-install.md), covering the following aspects:

## SCheck Directory Introduction {#dir}

SCheck currently supports two major platforms: Linux and Windows:

| Operating System                        | Architecture       | Installation Path                                                                                     |
| --------------------------------------- | ------------------ | ----------------------------------------------------------------------------------------------------- |
| Linux Kernel 2.6.23 or higher           | amd64/386/arm/arm64 | `/usr/local/scheck`                                                      |
| Windows 7, Server 2008R2 or higher      | amd64/386          | 64-bit: `C:\Program Files\scheck`<br />32-bit: `C:\Program Files (x86)\scheck` |

> Tips: Checking Kernel Version

- Linux: `uname -r`
- Windows: Run `cmd` command (hold down Win key + `r`, type `cmd` and press Enter), then type `winver` to get system version information.

After installation, the SCheck directory structure is roughly as follows:

```txt
├── [   6]  custom.rules.d
├── [ 12K]  rules.d
├── [ 17M]  scheck
├── [ 664]  scheck.conf
└── [ 222]  version
```

Where:

- *scheck*: SCheck main program, *scheck.exe* on Windows
- *custom.rules.d*: User-defined directory
- *rules.d*: SCheck system directory
- *scheck.conf*: SCheck main configuration file
- *version*: SCheck version information

> Note: On the Linux platform, SCheck logs are located in the */var/log/scheck* directory.

## Relevant Commands {#commands}

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
        Use with `-doc` `-tpl` to output files to a specified directory
  -luastatus
        Display all Lua runtime status and output to the current directory in Markdown format.
  -sort
        Use with `-luastatus`. Sorting parameters include: name, time, count. Default is count.
     ./scheck -luastatus -sort=time
  -check
        Precompile all Lua files in the user directory once to check for syntax errors.
  -box
        List all files loaded into the binary
```

## Detection Rules {#rules}

Detection rules are placed in the rules directory, specified by the `rule_dir` in the configuration file or the user-defined directory `custom_dir`. Each rule corresponds to two files:

1. Script file: Written in [Lua](http://www.lua.org/){:target="_blank"}, must have the `.lua` extension.
2. Manifest file: In [TOML](https://toml.io/en/){:target="_blank"} format, must have the `.manifest` extension. See [Manifest File](scheck-how-to.md#manifest).

The script file and manifest file **must have the same name**.

SChecker periodically executes the detection scripts (as defined by the `cron` field in the manifest file). The Lua script checks for security events (e.g., file modifications, new user logins) and triggers an event using the `trigger()` function, sending it in line protocol format to the address specified in the `output` field of the configuration file.

SChecker defines several Lua extension functions and, for security reasons, disables some Lua packages or functions. Only the following Lua built-in packages/functions are supported:

- Supported built-in base packages:

    - `table`
    - `math`
    - `string`
    - `debug`

- In the `os` package, **the following functions are not allowed**:

    - `execute()`
    - `remove()`
    - `rename()`
    - `setenv()`
    - `setlocale()`

> Adding/modifying manifest files and Lua code **does not require restarting the service**. SChecker scans the rules directory every 10 seconds.

### Manifest File {#manifest}

The manifest file describes the content being detected by the rule, such as file changes or port status. The final line protocol data will only contain fields from the manifest file. Details are as follows:

```toml
# ---------------- Required Fields ---------------

# Event rule ID, e.g., k8s-pod-001, used as the metric name in line protocol
id = ''

# Event category, customized based on business needs
category = ''

# Current event severity level, customized based on business needs, e.g., warn, error
level = ''

# Title of the current event, describing the detection content, e.g., "Sensitive file modified"
title = ''

# Description of the current event (supports templates, see below)
desc = ''

# Execution schedule (using Linux crontab syntax)
cron = ''

# Platform support
os_arch = ["Linux", "Windows"]
# ---------------- Optional Fields ---------------

# Disable this rule
#disabled = false

# Omit hostname in tags by default
#omit_hostname = false

# Explicitly set hostname
#hostname = ''

# ---------------- Custom Fields ---------------

# Supports adding custom key-value pairs, where value must be a string
#instanceID=''
```

### Cron Rules {#cron}

Currently, only interval-based execution is supported.

``` txt
# ┌───────────── Second
# │ ┌───────────── Minute
# │ │ ┌───────────── Hour
# │ │ │ ┌───────────── Day-of-Month
# │ │ │ │ ┌───────────── Month
# │ │ │ │ │
# │ │ │ │ │
# │ │ │ │ │
# * * * * *
```

Examples:

`*/10 * * * *`: Runs every 10 seconds.
`* */5 * * *`: Runs every 5 minutes.
`disable`: Setting to `disable` or an empty string makes the Lua script long-running, e.g., monitoring file changes. Once started, it does not stop.

### Template Support {#template}

The `desc` string in the manifest file supports template variables, using the syntax `{{.<Variable>}}`, for example:

```txt
File {{.FileName}} has been modified, changes: {{.Content}}
```

This indicates that `FileName` and `Content` are template variables, which will be replaced (including the preceding dot `.`). When calling the `trigger()` function, these variables are replaced with values passed in a Lua `table`. For instance:

```lua
tmpl_vals={
    FileName = "/etc/passwd",
    Content = "delete user demo"
}
trigger(tmpl_vals)
```

The final `desc` value would be:

```txt
File /etc/passwd has been modified, changes: delete user demo
```

## Testing Rules {#test}

When writing rule code, you can use `scheck --test` to test if the code is correct. Assume there is a *demo* rule in the *rules.d* directory:

```shell
$ scheck --test  ./rules.d/demo
```

You can also test multiple rules at once. If one script depends on another:

```shell
$ scheck --test  rules.d/0000-global-cache,rules.d/0400-k8s-node-conf-priv
```

## Lua Functions {#lua-funcs}

See [Functions](funcs.md)

## Creating Common Libraries {#common-rules}

SChecker allows using the `require` function in detection scripts to import Lua modules, which must be placed in the *rules.d/lib* directory. You can modularize commonly used functions and place them in this lib subdirectory for use by detection scripts.

Assume you create a Lua module *common.lua*:

```lua
module={}

function module.Foo()
    -- Function body...
end

return module
```

Place *common.lua* in */usr/local/scheck/rules.d/lib*.

Assume a rule script *demo.lua* uses this common module:

```lua
common=require("common") -- No need to specify the file extension
common.Foo()
```

## Line Protocol {#line-proto}

SCheck outputs in line protocol format, using the rule ID as the metric name.

### Tag List (tags) {#tags}

| Name        | Type   | Description                                    | Required |
| ---         | :----: | ----                                           | :---:    |
| `title`     | string | Security event title                           | true     |
| `category`  | string | Event category                                 | true     |
| `level`     | string | Security event severity, supports: `info`, `warn`, `critical` | true     |
| `host`      | string | Hostname of the event source (default included) |          |
| `os_arch`   | string | Host platform                                  | true     |
| Custom tags | string | Tags defined in the manifest file              | false    |

Current categories:

- `network`: Network-related, mainly involving connections, ports, firewalls, etc.
- `storage`: Storage-related, such as disks, HDFS, etc.
- `db`: Various database-related (MySQL/Redis/...)
- `system`: Mainly operating system-related
- `container`: Includes Docker and Kubernetes

### Field List (fields) {#fields}

| Field Name | Type   | Description     |
| ---        | :---:  | ----            |
| `message`  | string | Event details   |

### Limiting SCheck Resource Usage {#cgroup}

Limit SCheck resource usage via cgroups (e.g., CPU usage), supported only on Linux systems. Navigate to the SCheck installation directory and modify the scheck.conf configuration file, setting enable to true, as shown below:

```toml
[cgroup]
# Optional, defaults to disabled, can control CPU and memory
enable = false
cpu_max = 30.0
cpu_min = 5.0
mem = 0
```