# How to Enable Security Check
---

## Introduction

<<< custom_key.brand_name >>> supports you in performing "Security Checks" on systems, containers, networks, security, including logs and other statuses through a new type of secure script method (restricted command execution, restricted local IO, restricted network IO) to ensure all actions are safe and controllable.

In general, an important task during operations and maintenance is to inspect the status of systems, software, including logs. Traditional solutions often involve engineers writing shell (bash) scripts for similar tasks and using some remote script management tools to achieve cluster management. However, this method is actually very dangerous because system inspection operations often have excessively high permissions and usually run with root privileges. If malicious scripts are executed, the consequences can be unimaginable. In practice, there are two types of malicious scripts: one is malicious commands, such as `rm -rf`, and the other involves data theft, such as leaking data via network IO to external parties. Therefore, Security Checker aims to provide a new type of secure scripting method (restricted command execution, restricted local IO, restricted network IO) to ensure all actions are safe and controllable. Additionally, Security Checker will collect inspection events through log methods using a unified network model. At the same time, Security Checker will offer a massive updatable rule library of scripts, including inspections for systems, containers, networks, security, and more.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>);
- Install DataKit on your host [Install DataKit](../datakit/datakit-install.md);

## Method Steps

### Step1: Install Scheck

Install Security Checker via DataKit:

```shell
$ sudo datakit --install scheck
```

**Note**: After installation, Security Checker will send data by default to the DataKit `:9529/v1/write/security` interface.

### Step2: Configure Data Collection

- Enter the default installation directory `/usr/local/scheck`, open the configuration file `scheck.conf`. The configuration file uses the [TOML](https://toml.io/en/) format, as explained below:

```toml
rule_dir = '/usr/local/scheck/rules.d'

# ##(Required) Where to collect the detection results, supporting local files or http(s) links
# ##Local files require the prefix file://, example: file:///your/file/path
# ##Remote server, example: http(s)://your.url
output = ''

# ##(Optional) Program's own log configuration
disable_log = false # Whether to disable logging
log = '/usr/local/scheck/log'
log_level = 'info'
```

- After completing the configuration, restart the service to take effect.

```
systemctl restart scheck
```

### Step3: Configure Detection Rules

Detection rules are placed in the rule directory specified by the `rule_dir` in the configuration file. Each rule corresponds to two files:

1. Script file: Written in [Lua](http://www.lua.org/) language, must have the `.lua` extension.
1. Manifest file: Uses the [TOML](https://toml.io/en/) format, must have the `.manifest` extension.

By adding/modifying manifest files and Lua code, you can complete the configuration of detection rules.

**Note**:

- The script file and manifest file must have the same name.
- No service restart is required after adding/modifying rules; they will automatically take effect within 10 seconds.

### Step4: View Installation Status and DataKit Operation Status

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

- View datakit status

```shell
$ systemctl status datakit
● datakit.service - Collects data and upload it to DataFlux.
   Loaded: loaded (/etc/systemd/system/datakit.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2021-07-03 01:07:44 CST; 2 days ago
 Main PID: 27371 (datakit)
    Tasks: 9
   Memory: 29.6M
   CGroup: /system.slice/datakit.service
           └─27371 /usr/local/datakit/datakit
```

### Step5: Log into <<< custom_key.brand_name >>> to view security check records

- Select the left sidebar - Security Check to view inspection content

![](img/e1.png)

## Advanced Reference

### Secure Observability

"<<< custom_key.brand_name >>>" provides users with a security inspection function that allows them to discover malicious programs, system vulnerabilities, and security defects at the click of a button. Through "Security Inspection", you can not only promptly detect vulnerabilities and anomalies in hosts, systems, containers, and networks but also identify some daily management issues (e.g., leaking data via network IO).

#### Simulating Hacker Intrusion Operations

- Log into the host terminal

![](img/e2.png)

- Simulate adding a user and adding crontab records  

```
useradd xlsm
crontab -e
```

#### Log into <<< custom_key.brand_name >>> to view security inspection information and analyze

You can see that a user was added on 12/19 at 18:52. How should we handle this issue?

![](img/e3.png)

Click the record to view suggestions for host remediation.

![](img/e4.png)

Execute the command in the host console: `userdel xlsm`
## More References
For more details, refer to the document [Security Inspection](../scheck/explorer.md).