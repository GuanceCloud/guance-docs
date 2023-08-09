---
title     : 'Aerospike'
summary   : '采集 Aerospike 相关指标信息'
__int_icon: 'icon/aerospike'
dashboard :
  - desc  : 'Aerospike Namespace Overview 监控视图'
    path  : 'dashboard/zh/aerospike_namespace'
  - desc  : 'Aerospike Monitoring Stack Node 监控视图'
    path  : 'dashboard/zh/aerospike_stack_node'
monitor   :
  - desc  : 'Aerospike 检测库'
    path  : 'monitor/zh/aerospike'
---

<!-- markdownlint-disable MD025 -->
# Aerospike
<!-- markdownlint-enable -->
---

:fontawesome-brands-linux: :fontawesome-brands-windows: · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---
Aerospike Namespace 性能指标展示，包括集群、空间下的内存使用情况、磁盘使用、对象数、读写速率等。

Aerospike Node 相关指标展示，包括 Node 集群、Node 状态、记录数、内存、磁盘指标等。




## 安装配置 {#config}

### 前置条件 {#requirement}

- Aerospike 已安装

示例 Aerospike 版本为 Linux 环境 6.0.0 (CentOS)，各个不同版本指标可能存在差异。

`aerospike-prometheus-exporter` 为官方研发的 Exporter ，方便快速接入监控 Aerospike。

### 指标采集

#### 安装 exporter

官方下载&安装 exporter 地址 [https://docs.aerospike.com/monitorstack/install/linux](https://docs.aerospike.com/monitorstack/install/linux)

```shell
wget https://www.aerospike.com/download/monitoring/aerospike-prometheus-exporter/latest/artifact/rpm -O aerospike-prometheus-exporter.tgz
tar -xvzf aerospike-prometheus-exporter.tgz
```

```shell
rpm -Uvh aerospike-prometheus-exporter--x86_64.rpm
```

#### 配置 exporter

配置文件地址 `/etc/aerospike-prometheus-exporter/ape.toml`，默认 metrics 端口为 9145，默认采集端口为 3000，默认情况下不需要调整配置文件。

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

# Number of histogram buckets to export for latency metrics. Bucket thresholds range from 2^0 to 2^16 (17 buckets).
# e.g. latency_buckets_count=5 will export first five buckets i.e. <=1ms, <=2ms, <=4ms, <=8ms and <=16ms.
# Default: 0 (export all threshold buckets).
latency_buckets_count = 0

# Metrics Allowlist - If specified, only these metrics will be scraped. An empty list will exclude all metrics.
# Commenting out the below allowlist configs will disable metrics filtering (i.e. all metrics will be scraped).

# Namespace metrics allowlist
# namespace_metrics_allowlist = []

# Set metrics allowlist
# set_metrics_allowlist = []

# Node metrics allowlist
# node_metrics_allowlist = []

# XDR metrics allowlist (only for Aerospike versions 5.0 and above)
# xdr_metrics_allowlist = []

# Job (scans/queries) metrics allowlist
# job_metrics_allowlist = []

# Secondary index metrics allowlist
# sindex_metrics_allowlist = []

# Metrics Blocklist - If specified, these metrics will be NOT be scraped.

# Namespace metrics blocklist
# namespace_metrics_blocklist = []

# Set metrics blocklist
# set_metrics_blocklist = []

# Node metrics blocklist
# node_metrics_blocklist = []

# XDR metrics blocklist (only for Aerospike versions 5.0 and above)
# xdr_metrics_blocklist = []

# Job (scans/queries) metrics blocklist
# job_metrics_blocklist = []

# Secondary index metrics blocklist
# sindex_metrics_blocklist = []

# Users Statistics (user statistics are available in Aerospike 5.6+)
# Users Allowlist and Blocklist to control for which users their statistics should be collected.
# Note globbing patterns are not supported for this configuration.

# user_metrics_users_allowlist = []
# user_metrics_users_blocklist = []
```

#### 启动（重启）exporter

```shell
systemctl start aerospike-prometheus-exporter.service
```

```shell
systemctl restart aerospike-prometheus-exporter.service
```

#### 访问指标

通过 `curl http://localhost:9145/metrics` 访问指标。

#### DataKit 新增 `aerospike-prom.conf` 配置文件 {#input-config}

在 `/usr/local/datakit/conf.d/prom`目录下，复制 `prom.conf.sample` 为 `aerospike-prom.conf`

```shell
cp prom.conf.sample aerospike-prom.conf
```

主要参数说明

- url：`aerospike-prometheus-exporter` 指标地址
- interval：采集频率
- source：采集器别名

```toml
[[inputs.prom]]
  urls = ["http://192.168.0.189:9145/metrics"]
  ## 忽略对 url 的请求错误
  ignore_req_err = false
  ## 采集器别名
  source = "aerospike"
  metric_types = []
  measurement_prefix = ""
  ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"
  ## TLS 配置
  tls_open = false
  ## 自定义Tags
  [inputs.prom.tags]
```

#### 重启 DataKit

```shell
systemctl restart datakit
```

## 日志采集 {#logging}

### 参数说明

```txt
- logfiles：日志文件路径 (通常填写访问日志和错误日志)
- source：`aerospike` # 数据源
- service：`aerospike` #服务名
```

在`/usr/local/datakit/conf.d`目录下，复制一份 conf，重命名为`logging-aerospike.conf`

```shell
cp logging.conf.sample logging-aerospike.conf
```

### `logging-aerospike.conf`全文

```toml
[[inputs.logging]]
## required
logfiles = [
"/var/log/aerospike/aerospike.log",
]

## glob filteer
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

## datakit read text from Files or Socket , default max_textline is 32k
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

## 指标详解 {#metric}

[参照 Aerospike 官网指标](https://docs.aerospike.com/server/operations/monitor/key_metrics)

