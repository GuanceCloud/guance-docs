---
title     : 'Aerospike'
summary   : 'Collect Aerospike related Metrics information'
__int_icon: 'icon/aerospike'
dashboard :
  - desc  : 'Aerospike Namespace Overview monitoring view'
    path  : 'dashboard/en/aerospike_namespace'
  - desc  : 'Aerospike Monitoring Stack Node monitoring view'
    path  : 'dashboard/en/aerospike_stack_node'
monitor   :
  - desc  : 'Aerospike detection library'
    path  : 'monitor/en/aerospike'
---

<!-- markdownlint-disable MD025 -->
# Aerospike
<!-- markdownlint-enable -->
---

:fontawesome-brands-linux: :fontawesome-brands-windows: · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---
Display of Aerospike Namespace performance Metrics, including memory usage under clusters and namespaces, disk usage, number of objects, read/write rates, etc.

Display of Aerospike Node related Metrics, including Node clusters, Node status, number of records, memory, disk Metrics, etc.



## Installation Configuration {#config}

### Prerequisites {#requirement}

- Aerospike is installed

The example Aerospike version is Linux environment 6.0.0 (CentOS), and Metrics may vary across different versions.

`aerospike-prometheus-exporter` is an official Exporter developed for easy integration into monitoring Aerospike.

### Metrics Collection

#### Install exporter

