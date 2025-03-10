# Collector Configuration

---

## Introduction {#intro}

DataKit collector configurations all use [TOML format](https://toml.io/en){:target="_blank"}. Each collector is categorized and located in subdirectories under `conf.d`:

- Linux/Mac: `/usr/local/datakit/conf.d/`
- Windows: `C:\Program Files\datakit\conf.d\`

A typical configuration file for a collector has the following structure:

```toml
[[inputs.some_name]] # This line is mandatory, indicating which collector's configuration this TOML file belongs to.
    key = value
    ...

[[inputs.some_name.other_options]] # This line is optional; some collectors have it while others do not.
    key = value
    ...
```

<!-- markdownlint-disable MD046 -->
???+ tip

    Since DataKit only searches for files with the `.conf` extension under the `conf.d/` directory, all collector configurations **must be placed under the `conf.d` directory (or its subdirectories) and must have `.conf` as the file extension**. Otherwise, DataKit will ignore the configuration file.
<!-- markdownlint-enable -->

## Default Enabled Collectors {#default-enabled-inputs}

After installing DataKit, a set of collectors are enabled by default without requiring manual activation. You can also [disable all default collectors as needed](datakit-install.md#common-envs).

Default collectors generally relate to the host and are listed below:

| Collector Name | Description |
| --- | --- |
| [CPU (`cpu`)](../integrations/cpu.md) | Collects CPU usage on the host. |
| [Disk (`disk`)](../integrations/disk.md) | Collects disk usage. |
| [Disk IO (`diskio`)](../integrations/diskio.md) | Collects disk IO metrics on the host. |
| [Memory (`mem`)](../integrations/mem.md) | Collects memory usage on the host. |
| [Swap (`swap`)](../integrations/swap.md) | Collects swap memory usage. |
| [System (`system`)](../integrations/system.md) | Collects operating system load on the host. |
| [Net (`net`)](../integrations/net.md) | Collects network traffic metrics on the host. |
| [Host Processes (`host_processes`)](../integrations/host_processes.md) | Collects a list of long-running processes (surviving more than 10 minutes) on the host. |
| [Host Object (`hostobject`)](../integrations/hostobject.md) | Collects basic information about the host (such as OS and hardware info). |
| [Container (`container`)](../integrations/container.md) | Collects container or Kubernetes data on the host, assuming no containers exist, the collector will exit directly. |
| [DataKit (`dk`)](../integrations/dk.md) | Collects DataKit's own runtime metrics. |

### Removing Default Collectors {#disable-default-inputs}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    If you do not want certain collectors to be enabled, you can disable them by adding a `-` before the collector name:
    
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
    
    Similarly, during installation, you can disable collectors using [this method (`DK_DEF_INPUTS`)](datakit-install.md#common-envs).

=== "Kubernetes"

    Use [environment variables (`ENV_ENABLE_INPUTS`)](datakit-daemonset-deploy.md#env-common) to specify which collectors should be enabled.
<!-- markdownlint-enable -->

## Modifying Collector Configurations {#modify-input-conf}

### Enabling Multiple Instances of the Same Collector {#input-multi-inst}

Taking MySQL as an example, if you need to configure multiple MySQL collectors, there are two methods:

- Method One: Add a new `conf` file, such as `mysql-2.conf`, which can be placed in the same directory as the existing `mysql.conf`.

- Method Two: Add a new section within the existing `mysql.conf` as follows:

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
# Add another one below
#-----------------------------------------
[[inputs.mysql]]
    ...
```

Method Two's multi-instance configuration structure actually forms a TOML array and **is applicable to all collectors that require multiple configurations**, structured as follows:

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

    - Two identical collector configuration files (with different filenames) will result in only one being applied to prevent misconfiguration.
    - It is not recommended to combine configurations for different collectors (e.g., MySQL and Nginx) into one `conf` file, as this may cause issues and is harder to manage.
    - Some collectors are restricted to single-instance operation; see [Single Instance Collectors](#input-singleton).

???+ tip "Comparison of Both Methods"

    - Method One can lead to a cluttered configuration directory.
    - Method Two is simpler to manage, consolidating all instances of the same collector into a single `conf` file.
<!-- markdownlint-enable -->

### Single Instance Collectors {#input-singleton}

Some collectors are restricted to single-instance operation. Even if configured multiple times, only one instance will run. The list of single-instance collectors includes:

| Collector Name | Description |
| --- | --- |
| [`cpu`](../integrations/cpu.md) | Collects CPU usage on the host. |
| [`disk`](../integrations/disk.md) | Collects disk usage. |
| [`diskio`](../integrations/diskio.md) | Collects disk IO metrics on the host. |
| [eBPF](../integrations/ebpf.md) | Collects TCP/UDP connection information, Bash execution logs, etc. on the host. |
| [`mem`](../integrations/mem.md) | Collects memory usage on the host. |
| [`swap`](../integrations/swap.md) | Collects swap memory usage. |
| [`system`](../integrations/system.md) | Collects operating system load on the host. |
| [`net`](../integrations/net.md) | Collects network traffic metrics on the host. |
| [`netstat`](../integrations/netstat.md) | Collects network connection statistics including TCP/UDP connections, waiting connections, pending requests, etc. |
| [Host Processes (`host_processes`)](../integrations/host_processes.md) | Collects a list of long-running processes (surviving more than 10 minutes) on the host. |
| [Host Object (`hostobject`)](../integrations/hostobject.md) | Collects basic information about the host (such as OS and hardware info). |
| [Container (`container`)](../integrations/container.md) | Collects container or Kubernetes data on the host, assuming no containers exist, the collector will exit directly. |
| [DataKit (`dk`)](../integrations/dk.md) | Collects DataKit's own runtime metrics, including CPU, Memory, etc. |

### Disabling Specific Collectors {#disable-inputs}

To disable a specific collector, there are two methods:

<!-- markdownlint-disable MD046 -->
???+ tip "Comparison of Both Methods"

    - Method One is simpler but more brute force.
    - Method Two requires careful editing and can lead to TOML configuration errors.

- Method One: Rename the corresponding collector `conf` file, e.g., rename `mysql.conf` to `mysql.conf.bak`. **Ensure the file extension is not `.conf`.**
- Method Two: Comment out the relevant collector configuration in the `conf` file, for example:

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

# Retain this MySQL collector
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

When editing collector configurations, some parts may require regular expressions.

Since most of DataKit is developed using Golang, the regex patterns used in configurations follow Golang's regex implementation. Differences between regex systems can make it challenging to get configurations right on the first try.

We recommend using an [online tool to debug regex patterns](https://regex101.com/){:target="_blank"}. As shown in the image below:

<figure markdown>
  ![](https://static.guance.com/images/datakit/debug-golang-regexp.png){ width="800" }
</figure>

Additionally, since DataKit configurations use TOML, we suggest using `'''here is a concrete regex pattern'''` (i.e., surrounding the regex with three single quotes) to avoid complex escape sequences.

## Using KV Template Configuration {#kv-template}

KV (key-value pairs) are designed primarily to allow users to edit configuration files via templates more conveniently. For example, sensitive information like passwords and usernames can be securely stored as key-value pairs and referenced in related configuration files.

<!-- markdownlint-disable MD046 -->
???+ attention
    - Only supports host configuration, not [Git](./git-config-how-to.md) or [configuration center](./confd.md) configurations.
    - Only supported in collector configuration files.
<!-- markdownlint-enable -->

### Dynamic Loading Process {#kv-load-flow}

The Guance platform allows users to create or update KV configurations via the web client. DataKit periodically pulls the latest KV configurations from the Guance platform and compares them with the existing configurations in memory. If any changes are detected, DataKit traverses all collector configuration files, replacing old KV values with new ones to identify modified configurations. Once changes are found, all collectors generated from these configuration files are reloaded.

Note that comparisons are made on a per-file basis. This means if a file contains multiple collectors, any modification to the file will trigger a reload of all collectors generated from that file.

<!-- markdownlint-disable MD046 -->
???+ attention
    - If reloading involves HTTP services, such as the `ddtrace` collector, the entire HTTP service will be restarted.
<!-- markdownlint-enable -->

Refer to the diagram below for the complete process:

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

DataKit fetches KV information from the central server and caches it locally in `<DataKit-Install-Dir>/data/.kv` in JSON format. An example configuration is as follows:

```json
{"value":"{\"cpu_kv\": \"cpu_kv_value3\", \"mysql_password\": \"000000\", \"cpu_enable_temperature\": true}","version":10}
```

The `value` field contains the actual KV configuration in `key:value` format, which can be referenced using `{{.key}}` syntax.

The `version` indicates the current configuration version number.

### KV Usage Example {#kv-example}

KV uses [Go template](https://pkg.go.dev/text/template){:target="_blank"} syntax. Below are common usage examples.

- Basic Usage

Assume the following KV configuration:

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

In the configuration file, you can reference KV configurations using `{{.key}}` syntax, as shown in the example below for the MySQL collector:

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

Before loading, DataKit automatically replaces `{{.key}}` with the corresponding KV configuration, enabling dynamic configuration. For easier debugging, refer to [Debugging KV Files](datakit-tools-how-to.md#debug-kv).

- Using Default Values

Sometimes you might want to define a default value for a variable, i.e., specify a default when the variable is undefined or empty. Example usage:

```toml
port = {{.mysql_port | default 3306}}
```

In the above template, if `port` is undefined or empty, it defaults to `3306`.

## Password Configuration Encoding Issues {#password-encode}

When configuring connection strings, if the password contains special characters (like `@#*`), these characters need to be URL-encoded. Below is a list of URL encodings for special characters:

> Note, not all special characters (like `~_-.`) need encoding, but they are included here for reference.

| Character | URL Encoding | Character | URL Encoding |
| --- | --- | --- | --- |
| `` ` `` | `%60` | `~` | `~` |
| `!` | `%21` | `@` | `%40` |
| `#` | `%23` | `$` | `%24` |
| `%` | `%25` | `^` | `%5E` |
| `&` | `%26` | `*` | `%2A` |
| `(` | `%28` | `)` | `%29` |
| `_` | `_` | `-` | `-` |
| `+` | `%2B` | `=` | `%3D` |
| `{` | `%7B` | `}` | `%7D` |
| `[` | `%5B` | `]` | `%5D` |
| `\` | `%5C` | `:` | `%3A` |
| `|` | `%7C` | `"` | `%22` |
| `'` | `%27` | `;` | `%3B` |
| `,` | `%2C` | `.` | `.` |
| `<` | `%3C` | `>` | `%3E` |
| `/` | `%2F` | `?` | `%3F` |

Assuming we have the following Git connection string:

``` text
http://username:pa55w#rd@github.com/path/to/repository.git
```

Here, we need to convert the `#` in the password to its URL-encoded form `%23`:

``` text
http://username:pa55w%23rd@github.com/path/to/repository.git
```

### Complex String Configuration in TOML {#toml-raw-string}

In DataKit's TOML configurations, many string settings involve complex escaping. To avoid this, you can use TOML's raw string syntax. For example, if a string value contains double quotes:

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