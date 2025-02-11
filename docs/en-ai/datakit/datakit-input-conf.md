# Collector Configuration
---

## Introduction {#intro}

DataKit collector configurations all use the [TOML format](https://toml.io/en){:target="_blank"}. Each collector is categorized and placed in subdirectories under `conf.d`:

- Linux/Mac: `/usr/local/datakit/conf.d/`
- Windows: `C:\Program Files\datakit\conf.d\`

A typical configuration file for a collector has the following structure:

```toml
[[inputs.some_name]] # This line is mandatory; it indicates which collector this TOML file configures.
    key = value
    ...

[[inputs.some_name.other_options]] # This line is optional; some collectors have this, others do not.
    key = value
    ...
```

<!-- markdownlint-disable MD046 -->
???+ tip

    Since DataKit only searches for files with the `.conf` extension under the `conf.d/` directory, all collector configurations **must be placed in the `conf.d` directory (or its subdirectories) and must have `.conf` as the file extension**. Otherwise, DataKit will ignore these configuration files.
<!-- markdownlint-enable -->

## Default Enabled Collectors {#default-enabled-inputs}

After installing DataKit, a batch of collectors are enabled by default, requiring no manual activation. You can also [disable all default collectors as needed](datakit-install.md#common-envs).

The default enabled collectors are generally related to the host and are listed below:

| Collector Name                                                        | Description                                                                         |
| ---                                                                   | ---                                                                                 |
| [CPU (`cpu`)](../integrations/cpu.md)                                 | Collects CPU usage metrics from the host                                             |
| [Disk (`disk`)](../integrations/disk.md)                              | Collects disk usage information                                                     |
| [Disk IO (`diskio`)](../integrations/diskio.md)                       | Collects disk IO metrics from the host                                               |
| [Memory (`mem`)](../integrations/mem.md)                              | Collects memory usage metrics from the host                                         |
| [Swap (`swap`)](../integrations/swap.md)                              | Collects swap memory usage metrics                                                   |
| [System (`system`)](../integrations/system.md)                        | Collects operating system load metrics                                              |
| [Net (`net`)](../integrations/net.md)                                 | Collects network traffic metrics                                                    |
| [Host Processes (`host_processes`)](../integrations/host_processes.md)| Collects a list of long-running processes (those alive for more than 10 minutes)     |
| [Host Object (`hostobject`)](../integrations/hostobject.md)           | Collects basic host information (e.g., OS info, hardware info)                      |
| [Container (`container`)](../integrations/container.md)               | Collects container or Kubernetes data if present on the host; exits if none         |
| [Datakit (`dk`)](../integrations/dk.md)                               | Collects Datakit runtime metrics                                                    |

### Removing Default Collectors {#disable-default-inputs}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    To disable certain collectors, prefix their names with `-`:
    
    ```toml
    # datakit.conf
    default_enabled_inputs = [
        "-cpu",
        "-disk",
        "-diskio",
        "-mem",
        "swap",
        "system",
        "hostobject",
        "net",
        "host_processes",
        "dk",
    ]
    ```
    
    Similarly, during installation, you can disable them via [this method (`DK_DEF_INPUTS`)](datakit-install.md#common-envs).

=== "Kubernetes"

    Use [environment variables (`ENV_ENABLE_INPUTS`)](datakit-daemonset-deploy.md#env-common) to set the collectors to enable.
<!-- markdownlint-enable -->

## Modifying Collector Configurations {#modify-input-conf}

### Enabling Multiple Instances of the Same Collector {#input-multi-inst}

Using MySQL as an example, if you want to configure multiple MySQL collectors, there are two methods:

- Method One: Create a new `conf` file, e.g., `mysql-2.conf`, and place it in the same directory as the existing `mysql.conf`.

- Method Two: Add a new section within the existing `mysql.conf`:

```toml
# First MySQL collector
[[inputs.mysql]]
  host = "localhost"
  user = "datakit"
  pass = "<PASS>"
  port = 3306
  
  interval = "10s"
  
  [inputs.mysql.log]
    files = ["/var/log/mysql/*.log"]
  
  [inputs.mysql.tags]
  
    # Omit other configuration items ...

#-----------------------------------------
# Another MySQL collector
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
  
    # Omit other configuration items ...

#-----------------------------------------
# Add another one here
#-----------------------------------------
[[inputs.mysql]]
    ...
```

Method Two's multi-instance configuration structure applies to all collectors and follows this pattern:

```toml
[[inputs.some-name]]
   ...
[[inputs.some-name]]
   ...
[[inputs.some-name]]
   ...
```

<!-- markdownlint-disable MD046 -->
???+ attention

    - If two collector configuration files have identical content (even if filenames differ), only one will be applied to prevent misconfiguration.
    - It is not recommended to combine different collectors (like MySQL and Nginx) into a single `conf` file, as this may cause unexpected issues and complicates management.
    - Some collectors are restricted to single-instance operation; see [Single-Instance Collectors](#input-singleton) for details.

???+ tip "Comparison of Both Methods"

    - Method One can lead to a cluttered configuration directory.
    - Method Two is easier to manage, consolidating all instances of the same collector into one `conf` file.
<!-- markdownlint-enable -->

### Single-Instance Collectors {#input-singleton}

Some collectors are restricted to single-instance operation, meaning even if configured multiple times, only one instance will run. The list of single-instance collectors includes:

| Collector Name                                                        | Description                                                                         |
| ---                                                                   | ---                                                                                 |
| [`cpu`](../integrations/cpu.md)                                       | Collects CPU usage metrics from the host                                             |
| [`disk`](../integrations/disk.md)                                     | Collects disk usage information                                                     |
| [`diskio`](../integrations/diskio.md)                                 | Collects disk IO metrics from the host                                               |
| [eBPF](../integrations/ebpf.md)                                       | Collects TCP/UDP connection information, Bash execution logs, etc.                   |
| [`mem`](../integrations/mem.md)                                       | Collects memory usage metrics from the host                                         |
| [`swap`](../integrations/swap.md)                                     | Collects swap memory usage metrics                                                   |
| [`system`](../integrations/system.md)                                 | Collects operating system load metrics                                              |
| [`net`](../integrations/net.md)                                       | Collects network traffic metrics                                                    |
| [`netstat`](../integrations/netstat.md)                               | Collects network connection statistics, including TCP/UDP connections, pending requests, etc. |
| [Host Processes (`host_processes`)](../integrations/host_processes.md)| Collects a list of long-running processes (those alive for more than 10 minutes)     |
| [Host Object (`hostobject`)](../integrations/hostobject.md)           | Collects basic host information (e.g., OS info, hardware info)                      |
| [Container (`container`)](../integrations/container.md)               | Collects container or Kubernetes data if present on the host; exits if none         |
| [Datakit (`dk`)](../integrations/dk.md)                               | Collects Datakit runtime metrics, including CPU, Memory, etc.                         |

### Disabling Specific Collectors {#disable-inputs}

To disable a specific collector, there are two methods:

<!-- markdownlint-disable MD046 -->
???+ tip "Comparison of Both Methods"

    - Method One is simpler but more forceful.
    - Method Two requires careful editing to avoid TOML configuration errors.

- Method One: Rename the corresponding `conf` file, e.g., change `mysql.conf` to `mysql.conf.bak`. **Ensure the file extension is not `.conf`**.
- Method Two: Comment out the relevant collector configuration in the `conf` file:

```toml

# Comment out the first MySQL collector
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
#    # Omit other configuration items ...
#

# Keep this MySQL collector
[[inputs.mysql]]
  host = "localhost"
  user = "datakit"
  pass = "<PASS>"
  port = 3306
  
  interval = "10s"
  
  [inputs.mysql.log]
    files = ["/var/log/mysql/*.log"]
  
  [inputs.mysql.tags]
  
    # Omit other configuration items ...
```
<!-- markdownlint-enable -->

### Regular Expressions in Collector Configurations {#debug-regex}

When editing collector configurations, some settings may require regular expressions.

Since DataKit is primarily developed using Golang, the regex patterns used in configurations follow Golang's regex implementation. Differences between regex implementations across languages can make it challenging to write correct configurations initially.

We recommend using an [online tool to debug regex patterns](https://regex101.com/){:target="_blank"}. As shown below:

<figure markdown>
  ![](https://static.guance.com/images/datakit/debug-golang-regexp.png){ width="800" }
</figure>

Additionally, since DataKit configurations use TOML, we suggest using `'''here is a specific regex pattern'''` (i.e., surrounding the regex with three single quotes) to avoid complex escape sequences.

## Using KV Template Configuration {#kv-template}

KV (Key-Value) pairs are designed to allow users to edit configuration files more conveniently through templates. For example, sensitive information such as passwords and usernames can be securely stored as key-value pairs and referenced in configuration files.

<!-- markdownlint-disable MD046 -->
???+ attention
    - Only supported for host configurations, not [Git](./git-config-how-to.md) or [configuration center](./confd.md).
    - Only applicable within collector configuration files.
<!-- markdownlint-enable -->

### Dynamic Loading Process {#kv-load-flow}

Guance Cloud allows users to create or update KV pairs via the web client. DataKit periodically pulls the latest KV configurations from Guance Cloud and compares them with the current in-memory configurations. If any changes are detected, DataKit traverses all collector configuration files, replacing old KV values with new ones, and reloads any modified configurations.

Note that comparisons are made at the configuration file level. If a file contains multiple collectors, any changes to that file will trigger a reload of all collectors defined within it.

<!-- markdownlint-disable MD046 -->
???+ attention
    - If the reloaded collectors include HTTP services, such as the `ddtrace` collector, the entire HTTP service will be restarted.
<!-- markdownlint-enable -->

Refer to the flowchart below for the complete process:

```mermaid
flowchart TD
    guance(Guance Cloud);
    web_client(web client);
    datakit(DataKit);
    changes{changes?};
    End(end);

   subgraph reload
   direction LR
   changed_conf(find changed conf) -.-> related_inputs(related inputs)
   related_inputs -.-> restart_input(stop & start)
   end
 
   datakit -.-> |pull KV| guance
   web_client -.-> |save KV| guance
   datakit -->  changes
   changes --> |yes| reload
   changes --> |no| End
```

### KV File Cache {#kv-cache}

DataKit caches KV information locally in `<DataKit-Install-Dir>/data/.kv` in JSON format. Example configuration:

```json
{"value":"{\"cpu_kv\": \"cpu_kv_value3\", \"mysql_password\": \"000000\", \"cpu_enable_temperature\": true}","version":10}
```

The `value` field contains the actual KV configuration in `key:value` format, accessible via `{{.key}}`.

The `version` field indicates the current configuration version.

### KV Usage Example {#kv-example}

KV uses [Go template](https://pkg.go.dev/text/template){:target="_blank"} syntax. Below are common usage examples:

- Basic Usage

Assuming the following KV configuration:

```json
{
  "value": {
    "mysql_host": "127.0.0.1",
    "mysql_user": "root",
    "mysql_pass": "abc123!@#"
  },
  "version": 10
}
```

In the configuration file, reference KV values using `{{.key}}` syntax, as shown in the MySQL collector example:

```toml
[[inputs.mysql]]
  host = "{{.mysql_host}}"
  user = "{{.mysql_user}}"
  pass = "{{.mysql_pass}}" # refer to kv config
  port = {{.mysql_port}}
  # sock = "<SOCK>"
  # charset = "utf8"

  # .... 

```

Before loading, DataKit replaces `{{.key}}` with the corresponding KV values, enabling dynamic configuration. For debugging, see [Debugging KV Files](datakit-tools-how-to.md#debug-kv).

- Setting Defaults

To define default values for variables, use the following syntax:

```toml
port = {{.mysql_port | default 3306}}
```

If `port` is undefined or empty, it defaults to `3306`.

## Password Configuration Encoding Issues {#password-encode}

When configuring connection strings, special characters (e.g., `@#*`) in passwords need to be URL-encoded. The following table lists URL encodings for special characters:

> Note that not all special characters (like `~_-.`) require encoding, but they are included for reference.

| Character    | URL Encoding | Character  | URL Encoding |
| ---          | ---          | ---        | ---          |
| `` ` ``      | `%60`        | `~`        | `~`          |
| `!`          | `%21`        | `@`        | `%40`        |
| `#`          | `%23`        | `$`        | `%24`        |
| `%`          | `%25`        | `^`        | `%5E`        |
| `&`          | `%26`        | `*`        | `%2A`        |
| `(`          | `%28`        | `)`        | `%29`        |
| `_`          | `_`          | `-`        | `-`          |
| `+`          | `%2B`        | `=`        | `%3D`        |
| `{`          | `%7B`        | `}`        | `%7D`        |
| `[`          | `%5B`        | `]`        | `%5D`        |
| `\`          | `%5C`        | `:`        | `%3A`        |
| `|`          | `%7C`        | `"`        | `%22`        |
| `'`          | `%27`        | `;`        | `%3B`        |
| `,`          | `%2C`        | `.`        | `.`          |
| `<`          | `%3C`        | `>`        | `%3E`        |
| `/`          | `%2F`        | `?`        | `%3F`        |

For example, given the Git connection string:

```text
http://username:pa55w#rd@github.com/path/to/repository.git
```

Encode the `#` in the password to `%23`:

```text
http://username:pa55w%23rd@github.com/path/to/repository.git
```

### Complex String Configuration in TOML {#toml-raw-string}

In DataKit's TOML configurations, many settings involve strings. To avoid escaping complex characters, use TOML's raw string syntax. For example, if a string contains double quotes:

```toml
some_config = "this-string-contains-\"-and-others"
```

This can be simplified to:

```toml
some_config = '''this-string-contains-"-and-others'''
```

## Further Reading {#more}

- [DataKit K8s Installation and Configuration](datakit-daemonset-deploy.md)
- [Managing Collector Configurations via Git](git-config-how-to.md)