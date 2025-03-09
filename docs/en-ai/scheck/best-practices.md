# Scheck Best Practices
---

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

# Introduction

    In general, one of the most important tasks in operations and maintenance is to inspect the status of systems, software, and logs. Traditional solutions often involve engineers writing shell (bash) scripts for similar tasks and using remote script management tools to manage clusters. However, this method can be very risky due to the high-level permissions required for system inspection operations, which are often run as root. If a malicious script is executed, the consequences can be disastrous. There are two types of malicious scripts: one type involves malicious commands like `rm -rf`, and the other involves data theft, such as leaking data through network IO. Therefore, Security Checker aims to provide a new secure scripting method (restricting command execution, local IO, and network IO) to ensure all actions are safe and controllable. Additionally, Security Checker will collect inspection events via a unified network model in log format. Security Checker will also provide a vast, updatable rule library for system, container, network, and security inspections.

> scheck is the abbreviation for Security Checker.
>
> scheck only pushes security inspection events and does not provide recovery notifications.

# Prerequisites

| Service Name | Version                                                         | Required Installation | Purpose            |
| ------------ | --------------------------------------------------------------- | --------------------- | ------------------ |
| Datakit      | 1.1.6 or later [Installation Method](../datakit/datakit-install.md) | Required              | Accept scheck signals |
| DataFlux     | [DataFlux SaaS](https://guance.com) or other private deployment versions | Required              | View security inspection |

# Configuration

### 1 Install Scheck

```sh
sudo -- bash -c "$(curl -L https://<<< custom_key.static_domain >>>/security-checker/install.sh)"
```

### 2 Check Installation Status and Datakit Running Status
- Check scheck status
```sh
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
- Check datakit status
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

### 3 Log in to the DataFlux Console to View Security Inspection Records ([SaaS Platform](https://dataflux.cn))

- Select the left sidebar - Security Inspection to view inspection content

  ![](img/bestpractices-2.png)

# Related Commands
> Security Checker cmd
- View help
```sh
$scheck -h
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
        Display all Lua runtime statuses and output them to the current directory in Markdown format.
  -sort
        Use with `-luastatus`. Sorting parameters: name, time, count. Default sorting by count
     ./scheck -luastatus -sort=time
  -check
        Precompile all Lua files in the user directory once to check for syntax errors.
  -box
        Display all files loaded into the binary
```

- Start/Stop Commands
```sh
systemctl start/stop/restart/status scheck 
## or 
service scheck start/stop/restart/status 
```