Official download & installation address [https://docs.aerospike.com/monitorstack/install/linux](https://docs.aerospike.com/monitorstack/install/linux)

```shell
wget https://www.aerospike.com/download/monitoring/aerospike-prometheus-exporter/latest/artifact/rpm -O aerospike-prometheus-exporter.tgz
tar -xvzf aerospike-prometheus-exporter.tgz
```

```shell
rpm -Uvh aerospike-prometheus-exporter--x86_64.rpm
```

#### Configure exporter

Configuration file location `/etc/aerospike-prometheus-exporter/ape.toml`, the default metrics port is 9145, the default collection port is 3000, and in most cases, there is no need to adjust the configuration file.

```toml
[Agent]
# Exporter HTTPS (TLS) configuration
# HTTPS between Prometheus and Exporter

# TLS certificates.
# Supports below formats,
# 1. Certificate file path                                      - "file:<file-path>"
# 2. Environment variable containing base64 encoded certificate - "env-b64:<environment-variable-that-contains-base64-encoded-certificate>"
# 3. Base64 encoded certificate                                 - "b64:<base64-encoded-certificate>"
# Applicable to 'root_ca', 'cert_file' and 'key_file' configurations.

# Server certificate
cert_file = ""

# Private key associated with server certificate
key_file = ""

# Root CA to validate client certificates (for mutual TLS)
root_ca = ""

# Passphrase for encrypted key_file. Supports below formats,
# 1. Passphrase directly                                                      - "<passphrase>"
# 2. Passphrase via file                                                      - "file:<file-that-contains-passphrase>"
# 3. Passphrase via environment variable                                      - "env:<environment-variable-that-holds-passphrase>"
# 4. Passphrase via environment variable containing base64 encoded passphrase - "env-b64:<environment-variable-that-contains-base64-encoded-passphrase>"
# 5. Passphrase in base64 encoded form                                        - "b64:<base64-encoded-passphrase>"
key_file_passphrase = ""

# labels to add to the prometheus metrics for e.g. labels={zone="asia-south1-a", platform="google compute engine"}
labels = {}

bind = ":9145"

# metrics server timeout in seconds
timeout = 10

# Exporter logging configuration
# Log file path (optional, logs to console by default)
# Level can be info|warning,warn|error,err|debug|trace ('info' by default)
log_file = ""
log_level = ""

# Basic HTTP authentication for '/metrics'.
# Supports below formats,
# 1. Credential directly                                                      - "<credential>"
# 2. Credential via file                                                      - "file:<file-that-contains-credential>"
# 3. Credential via environment variable                                      - "env:<environment-variable-that-contains-credential>"
# 4. Credential via environment variable containing base64 encoded credential - "env-b64:<environment-variable-that-contains-base64-encoded-credential>"
# 5. Credential in base64 encoded form                                        - "b64:<base64-encoded-credential>"
basic_auth_username = ""
basic_auth_password = ""

[Aerospike]
db_host = "localhost"
db_port = 3000

# TLS certificates.
# Supports below formats,
# 1. Certificate file path                                      - "file:<file-path>"
# 2. Environment variable containing base64 encoded certificate - "env-b64:<environment-variable-that-contains-base64-encoded-certificate>"
# 3. Base64 encoded certificate                                 - "b64:<base64-encoded-certificate>"
# Applicable to 'root_ca', 'cert_file' and 'key_file' configurations.

# root certificate file
root_ca = ""

# certificate file
cert_file = ""

# key file
key_file = ""

# Passphrase for encrypted key_file. Supports below formats,
# 1. Passphrase directly                                                      - "<passphrase>"
# 2. Passphrase via file                                                      - "file:<file-that-contains-passphrase>"
# 3. Passphrase via environment variable                                      - "env:<environment-variable-that-holds-passphrase>"
# 4. Passphrase via environment variable containing base64 encoded passphrase - "env-b64:<environment-variable-that-contains-base64-encoded-passphrase>"
# 5. Passphrase in base64 encoded form                                        - "b64:<base64-encoded-passphrase>"
key_file_passphrase = ""

# node TLS name for authentication
node_tls_name = ""

# Aerospike cluster security credentials.
# Supports below formats,
# 1. Credential directly                                                      - "<credential>"
# 2. Credential via file                                                      - "file:<file-that-contains-credential>"
# 3. Credential via environment variable                                      - "env:<environment-variable-that-contains-credential>"
# 4. Credential via environment variable containing base64 encoded credential - "env-b64:<environment-variable-that-contains-base64-encoded-credential>"
# 5. Credential in base64 encoded form                                        - "b64:<base64-encoded-credential>"
# Applicable to 'user' and 'password' configurations.

# database user
user = ""

# database password
password = ""

# authentication mode: internal (for server), external (LDAP, etc.)
auth_mode = ""

# timeout for sending commands to the server node in seconds
timeout = 5

# Number of histogram buckets to export for latency Metrics. Bucket thresholds range from 2^0 to 2^16 (17 buckets).
# e.g. latency_buckets_count=5 will export first five buckets i.e. <=1ms, <=2ms, <=4ms, <=8ms and <=16ms.
# Default: 0 (export all threshold buckets).
latency_buckets_count = 0

# Metrics Allowlist - If specified, only these Metrics will be scraped. An empty list will exclude all Metrics.
# Commenting out the below allowlist configs will disable Metrics filtering (i.e. all Metrics will be scraped).

# Namespace Metrics allowlist
# namespace_metrics_allowlist = []

# Set Metrics allowlist
# set_metrics_allowlist = []

# Node Metrics allowlist
# node_metrics_allowlist = []

# XDR Metrics allowlist (only for Aerospike versions 5.0 and above)
# xdr_metrics_allowlist = []

# Job (scans/queries) Metrics allowlist
# job_metrics_allowlist = []

# Secondary index Metrics allowlist
# sindex_metrics_allowlist = []

# Metrics Blocklist - If specified, these Metrics will NOT be scraped.

# Namespace Metrics blocklist
# namespace_metrics_blocklist = []

# Set Metrics blocklist
# set_metrics_blocklist = []

# Node Metrics blocklist
# node_metrics_blocklist = []

# XDR Metrics blocklist (only for Aerospike versions 5.0 and above)
# xdr_metrics_blocklist = []

# Job (scans/queries) Metrics blocklist
# job_metrics_blocklist = []

# Secondary index Metrics blocklist
# sindex_metrics_blocklist = []

# Users Statistics (user statistics are available in Aerospike 5.6+)
# Users Allowlist and Blocklist to control for which users their statistics should be collected.
# Note globbing patterns are not supported for this configuration.

# user_metrics_users_allowlist = []
# user_metrics_users_blocklist = []
```

#### Start (Restart) exporter

```shell
systemctl start aerospike-prometheus-exporter.service
```

```shell
systemctl restart aerospike-prometheus-exporter.service
```

#### Access Metrics

Access Metrics through `curl http://localhost:9145/metrics`.

#### Add `aerospike-prom.conf` configuration file in DataKit {#input-config}

In the `/usr/local/datakit/conf.d/prom` directory, copy `prom.conf.sample` as `aerospike-prom.conf`

```shell
cp prom.conf.sample aerospike-prom.conf
```

Key parameters explanation:

- url: Address of `aerospike-prometheus-exporter` Metrics
- interval: Collection frequency
- source: Collector alias

```toml
[[inputs.prom]]
  urls = ["http://192.168.0.189:9145/metrics"]
  ## Ignore request errors to the url
  ignore_req_err = false
  ## Collector alias
  source = "aerospike"
  metric_types = []
  measurement_prefix = ""
  ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"
  ## TLS configuration
  tls_open = false
  ## Custom Tags
  [inputs.prom.tags]
```

#### Restart DataKit

```shell
systemctl restart datakit
```

## Log Collection {#logging}

### Parameter Explanation

```txt
- logfiles: Log file paths (usually access logs and error logs)
- source: `aerospike` # Data source
- service: `aerospike` # Service name
```

In the `/usr/local/datakit/conf.d` directory, copy a conf file and rename it to `logging-aerospike.conf`

```shell
cp logging.conf.sample logging-aerospike.conf
```

### Full content of `logging-aerospike.conf`

```toml
[[inputs.logging]]
## required
logfiles = [
"/var/log/aerospike/aerospike.log",
]

## glob filter
ignore = [""]

## your logging source, if it's empty, use 'default'
source = "aerospike"

## add service tag, if it's empty, use $source.
service = "aerospike"

## grok pipeline script name
pipeline = ""

## optional status:
##   "emerg","alert","critical","error","warning","info","debug","OK"
ignore_status = []

## optional encodings:
##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
character_encoding = ""

## datakit reads text from Files or Socket, default max_textline is 32k
## If your log text line exceeds 32Kb, please configure the length of your text,
## but the maximum length cannot exceed 32Mb
# maximum_length = 32766

## The pattern should be a regexp. Note the use of '''this regexp'''
## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
# multiline_match = '''^\S'''

## removes ANSI escape codes from text strings
remove_ansi_escape_codes = false

## if file is inactive, it is ignored
## time units are "ms", "s", "m", "h"
ignore_dead_log = "10m"

[inputs.logging.tags]
# some_tag = "some_value"
  # more_tag = "some_other_value"
```

## Metrics Details {#metric}

[Refer to Aerospike official Metrics](https://docs.aerospike.com/server/operations/monitor/key_metrics)

---

This translation retains the original Markdown and YAML formatting while translating the content into English. Special terms like "Metrics," "Namespace," and "Node" have been preserved as they are commonly used in technical contexts in English.