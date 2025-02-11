# How to Enable Security Check

---

## Introduction

Guance supports you in conducting a "Security Check" on systems, containers, networks, security, and logs through a new type of secure script (restricted command execution, restricted local IO, restricted network IO) to ensure all actions are safe and controllable.

In general, one of the most important tasks in operations and maintenance is inspecting the status of systems, software, and logs. Traditional solutions often involve engineers writing shell (bash) scripts for similar tasks, using remote script management tools to manage clusters. However, this method can be very dangerous due to the high permissions required for system inspection operations, which typically run as root. If malicious scripts execute, the consequences can be severe. There are two types of malicious scripts: one is a malicious command, such as `rm -rf`, and the other involves data theft, such as leaking data via network IO. Therefore, Security Check aims to provide a new type of secure scripting method (restricted command execution, restricted local IO, restricted network IO) to ensure all actions are safe and controllable. Additionally, Security Check will collect inspection events via unified network models and provide a vast, updatable rule library for system, container, network, and security inspections.

## Prerequisites

- You need to create a [Guance account](https://www.guance.com) first;
- Install [DataKit](../datakit/datakit-install.md) on your host;

## Method Steps

### Step 1: Install Scheck

Install Security Checker via DataKit

```shell
$ sudo datakit --install scheck
```

**Note**: After installation, Security Checker sends data to the DataKit `:9529/v1/write/security` interface by default.

### Step 2: Configure Data Collection

- Navigate to the default installation directory `/usr/local/scheck`, open the configuration file `scheck.conf`. The configuration file uses [TOML](https://toml.io/en/) format, with the following instructions:

```toml
rule_dir = '/usr/local/scheck/rules.d'

# ##(Required) Where to send the inspection results, supports local files or http(s) URLs
# ##Use the prefix file:// for local files, e.g., file:///your/file/path
# ##Remote server, e.g., http(s)://your.url
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

Inspection rules are placed in the rule directory specified by `rule_dir` in the configuration file. Each rule corresponds to two files:

1. Script file: written in [Lua](http://www.lua.org/), must have the `.lua` extension.
2. Manifest file: written in [TOML](https://toml.io/en/) format, must have the `.manifest` extension.

By adding/modifying manifest files and Lua code, you can configure inspection rules.

**Note**:

- The script file and manifest file must have the same name.
- No service restart is required after adding/modifying rules; they will take effect automatically within 10 seconds.

### Step 4: View Installation Status and DataKit Operation Status

- Check the scheck status

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

- Check the datakit status

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

### Step 5: Log into Guance to View Security Check Records

- Select Security Check from the left sidebar to view inspection content

![](img/e1.png)

## Advanced References

### Secure Observability

"Guance" provides users with a Security Check function that allows them to discover malicious programs, system vulnerabilities, and security defects with one click. Through "Security Check," you can not only promptly identify vulnerabilities and anomalies in hosts, systems, containers, and networks but also detect daily management issues (e.g., leaking data via network IO).

#### Simulating Hacker Intrusion Operations

- Log into the host terminal

![](img/e2.png)

- Simulate adding a user and adding crontab records  

```shell
useradd xlsm
crontab -e
```

#### Log into Guance to View Security Check Information and Analyze

You can see that a user was added at 18:52 on December 19th. How should we handle this issue?

![](img/e3.png)

Click on the record to view recommendations for host remediation

![](img/e4.png)

Execute the command on the host console: `userdel xlsm`

## More References

For more details, refer to the [Security Check documentation](../scheck/explorer.md).