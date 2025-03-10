# Scheck Funcs Support List

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## Introduction
Originally, all functions were registered when initializing the Lua virtual machine, but these methods were not used by the Lua scripts, causing redundancy in the virtual machine.

As the number of functions increased, this redundancy became increasingly severe, so modularization and packaging were implemented.

## How to Use These Modules
Go functions are divided into multiple modules by package. When using a module in a Lua script, you need to import the package first (except for `trigger`).

Lua code:
``` lua
    -- Using the file module
    local file = require("file")
    local info = file.file_info("./example.exe")
    print(info['size'])
    -- do something ...
    
    -- Using the cache module
    local cache = require("cache")
    cache.set_cache({"123","abc"})
    print(cache.get_cache("123")) -- "abc"

    -- trigger does not require declaration
    local current = "123"
    trigger({Content=current})
```

## Module and Funcs List

> Note: The method sets differ across operating systems and cannot be called across systems! `all_os` includes methods common to all operating systems.

- [file](#file)
    - [all_os](#file_all_os)
      - [ls](#ls)
      - [file_exist](#file_exist)
      - [file_info](#file_info)
      - [read_file](#read_file)
      - [file_hash](#file_hash)
      - [sc_path_watch](#sc_path_watch)
      - [grep](#grep)
- [system](#system)
    - [all_os](#system_all_os)
      - [hostname](#hostname)
      - [uptime](#uptime)
      - [time_zone](#time_zone)
      - [mounts](#mounts)
      - [uname](#uname)
      - [sc_sleep](#sc_sleep)
      - [sc_ticker](#sc_ticker)
    - [linux](#system_linux)
      - [kernel_info](#kernel_info)
      - [kernel_modules](#kernel_modules)
      - [ulimit_info](#ulimit_info)
      - [processes](#processes)
      - [process_open_files](#process_open_files)
      - [users](#users)
      - [logged_in_users](#logged_in_users)
      - [last](#last)
      - [lastb](#lastb)
      - [shadow](#shadow)
      - [shell_history](#shell_history)
      - [crontab](#crontab)
      - [sysctl](#sysctl)
      - [rpm_list](#rpm_list)
      - [rpm_query](#rpm_query)
    - [windows](#system_windows)
- [net](#net)
    - [all_os](#net_all_os)
      - [interface_addresses](#interface_addresses)
    - [linux](#net_linux)
      - [iptables](#iptables)
      - [process_open_sockets](#process_open_sockets)
      - [listening_ports](#listening_ports)
    - [windows](#net_windows)
- [cache](#cache)
    - [all_os](#cache_all_os)
      - [get_cache](#get_cache)
      - [set_cache](#set_cache)
      - [del_cache](#del_cache)
      - [del_cache_all](#del_cache_all)
      - [get_global_cache](#get_global_cache)
      - [set_global_cache](#set_global_cache)
- [json](#json)
    - [all_os](#json_all_os)
      - [json_encode](#json_encode)
      - [json_decode](#json_decode)
- [mysql](#mysql)
    - [all_os](#mysql_all_os)
      - [mysql_weak_psw](#mysql_weak_psw)
      - [mysql_ports_list](#mysql_ports_list)
- [Container](#container-related-functions)
    - [sc_docker_exist](#sc_docker_exist)
    - [sc_docker_containers](#sc_docker_containers)
    - [sc_docker_runlike](#sc_docker_runlike)
- [Others](#others)
      - [trigger](#trigger)


## File
### file_all_os

#### ls

`ls(dir[, rescue])`

List files in the specified directory.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| dir | `string` | Path of the directory | true |
| rescue | `boolean` | If recursively traverse the directory, default is false | false |

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| path | string | Full path of the file |
| filename | string | Name of the file |
| size | number | Size of the file in bytes |
| block_size | number | Block size of the filesystem |
| mode | string | Permission bits |
| uid | number | Owning user ID |
| gid | number | Owning group ID |
| device | number | Device ID (optional) |
| inode | number | Filesystem inode number |
| hard_links | number | Number of hard links |
| ctime | number | Last status change time |
| mtime | number | Last modification time |
| atime | number | Last access time |

---

#### file_exist

`file_exist(filepath)`

Check if a file exists.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| filepath | `string` | Absolute file path | true |


*Return value(s):*  

| Type | Description |
| --- | ---- |
| `boolean` | `true` if exists, otherwise `false` |

*Example:*  

``` lua
file = '/your/file/path'
exists = file_exist(file)
print(exists)
```

---

#### file_info

`file_info(filepath)`

Read file attributes and metadata.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| filepath | `string` | Absolute file path | true |


*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table` | Contains details of the file as below |


| Name | Type | Description |
| --- | ---- | ---- |
| size | number | Size of the file in bytes |
| block_size | number | Block size of the filesystem |
| mode | string | Permission string |
| perm | string | Permission bits |
| uid | number | Owning user ID |
| gid | number | Owning group ID |
| device | number | Device ID (optional) |
| inode | number | Filesystem inode number |
| hard_links | number | Number of hard links |
| ctime | number | Last status change time |
| mtime | number | Last modification time |
| atime | number | Last access time |

*Example:*  

``` lua
file = '/your/file/path'
info = file_info(file)
```

---


#### read_file

`read_file(filepath)`

Reads the file content.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| filepath | `string` | Absolute file path | true |


*Return value(s):*   

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `string` | File content |


*Examples:*  

``` lua
file='/your/file/path'
content = read_file(file)
```

---


#### file_hash

`file_hash(filepath)`

Calculate the MD5 sum of the file content.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| filepath | `string` | Absolute file path | true |


*Return value(s):*   

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `string` | MD5 of the file content |


*Examples:*  

``` lua
file='/your/file/path'
content = file_hash(file)
```

---

#### sc_path_watch

`sc_path_watch(dir,chan)`

Watch whether the file or directory has changed.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| dir | `string` | Directory or filename | true |
| chan | `lua.LChannel` | Lua channel | true |


*Return value(s):*  

No return value and never stops.
If the directory or file changes, it will be notified through the Lua channel.

*The Lua channel:* 

| Type | Description |
| --- | ---- |
| `table`(array) | Each item described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| path | string | Full path of the file |
| status | int | File status |
*File status:*

| status | name | Description |
| --- | ---- | ---- |
| 1 | CREATE | Create file in the directory |
| 2 | WRITE | Write to file |
| 4 | REMOVE | When file is deleted |
| 8 | RENAME | File renamed |
| 16 | CHMOD | Permissions changed |

#### grep

`grep(option, pattern, file)`

Run the grep command.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| option | `string` | Options for grep | false |
| pattern | `string` | Pattern for grep | true |
| file | `string` | File to search with grep | true |


*Return value(s):*  

| Type | Description |
| --- | ---- |
| `string` | Result of grep, empty if not found |
| `string` | Error info if failed |

---

## System
### system_all_os
#### hostname

`hostname()`

Get the current hostname.


*Return value(s):*   

It issues an error when it fails to get.

| Type | Description |
| --- | ---- |
| `string` | Hostname |


---

#### uptime

`uptime()`

Time passed since the last boot.


*Return value(s):*   

| Type | Description |
| --- | ---- |
| `number` | Total uptime seconds |

---

#### time_zone

`time_zone()`

Current timezone in the system


*Return value(s):*   

| Type | Description |
| --- | ---- |
| `string` | Current timezone in the system |

---

#### mounts

`mounts()`

System mounted devices and filesystems (not process specific)


*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item corresponding to a mounted device described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| device | string | Mounted device |
| path | string | Mounted device path |
| type | string | Mounted device type |
| flags | string | Mounted device flags |

---

#### uname

`uname()`

Operating system name and version

*Return value(s):*  

It issues an error when it fails.

| Type | Description |
| --- | ---- |
| `table` | See below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| platform | string | OS Platform or ID, e.g., centos |
| platform_version | string | OS Platform version, e.g., 7.7.1908 |
| family | string | OS Platform family, e.g., rhel |
| os | string | OS name, e.g., Linux |
| arch | string | OS Architecture, e.g., x86_64 |
| kernel_version | string | OS kernel version |

---

#### sc_sleep

`sc_sleep(time)`

Thread sleeps for a certain number of seconds

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| time | `int` | Seconds to sleep | true |


*Return value(s):*  

It issues an error when it fails.

#### sc_ticker

 `sc_ticker(channel,time)`
 
 Send signals to the Lua channel regularly
 
 *Parameters:*  
 
 | Name | Type | Description | Required |
 | --- | ---- | ---- | ---- |
 | chan | `lua.LChannel` | Lua channel | true |
 | time | `int` | Seconds interval | true |
 
 *Return value(s):*  
 
 No return value
 Sends Lua.LString to Lua channel.
### system_linux
#### kernel_info

`kernel_info()`

Linux kernel modules both loaded and within the load search path


*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table` | Details as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| version | string | Kernel version |
| arguments | string | Kernel arguments |
| path | string | Kernel path |
| device | string | Kernel device identifier |

---

#### kernel_modules

`kernel_modules()`

Linux kernel modules both loaded and within the load search path


*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item corresponding to a module described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| name | string | Module name|
| size | string | Size of module content |
| used_by | string | Module reverse dependencies |
| status | string | Kernel module status |
| address | string | Kernel module address |

---

#### ulimit_info

`ulimit_info()`

System resource usage limits.

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table` | See below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| type | string | System resource to be limited |
| soft_limit | string | Current limit value |
| hard_limit | string | Maximum limit value |

---

#### processes

`processes()`

All running processes on the host system

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item corresponding to a process described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| pid | number | Process (or thread) ID |
| name | string | The process path or shorthand argv[0] |
| path | string | Path to executed binary |
| cmdline | string | Complete argv |
| state | string | Process state |
| cwd | string | Process current working directory |
| root | string | Process virtual root directory |
| uid | number | Unsigned user ID |
| gid | number | Unsigned group ID |
| euid | number | Unsigned effective user ID |
| egid | number | Unsigned effective group ID |
| suid | number | Unsigned saved user ID |
| sgid | number | Unsigned saved group ID |
| on_disk | number | The process path exists yes=1, no=0, unknown=-1 |
| resident_size | number | Bytes of private memory used by process |
| total_size | number | Total virtual memory size |
| system_time | number | CPU time in milliseconds spent in kernel space |
| user_time | number | CPU time in milliseconds spent in user space |
| disk_bytes_read | number | Bytes read from disk |
| disk_bytes_written | number | Bytes written to disk |
| start_time | number | Process start time in seconds since Epoch, in case of error -1 |
| parent | number | Process parent's PID |
| pgroup | number | Process group |
| threads | number | Number of threads used by process |
| nice | number | Process nice level (-20 to 20, default 0) |

---
#### process_open_files

`process_open_files()`

File descriptors for each process.

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item corresponding to a process which has open files described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| pid | number | Process (or thread) ID |
| fd | number | Process-specific file descriptor number |
| path | string | Filesystem path of descriptor |

---

#### users

`users()`

Local user accounts (including domain accounts that have logged on locally (Windows))

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| username | string | Username |
| uid | number | User ID |
| gid | number | Group ID (unsigned) |
| directory | string | User's home directory |
| shell | string | User's configured default shell |


---

#### logged_in_users

`logged_in_users()`

Users with an active shell on the system.

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| pid | number | Process (or thread) ID |
| username | string | Username |
| type | number | Login type, see utmp.h |
| tty | number | Device name |
| host | string | Remote hostname |
| time | string | Time entry was made, unix timestamp in seconds |


---

#### last

`last()`

System logins and logouts.

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| pid | number | Process (or thread) ID |
| username | string | Username |
| type | number | Login type, see utmp.h |
| tty | number | Device name |
| host | string | Remote hostname |
| time | string | Time entry was made, unix timestamp in seconds |


---

#### lastb

`lastb()`

Failed logins.

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| pid | number | Process (or thread) ID |
| username | string | Username |
| type | number | Login type, see utmp.h |
| tty | number | Device name |
| host | string | Remote hostname |
| time | string | Time entry was made, unix timestamp in seconds |

---

#### shadow

`shadow()`

Local system users encrypted passwords and related information. Please note, that you usually need superuser rights to access `/etc/shadow`.

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| username | string | Username |
| password_status | string | Password status |
| last_change | number | Date of last password change (starting from UNIX epoch date) |
| expire | number | Number of days since UNIX epoch date until account is disabled |

---

#### shell_history

`shell_history()`

A line-delimited (command) table of per-user .*_history data.

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| uid | number | Shell history owner |
| history_file | string | Path to the .*_history for this user |
| command | string | Unparsed date/line/command history line |
| time | number | Entry timestamp. It could be absent, default value is 0. |

---

#### crontab

`crontab()`

Line parsed values from system and user cron/tab.

*Return value(s):*  

It issues an error when it fails.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| minute | string | The exact minute for the job |
| hour | string | The hour of the day for the job |
| day_of_month | string | The day of the month for the job |
| month | string | The month of the year for the job |
| day_of_week | string | The day of the week for the job |
| command | string | Raw command string |
| path | string | File parsed |

---

#### sysctl

`sysctl([key])`

Operating system sysctl info

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| key | `string` | Specify a key to get back, otherwise return all key-values | false |

*Return value(s):*  

It issues an error when it fails.

| Type | Description |
| --- | ---- |
| `table` | Same as running Linux command 'sysctl -a' |

---

#### rpm_list

`rpm_list()`

List all current RPM packages

*Return value(s):*  

It issues an error when it fails.

| Type | Description |
| --- | ---- |
| `string` | Same as running Linux command 'rpm -qa' |

---

#### rpm_query

`rpm_query(pkg)`

Check if a package is installed

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| package | `string` | The package name, e.g., yum | false |

*Return value(s):*  

| Type | Description |
| --- | ---- |
| `string` | Package's fullname, or empty if not found |

---

### system_windows

## Net
### net_all_os
#### interface_addresses

`interface_addresses()`

Network interfaces and relevant metadata.


*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item corresponding to a network interface described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| interface | string | Interface name |
| ip4 | string | IPv4 address |
| ip6 | string | IPv6 address |
| mtu | number | MTU |
| mac | string | MAC address |

---

### net_linux

#### iptables

`iptables()`

Linux IP packet filtering and NAT tool

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item corresponding to a filtering rule described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| filter_name | string | Packet matching filter table name. |

---

#### process_open_sockets

`process_open_sockets()`

Processes which have open network sockets on the system

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item corresponding to a process with open network sockets described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| pid | number | Process (or thread) ID |
| process_name | string | The process name |
| cmdline | string | Complete argv |
| fd | number | Socket file descriptor number |
| socket | number | Socket handle or inode number |
| family | string | Network protocol (AF_INET, AF_INET6, AF_UNIX) |
| protocol | string | Transport protocol (tcp, udp...) |
| local_address | string | Socket local address |
| remote_address | string | Socket remote address |
| local_port | number | Socket local port |
| remote_port | number | Socket remote port |
| path | string | For UNIX sockets (family=AF_UNIX), the domain path |
| net_namespace | number | The inode number of the network namespace |
| state | string | TCP socket state |

---

#### listening_ports

`listening_ports()`

Processes with listening (bound) network sockets/ports


*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`(array) | Each item described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| pid | number | Process (or thread) ID |
| process_name | string | The process name |
| cmdline | string | Complete argv |
| socket | number | Socket handle or inode number |
| fd | number | Socket file descriptor number |
| address | string | Specific address for bind |
| port | number | Transport layer port |
| family | string | Network protocol (AF_INET, AF_INET6, AF_UNIX) |
| protocol | string | Transport protocol (tcp, udp...) |
| path | string | For UNIX sockets (family=AF_UNIX), the domain path |

---
### net_windows

## Cache
### cache_all_os
#### get_cache

`get_cache(key)`

Get value for cache key.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| key | `string` | Name of cache key | true |


*Return value(s):*  

| Type | Description |
| --- | ---- |
| `string`/`boolean`/`number` | Cache value |

---

#### set_cache

`set_cache(key, value)`

Set a cache key-value pair.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| key | `string` | Name of cache key | true |
| value | `string`/`boolean`/`number` | Cache value by key | true |


*Return value(s):*  


| Type | Description |
| --- | ---- |
| `string` | Error detail if failed |

---

#### clean_cache

`clean_cache()`

Clean this rule cache.

*Parameters:*  

*Return value(s):*  

---

#### del_cache

`del_cache(key)`

Delete cache by key.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| key | `string` | Name of cache key | true |

*Return value(s):*  
no return

---
#### del_cache_all

`del_cache_all()`

Delete all cache.

*Parameters:*  

*Return value(s):*  

---

#### get_global_cache

`get_global_cache(key)`

Get value for global cache key.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| key | `string` | Name of cache key | true |


*Return value(s):*  

| Type | Description |
| --- | ---- |
| `string`/`boolean`/`number` | Cache value |

---

#### set_global_cache

`set_global_cache(key, value)`

Set a key-value to global cache.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| key | `string` | Name of cache key | true |
| value | `string`/`boolean`/`number` | Cache value by key | true |


*Return value(s):*  


| Type | Description |
| --- | ---- |
| `string` | Error detail if failed |

## JSON
### json_all_os

#### json_encode

`json_encode(object)`

Encode a Lua table to JSON string

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| object | `table` | A Lua table | true |


*Return value(s):*  

It issues an error if it fails to encode

| Type | Description |
| --- | ---- |
| `string` | JSON string |

---

#### json_decode

`json_decode(str)`

Decode a JSON string to Lua table

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| str | `string` | A JSON string | true |


*Return value(s):*  

It issues an error if it fails to decode

| Type | Description |
| --- | ---- |
| `table` | A Lua table |

---

## MySQL

### mysql_all_os

#### mysql_weak_psw

`mysql_weak_psw(host, port [,username])`

Check MySQL weak password

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| host | `string` | URL of MySQL | true |
| port | `string` | MySQL port | true |
| username | `string` | MySQL username, default is 'root' | false |


*Return value(s):*  

It issues an error when it fails.

| Type | Description |
| --- | ---- |
| `boolean` | True means some weak password found |
| `string` | The weak password if found |


---

#### mysql_ports_list


`mysql_ports_list()`

List the host MySQL ports

*Return value(s):*  

It issues an error when it fails to read.

| Type | Description |
| --- | ---- |
| `table`() | Each item described as below |

 
| Name | Type | Description |
| --- | ---- | ---- |
| pid | number | Process (or thread) ID |
| cmdline | string | Complete argv |
| port | number | Transport layer port |
| protocolversion | string | MySQL protocol version |
| statusflags | string | Socket file descriptor number |
| authpluginname | string | Auth plugin name |
| serverversion | string | MySQL Server Version |
| state | string | Process state |

*Output example:*
```
port	3307
protocolversion	10
statusflags	2
authpluginname	mysql_native_password
serverversion	5.7.34
state	LISTEN
cmdline	/usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 3307 -container-ip 172.18.0.4 -container-port 3306
pid	7062
``` 

## Container-related Functions
#### sc_docker_exist

`sc_docker_exist()`

Check if Docker service exists on the host


*Return value(s):*  

It issues an error when it fails.

| Type | Description |
| --- | ---- |
| `boolean` | True if Docker service exists on the host |

#### sc_docker_containers

`sc_docker_containers()`

List Docker containers

Before using other Docker functions, `sc_docker_exist` must be checked first!!!

*Return value(s):*  

It issues an error when it fails.

| Type | Description |
| --- | ---- |
| `[]string` | The containerName list |


#### sc_docker_runlike

`sc_docker_runlike(containerName)`

Get the run command for a Docker container

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| containerName | `string` | Image ID | true |

*Return value(s):*  

It issues an error when it fails.

| Type | Description |
| --- | ---- |
| `string` | The containerName run command |


## Others
#### trigger

`trigger([template_vals])`

Trigger an event and send it to target with line protocol.

*Parameters:*  

| Name | Type | Description | Required |
| --- | ---- | ---- | ---- |
| template_vals | `table` | If you use templates in the manifest, the values of this table will replace the template variables | false |


*Return value(s):*  

It issues an error when it fails.

---