# Scheck Best Practices
---

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Operating System Support: windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64

# Introduction

    Generally, in the operation and maintenance process, one of the most important tasks is to inspect the status of systems, software, including logs, etc. Traditional solutions often rely on engineers writing shell (bash) scripts for similar tasks, and using some remote script management tools to achieve cluster management. However, this method is actually very risky because system inspection operations usually require high privileges, often running as root. If a malicious script is executed, the consequences can be catastrophic. In practice, there are two types of malicious scripts: one is malicious commands, such as rm -rf; the other involves data theft, such as leaking data through network IO. Therefore, Security Checker aims to provide a new type of secure scripting method (restricting command execution, local IO, and network IO) to ensure all actions are safe and controllable. Additionally, Security Checker will collect inspection events via a unified network model in log form. At the same time, Security Checker will provide a massive updatable rule library, including inspections for systems, containers, networks, security, and more.

> scheck is the abbreviation for Security Checker
>
> scheck only pushes security inspection events and does not provide recovery notifications



# Prerequisites


| Service Name | Version                                                         | Is Installation Required | Purpose            |
| ------------ | --------------------------------------------------------------- | ----------------------- | ------------------ |
| Datakit      | 1.1.6 or higher [Installation Method](../datakit/datakit-install.md) | Required                | Accepts scheck signals |
| DataFlux     | [DataFlux SaaS](https://<<< custom_key.brand_main_domain >>>) or other private deployment versions      | Required                | View security inspections |




# Configuration

### 1 Install Scheck

```sh
sudo -- bash -c "$(curl -L https://static.<<< custom_key.brand_main_domain >>>/security-checker/install.sh)"
```



### 2 Check installation status and datakit operational status
- Check scheck status
```sh
$systemctl status scheck
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
● datakit.service - Collects data and upload it to DataFlux.
   Loaded: loaded (/etc/systemd/system/datakit.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2021-07-03 01:07:44 CST; 2 days ago
 Main PID: 27371 (datakit)
    Tasks: 9
   Memory: 29.6M
   CGroup: /system.slice/datakit.service
           └─27371 /usr/local/datakit/datakit
```


### 3 Log in to the DataFlux console to view security inspection records ([SaaS Platform](https://dataflux.cn))

- Select Security Inspection from the left sidebar to view inspection content	

  ![](img/bestpractices-2.png)





# Related Commands
> Security Checker cmd
- Check help
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
        Used with `-doc` `-tpl`, outputs files to the specified directory
  -luastatus
        Displays all lua runtime statuses and outputs them to the current directory in Markdown format.
  -sort
        Used with `-luastatus`, sort parameters include: name: name, runtime duration: time, run count: count, default uses count
     ./scheck -luastatus -sort=time
  -check
        Pre-compiles all lua files under the user directory once, checking for syntax errors.
  -box
        Displays a list of all files loaded into the binary
```


- Start/Stop Commands 
```sh
systemctl start/stop/restart/status scheck 
## or 
service scheck start/stop/restart/status 
```