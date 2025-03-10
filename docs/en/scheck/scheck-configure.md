# Scheck Configuration

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## Configuration Description
Enter the default installation directory `/usr/local/scheck`, open the configuration file `scheck.conf`. The configuration file uses [TOML](https://toml.io/en/) format, as described below:

```toml
[system]
  # ##(Required) Directory where the system stores detection scripts
  rule_dir = "/usr/local/scheck/rules.d"
  # ##Custom directory
  custom_dir = "/usr/local/scheck/custom.rules.d"
  # Hot update
  lua_HotUpdate = false
  cron = ""
  # Whether to disable logging
  disable_log = false
  # System rule blacklist
  system_rule_black_list = [] 

[scoutput]
   # ##Messages generated during Security Check can be sent to local, http, or Alibaba Cloud SLS.
   # ##Remote server, e.g., http(s)://your.url
  [scoutput.http]
    enable = true
    output = "http://127.0.0.1:9529/v1/write/security"
  [scoutput.log]
    # ##Local storage can be configured
    enable = false
    output = "/var/log/scheck/event.log"
  # Alibaba Cloud Log Service
  [scoutput.alisls]
    enable = false
    endpoint = ""
    access_key_id = ""
    access_key_secret = ""
    project_name = "zhuyun-scheck"
    log_store_name = "scheck"

[logging]
  # ##(Optional) Location for storing logs generated during program execution
  log = "/var/log/scheck/log"
  log_level = "info"
  rotate = 0

[cgroup]
    # Optional, default is disabled; can control CPU and memory
  enable = false
  cpu_max = 30.0
  cpu_min = 5.0
  mem = 0
```

### System Module

```toml
[system]
  # ##(Required) Directory where the system stores detection scripts
  rule_dir = "/usr/local/scheck/rules.d"
  # ##Custom directory
  custom_dir = "/usr/local/scheck/custom.rules.d"
  # Hot update
  lua_HotUpdate = ""
  cron = ""
  # Whether to disable logging
  disable_log = false
  # System rule blacklist
  system_rule_black_list = ["all",] 
```

| Parameter Name      | Type  | Description                          |
| :------------------ | :---: | ------------------------------------ |
| rule_dir            | string | Directory where the system stores detection scripts        |
| custom_dir          | string | Custom directory                |
| lua_HotUpdate       | bool   | Hot update, supports loading Lua scripts every 10 seconds |
| cron                | string | Enforces all scheduled times              |
| disable_log         | bool   | Whether to disable logging                  |
| system_rule_black_list | array | Whether to disable system rules (supports regex) ["all","0100*"]                 |

### Scoutput Module

```toml
[scoutput]
   # ##Messages generated during Security Check can be sent to local, http, or Alibaba Cloud SLS.
   # ##Remote server, e.g., http(s)://your.url
  [scoutput.http]
    enable = true
    output = "http://127.0.0.1:9529/v1/write/security"
  [scoutput.log]
    # ##Local storage can be configured
    enable = false
    output = "/var/log/scheck/event.log"
  # Alibaba Cloud Log Service
  [scoutput.alisls]
    enable = false
    endpoint = ""
    access_key_id = ""
    access_key_secret = ""
    project_name = "zhuyun-scheck"
    log_store_name = "scheck"
```

| Parameter Name          | Type  | Description                   |
| ----------------------- | :---: | ----------------------------- |
| scoutput.http           |       | HTTP output module          |
| enable                  | bool  | Whether to enable               |
| output                  | string | DataKit API address       |
| scoutput.log            |       |                        |
| enable                  | bool  | Whether to enable               |
| output                  | string | File path               |
| scoutput.alisls         |       |                        |
| enable                  | bool  | Whether to enable               |
| endpoint                | string | Alibaba Cloud region             |
| access_key_id           | string | Alibaba Cloud AccessKey ID    |
| access_key_secret       | string | Alibaba Cloud AccessKey Secret |
| project_name            | string | Project name               |
| log_store_name          | string | Log store name             |

### Logging Module

```toml
[logging]
  # ##(Optional) Location for storing logs generated during program execution
  log = "/var/log/scheck/log"
  log_level = "info"
  rotate = 0
```

| Parameter Name  | Type  | Description                                 |
| --------------- | :---: | ------------------------------------------- |
| log             | string | Path to Scheck system logs                   |
| log_level       | string | Scheck log level                       |
| rotate          | int    | 0 for default, log rotation size in MB, default 30MB |

### Cgroup Module

```toml
[cgroup]
    # Optional, default is disabled; can control CPU and memory
  enable = false
  cpu_max = 30.0
  cpu_min = 5.0
  mem = 0
```

| Parameter Name | Type  | Description        |
| -------------- | ----- | ------------------ |
| enable         | bool  | Whether to enable    |
| cpu_max        | float | Maximum CPU limit |
| mem            | float | Minimum CPU limit |

## Other
### How to Disable System Rules
```toml
[system]
  ....
  # System rule blacklist
  system_rule_black_list = ["all",] 
```

- Disable all system rules

  system_rule_black_list = ["all"] 
  
- Disable container-related rules

  system_rule_black_list = ["03.*"]
  
  [System ID Specification](custom-how-to.md#Appendix)