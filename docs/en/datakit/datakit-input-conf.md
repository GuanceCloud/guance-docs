
# Collector Configuration
---

The collector configuration in DataKit is in the [Toml format](https://toml.io/cn){:target="_blank"}, and all collector configurations are in the *conf.d* directory:

- Linux/Mac：`/usr/local/datakit/conf.d/`
- Windows：`C:\Program Files\datakit\conf.d\`

Each collection is categorized and located in the lower subdirectory of *conf.d*. You can refer to the specific collector configuration instructions to find the corresponding subdirectory.

A typical configuration collector file has the following structure:

```toml
[[inputs.some_name]] # The line is required to indicate which collector configuration this toml file is
  key = value
  ...

[[inputs.some_name.other_options]] # The line is optional, and some collectors are configured with this line, while others are not
  key = value
  ...
```
<!-- markdownlint-disable MD046 -->
??? attention

    Because DataKit only searches for files in the `conf.d/` directory that are extended by `.conf`, all collector configurations must be placed in the `conf.d` directory (or its lower subdirectory) and must be suffixed by `.conf`, otherwise DataKit will ignore the processing of the configuration file.
<!-- markdownlint-enable -->
## How to Modify Collector Configuration {#modify-input-conf}

At present, some collectors can be turned on without configuration, while others need to edit the configuration manually.

<!-- markdownlint-disable MD013 -->
### Enable Multiple Collections with the Same Collector {#input-multi-inst}
<!-- markdownlint-enable -->
Taking MySQL as an example, if you want to configure multiple different MySQL collections, there are two ways:

1. Add a new conf file, such as *mysql-2.conf*, which can be placed in the same directory as the existing *mysql.conf*.
1. In the existing mysql.conf, add a paragraph like this:

```toml
# The first MySQL collection
[[inputs.mysql]]
  host = "localhost"
  user = "datakit"
  pass = "<PASS>"
  port = 3306
  
  interval = "10s"
  
  [inputs.mysql.log]
    files = ["/var/log/mysql/*.log"]
  
  [inputs.mysql.tags]
  
    # Omit other configuration items...

#-----------------------------------------
# Another MySQL collection
#-----------------------------------------
[[inputs.mysql]]
  host = "localhost"
  user = "datakit"
  pass = "<PASS>"
  port = 3306
  
  interval = "10s"
  
  [inputs.mysql.log]
    files = ["/var/log/mysql/*.log"]
  
  [inputs.mysql.tags]
  
    # Omit other configuration items...

#-----------------------------------------
# Continue to add another one below
#-----------------------------------------
[[inputs.mysql]]
  ...
```

The second method is probably simpler to manage, which manages all collectors with the same name with the same conf, and the first method may lead to confusion in the configuration directory.

To sum up, the structure of the second multi-acquisition configuration is as follows:

```toml
[[inputs.some-name]]
   ...
[[inputs.some-name]]
   ...
[[inputs.some-name]]
   ...
```

This is actually a Toml array structure, the structure is suitable for multiple configurations of all collectors.
<!-- markdownlint-disable MD046 -->
???+ attention

    - Two collector configuration files with identical contents (file names can be different). To prevent misconfiguration, only one of them will be applied.
    
    - Configuring multiple different collectors (such as MySQL and Nginx) into one conf is not recommended, which can cause some odd problems and is not easy to administer.
    
    - Some collectors are limited to single-instance operation, see [input-singleton for details](#input-singleton).
<!-- markdownlint-enable -->
### Single Instance Collector {#input-singleton}

Some collectors only allow a single instance to run, and even if multiple copies are configured, only a single instance will run. These single instance collectors are listed as follows:

| Collector Name                                        | Description                                                                                                                                 |
| ---                                                   | ---                                                                                                                                         |
| [`cpu`](../integrations/cpu.md)                       | Collect the CPU usage of the host                                                                                                           |
| [`disk`](../integrations/disk.md)                     | Collect disk occupancy                                                                                                                      |
| [`diskio`](../integrations/diskio.md)                 | Collect the disk IO status of the host                                                                                                      |
| [`ebpf`](../integrations/ebpf.md)                     | Collect TCP and UDP connection information of host network, Bash execution log, etc.                                                        |
| [`mem`](../integrations/mem.md)                       | Collect the memory usage of the host                                                                                                        |
| [`swap`](../integrations/swap.md)                     | Collect Swap memory usage                                                                                                                   |
| [`system`](../integrations/system.md)                 | Collect the load of host operating system                                                                                                   |
| [`net`](../integrations/net.md)                       | Collect host network traffic                                                                                                                |
| [`netstat`](../integrations/netstat.md)               | Collect network connections, including TCP/UDP connections, waiting for connections, waiting for processing requests, etc.                  |
| [`host_processes`](../integrations/host_processes.md) | Collect the list of resident (surviving for more than 10min) processes on the host                                                          |
| [`hostobject`](../integrations/hostobject.md)         | Collect basic information of host computer (such as operating system information, hardware information, etc.)                               |
| [`container`](../integrations/container.md)           | Collect possible containers or Kubernetes data on the host. Assuming there are no containers on the host, the collector will exit directly. |

### Close the Specific Collector {#disable-inputs}

Sometimes, we want to temporarily shut down a collector, and there are two ways:

1. Rename the corresponding collector conf, such as *mysql.conf* to  *mysql.conf.bak*. Just make sure the file suffix is not *conf*
1. In conf, comment out the corresponding collection configuration, such as:

```toml

# Comment out the first MySQL collection
#[[inputs.mysql]]
#  host = "localhost"
#  user = "datakit"
#  pass = "<PASS>"
#  port = 3306
#  
#  interval = "10s"
#  
#  [inputs.mysql.log]
#    files = ["/var/log/mysql/*.log"]
#  
#  [inputs.mysql.tags]
#  
#    # Omit other configuration items...
#

# Keep this MySQL collection
[[inputs.mysql]]
  host = "localhost"
  user = "datakit"
  pass = "<PASS>"
  port = 3306
  
  interval = "10s"
  
  [inputs.mysql.log]
    files = ["/var/log/mysql/*.log"]
  
  [inputs.mysql.tags]
  
    # Omit other configuration items...
```

In contrast, the first approach is more crude and simple, and the second one needs to be carefully modified, which may lead to Toml configuration errors.
<!-- markdownlint-disable MD013 -->
### Regular Expressions in Collector Configuration {#debug-regex}
<!-- markdownlint-enable -->
When editing the collector configuration, some regular expressions may need to be configured.

Since DataKit is mostly developed using Golang, the regular wild match used in the configuration section is also implemented using Golang's own regular implementation. As there are some differences in the regular systems of different languages, it is difficult to write the configuration correctly at one time.

We recommend an [online tool to debug our regular wildcard](https://regex101.com/){:target="_blank"}. As shown in the following figure:

<figure markdown>
  ![](https://static.guance.com/images/datakit/debug-golang-regexp.png){ width="800" }
</figure>

In addition, since Toml is used in the configuration of DataKit, it is recommended that you fill in the regular form by using `'''Here is a specific regular expression'''` (that is, three English single quotation marks are used on both sides of the regular form), so as to avoid some complicated escapes.

## Collector Turned on by Default {#default-enabled-inputs}

After DataKit is installed, a batch of collectors will be turned on by default without manual opening. These collectors are generally related to the host, and the list is as follows:

| Collector Name                                        | Description                                                                                                                                 |
| ---                                                   | ---                                                                                                                                         |
| [`cpu`](../integrations/cpu.md)                       | Collect the CPU usage of the host                                                                                                           |
| [`disk`](../integrations/disk.md)                     | Collect disk occupancy                                                                                                                      |
| [`diskio`](../integrations/diskio.md)                 | Collect the disk IO status of the host                                                                                                      |
| [`mem`](../integrations/mem.md)                       | Collect the memory usage of the host                                                                                                        |
| [`swap`](../integrations/swap.md)                     | Collect Swap memory usage                                                                                                                   |
| [`system`](../integrations/system.md)                 | Collect the load of host operating system                                                                                                   |
| [`net`](../integrations/net.md)                       | Collect host network traffic                                                                                                                |
| [`host_processes`](../integrations/host_processes.md) | Collect the list of resident (surviving for more than 10min) processes on the host                                                          |
| [`hostobject`](../integrations/hostobject.md)         | Collect basic information of host computer (such as operating system information, hardware information, etc.)                               |
| [`container`](../integrations/container.md)           | Collect possible containers or Kubernetes data on the host. Assuming there are no containers on the host, the collector will exit directly. |

## Password Encoding {#password-encode}

In configuring connection strings, special characters in passwords, such as `@#*`, need to be encoded to ensure the link string is correctly interpreted. Below is a list of encodings for these special characters:

> Note: Not all special characters (like `~_-.`) require encoding, but they are listed here for reference.

| Character | URL Encoding | Character | URL Encoding |
| --------- | ------------ | --------- | ------------ |
| `` ` ``   | `%60`        | `~`       | `~`          |
| `!`       | `%21`        | `@`       | `%40`        |
| `#`       | `%23`        | `$`       | `%24`        |
| `%`       | `%25`        | `^`       | `%5E`        |
| `&`       | `%26`        | `*`       | `%2A`        |
| `(`       | `%28`        | `)`       | `%29`        |
| `_`       | `_`          | `-`       | `-`          |
| `+`       | `%2B`        | `=`       | `%3D`        |
| `{`       | `%7B`        | `}`       | `%7D`        |
| `[`       | `%5B`        | `]`       | `%5D`        |
| `\`       | `%5C`        | `:`       | `%3A`        |
| `|`       | `%7C`        | `"`       | `%22`        |
| `'`       | `%27`        | `;`       | `%3B`        |
| `,`       | `%2C`        | `.`       | `.`          |
| `<`       | `%3C`        | `>`       | `%3E`        |
| `/`       | `%2F`        | `?`       | `%3F`        |

Assuming we have the following Git connection string:

``` text
http://username:pa55w#rd@github.com/path/to/repository.git 
```

We need to convert the `#` in the password to its URL-encoded form `%23`:

``` text
http://username:pa55w%23rd@github.com/path/to/repository.git 
```

## For More Readings {#more}

- [DataKit K8s Installation and Configuration](datakit-daemonset-deploy.md)
- [Manage collector configuration through Git](git-config-how-to.md)
