# How to Enable Security Check

---

## Introduction

<<< custom_key.brand_name >>> supports you in conducting a "Security Check" on the status of systems, containers, networks, security, and logs. It ensures all actions are secure and controllable through a new type of secure scripting method (restricted command execution, restricted local IO, restricted network IO).

In general, one of the most critical tasks in operations and maintenance is inspecting the status of systems, software, and logs. Traditional solutions often involve engineers writing shell (bash) scripts for similar tasks and managing clusters using remote script management tools. However, this method can be very dangerous due to the high permissions required for system inspections, which typically run as root. If a malicious script executes, the consequences can be catastrophic. There are two types of malicious scripts: one involves harmful commands like `rm -rf`, and the other involves data theft, such as leaking data via network IO. Therefore, Security Checker aims to provide a new, secure scripting method (restricted command execution, restricted local IO, restricted network IO) to ensure all actions are safe and controllable. Additionally, Security Checker will collect inspection events via a unified network model in log format. Security Checker also provides a vast, updatable rule library, including inspections for systems, containers, networks, and security.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://www.guance.com);
- Install DataKit on your host [Install DataKit](../datakit/datakit-install.md);

## Method Steps

### Step 1: Install Scheck

Install Security Checker via DataKit:

```shell
$ sudo datakit --install scheck
```

**Note**: By default, Security Checker sends data to the DataKit `:9529/v1/write/security` interface after installation.

### Step 2: Configure Data Collection

- Navigate to the default installation directory `/usr/local/scheck` and open the configuration file `scheck.conf`. The configuration file uses the [TOML](https://toml.io/en/) format, with the following instructions:

```toml
rule_dir = '/usr/local/scheck/rules.d'

# ##(Required) Where to send the inspection results, supporting local files or http(s) URLs
# ##For local files, use the prefix file://, e.g., file:///your/file/path
# ##For remote servers, e.g., http(s)://your.url
output = ''

# ##(Optional) Configuration for program logs
disable_log = false # Whether to disable logging
log = '/usr/local/scheck/log'
log_level = 'info'
```

- After configuring, restart the service for changes to take effect.

```shell
systemctl restart scheck
```

### Step 3: Configure Inspection Rules

Inspection rules are stored in the directory specified by `rule_dir` in the configuration file. Each rule corresponds to two files:

1. Script file: written in [Lua](http://www.lua.org/) and must have a `.lua` extension.
2. Manifest file: written in [TOML](https://toml.io/en/) format and must have a `.manifest` extension.

By adding/modifying manifest files and Lua code, you can configure the inspection rules.

**Note**:

- The script file and manifest file must have the same name.
- No service restart is needed after adding/modifying rules; they will automatically take effect within 10 seconds.

### Step 4: View Installation Status and DataKit Running Status

- View scheck status

```shell
$ systemctl status scheck
● scheck.service - security checker with lua script
   Loaded: loaded (/usr/lib/systemd/system/scheck.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2021-07-03 00:13:15 CST; 2 days ago
 Main PID: 15337 (scheck)
    Tasks: 10
   Memory: 12.4M
   CGroup: /system.slice/scheck.service
           └─15337 /usr/local/scheck/scheck -config /usr/local/scheck/scheck.conf
```

- View DataKit status

```shell
$ systemctl status datakit
● datakit.service - Collects data and uploads it to DataFlux.
   Loaded: loaded (/etc/systemd/system/datakit.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2021-07-03 01:07:44 CST; 2 days ago
 Main PID: 27371 (datakit)
    Tasks: 9
   Memory: 29.6M
   CGroup: /system.slice/datakit.service
           └─27371 /usr/local/datakit/datakit
```

### Step 5: Log in to <<< custom_key.brand_name >>> to View Security Check Records

- Select Security Check from the left sidebar to view inspection content

![](img/e1.png)

## Advanced Reference

### Secure Observability

<<< custom_key.brand_name >>> provides users with a Security Check function that can discover malicious programs, system vulnerabilities, and security defects with one click. Through "Security Check," you can not only promptly identify vulnerabilities and anomalies in hosts, systems, containers, and networks but also detect some daily management issues (e.g., data leakage via network IO).

#### Simulate Hacker Intrusion Operations

- Log in to the host terminal

![](img/e2.png)

- Simulate adding a user and crontab record

```
useradd xlsm
crontab -e
```

#### Log in to <<< custom_key.brand_name >>> to View and Analyze Security Check Information

You can see that a user was added at 18:52 on December 19th. How should we handle this issue?

![](img/e3.png)

Click on the record to view recommendations for remediation on the host

![](img/e4.png)

Execute the command on the host console: `userdel xlsm`

## More References

For more details, refer to the documentation [Security Check](../scheck/explorer.md).