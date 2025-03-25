# Host Observability Best Practices (Linux)

---

## Basic Overview

Linux, fully named GNU/Linux, is a freely usable and freely distributable Unix-like operating system. As the most widely used operating system in enterprises, its stability is necessarily the most critical aspect. <<< custom_key.brand_name >>> has achieved full coverage of host observability through years of customer experience accumulation, helping customers quickly understand the operation of their infrastructure and drastically reducing maintenance costs.

## Scene Overview

< <<< custom_key.brand_name >>> - Scene - Dashboard - Create Dashboard - Host Overview_Linux >

![image.png](../images/host-linux-1.png)
![image.png](../images/host-linux-2.png)
![image.png](../images/host-linux-3.png)
![image.png](../images/host-linux-4.png)
![image.png](../images/host-linux-5.png)
![image.png](../images/host-linux-6.png)

## Prerequisites

Go to the official website [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/) to register an account, and log in using the registered account/password.

## Deployment Implementation

### One-Click Installation

DataKit is the official data collection application released by <<< custom_key.brand_name >>>, supporting the collection of hundreds of types of data.

Log in to the <<< custom_key.brand_name >>> console, click on "Integration" - "DataKit", copy the command line and run it directly on the server.

![image.png](../images/host-linux-7.png)

### Default Paths

| Directory         | Path                                   |
| ------------ | -------------------------------------- |
| Installation Directory     | /usr/local/datakit/                    |
| Log Directory     | /var/log/datakit/                      |
| Main Configuration File   | /usr/local/datakit/conf.d/datakit.conf |
| Plugin Configuration Directory | /usr/local/datakit/conf.d/             |

### Default Plugins

After installation, some plugins (data collection) will be enabled by default. These can be viewed in the main configuration file `datakit.conf`.

```bash
default_enabled_inputs = ["cpu", "disk", "diskio", "mem", "swap", "hostobject", "net", "host_processes", "container", "system"]
```

Plugin Description:

Metric data can be viewed in [ <<< custom_key.brand_name >>> - Metrics ], and object data can be viewed directly on relevant pages.

| Plugin Name       | Description                                           | Data Type |
| -------------- | ---------------------------------------------- | -------- |
| cpu            | Collects CPU usage information from the host                     | Metrics     |
| disk           | Collects disk usage information                               | Metrics     |
| diskio         | Collects disk IO usage information from the host                 | Metrics     |
| mem            | Collects memory usage information from the host                  | Metrics     |
| swap           | Collects Swap memory usage information                         | Metrics     |
| system         | Collects operating system load information from the host          | Metrics     |
| net            | Collects network traffic information from the host               | Metrics     |
| host_processes | Collects a list of resident processes (alive for over 10 minutes) on the host | Objects     |
| hostobject     | Collects basic host information (such as OS information, hardware information, etc.) | Objects     |

## Data Collection

When viewing metrics with <<< custom_key.brand_name >>>, you can use tags for quick condition filtering.

### Default Collection

#### CPU Metrics

[ <<< custom_key.brand_name >>> - Metrics - cpu, view CPU status data ]
[ <<< custom_key.brand_name >>> - Metrics - systecm, view CPU load and core count data ]

![image.png](../images/host-linux-8.png)

#### Memory Metrics

[ <<< custom_key.brand_name >>> - Metrics - mem, view memory data ]
[ <<< custom_key.brand_name >>> - Metrics - swap, view memory swap data ]

![image.png](../images/host-linux-9.png)

#### Disk Metrics

[ <<< custom_key.brand_name >>> - Metrics - disk, view disk data ]
[ <<< custom_key.brand_name >>> - Metrics - disk, view disk IO data ]

![image.png](../images/host-linux-10.png)

#### Network Metrics

[ <<< custom_key.brand_name >>> - Metrics - net, view network data ]

![image.png](../images/host-linux-11.png)

#### Host Objects

[ <<< custom_key.brand_name >>> - Infrastructure - Host, view all host object lists ]

![image.png](../images/host-linux-12.png)

[ <<< custom_key.brand_name >>> - Infrastructure - Host - Click any host to view basic system information ]

_Integration runtime status represents the list of plugins already running on this server_

![image.png](../images/host-linux-13.png)

#### Process Objects

[ <<< custom_key.brand_name >>> - Infrastructure - Process, view all process object lists ]

![image.png](../images/host-linux-14.png)

[ <<< custom_key.brand_name >>> - Infrastructure - Process - Click any process name to view related process information ]

![image.png](../images/host-linux-15.png)

### Advanced Collection

In addition to the default metric/object data, DataKit can also complete operating system monitoring data through other plugins.

#### Process List

To understand real-time process list information for all hosts, enable the process plugin (global top functionality).

1. Enter the plugin configuration directory and copy the sample file

```bash
cd /usr/local/datakit/conf.d/host/
cp host_processes.conf.sample host_processes.conf
vi host_processes.conf
```

2. Enable the process plugin

```bash
[[inputs.host_processes]]
  min_run_time = "10m"
  open_metric = true
```

3. Restart DataKit

```bash
systemctl restart datakit
```

[ <<< custom_key.brand_name >>> - Metrics - host_processes, view process data ]

![image.png](../images/host-linux-16.png)

#### Network Interface Metrics

Use ebpf technology to collect tcp/udp connection information for the host's network interface.

1. Install the ebpf plugin

```bash
datakit install --datakit-ebpf
```

2. Enter the plugin configuration directory and copy the sample file

```bash
cd /usr/local/datakit/conf.d/host
cp ebpf.conf.sample ebpf.conf
vi ebpf.conf
```

3. Enable the ebpf plugin

```bash
[[inputs.ebpf]]
  daemon = true
  name = 'ebpf'
  cmd = "/usr/local/datakit/externals/datakit-ebpf"
  args = ["--datakit-apiserver", "0.0.0.0:9529"]
  enabled_plugins = ["ebpf-net"]
```

4. Restart DataKit

```bash
systemctl restart datakit
```

[ <<< custom_key.brand_name >>> - Infrastructure - Host - Click on the host where the ebpf plugin is installed - Network, view system network interface information ]

![image.png](../images/host-linux-17.png)

#### Security Check

Perform real-time detection of security vulnerabilities on the host operating system.

1. Install the Scheck service

```bash
bash -c "$(curl https://static.dataflux.cn/security-checker/install.sh)"
```

Installation Instructions

| Directory         | Path                          |
| ------------ | ----------------------------- |
| Installation Directory     | /usr/local/scheck             |
| Log Directory     | /usr/local/scheck/log         |
| Main Configuration File   | /usr/local/scheck/scheck.conf |
| Detection Rule Directory | /usr/local/scheck/rules.d     |

2. Modify the main configuration file

```bash
rule_dir='/usr/local/scheck/rules.d'
output='http://127.0.0.1:9529/v1/write/security'
log='/usr/local/scheck/log'
log_level='info'
```

3. Start the service

```bash
systemctl start scheck
```

[ <<< custom_key.brand_name >>> - Security Check - Explorer, view all security events ]

![image.png](../images/host-linux-18.png)

### Extended Collection

In addition to its own data collection, DataKit is fully compatible with the telegraf collector.

Install Telegraf, taking CentOS as an example; for other systems, refer to the [Telegraf Official Documentation](https://docs.influxdata.com/telegraf/v1.19/introduction/installation/)

1. Add yum source

```bash
cat <<EOF | tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
```

2. Install the telegraf collector

```bash
yum -y install telegraf
```

3. Modify the main configuration file telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

4. Disable influxdb, enable outputs.http (to upload data to datakit)

```bash
#[[outputs.influxdb]]
[[outputs.http]]
url = "http://127.0.0.1:9529/v1/write/metric?input=telegraf"
```

5. Disable telegraf default collection

```bash
#[[inputs.cpu]]
#  percpu = true
#  totalcpu = true
#  collect_cpu_time = false
#  report_active = false
#[[inputs.disk]]
#  ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]
#[[inputs.diskio]]
#[[inputs.mem]]
#[[inputs.processes]]
#[[inputs.swap]]
#[[inputs.system]]
```

6. Start telegraf

```bash
systemctl start telegraf
```

#### Port Metrics

Detect important ports in the operating system.

1. Modify the main configuration file telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

2. Enable port detection

```bash
[[inputs.net_response]]
  protocol = "tcp"
  address = "localhost:9090"
  timeout = "3s"
[[inputs.net_response]]
  protocol = "tcp"
  address = "localhost:22"
  timeout = "3s"
```

3. Restart telegraf

```bash
systemctl restart telegraf
```

[ <<< custom_key.brand_name >>> - Metrics - net_response, view port data ]

![image.png](../images/host-linux-19.png)

#### Process Metrics

Detect important processes in the operating system.

1. Modify the main configuration file telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

2. Enable process detection

```bash
[[inputs.procstat]]
    pattern = "zookeeper"
[[inputs.procstat]]
    pattern = "httpd"
```

3. Restart telegraf

```bash
systemctl restart telegraf
```

[ <<< custom_key.brand_name >>> - Metrics - procstat, view process data ]

![image.png](../images/host-linux-20.png)

#### Single-point Testing

Using the local machine as a testing point, detect important interfaces/sites.

For multi-point testing, see Synthetic Tests.

1. Modify the main configuration file telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

2. Enable HTTP detection

```bash
[[inputs.http_response]]
    urls = ["https://www.baidu.com","https://<<< custom_key.brand_main_domain >>>","http://localhost:9090"]
```

3. Restart telegraf

```bash
systemctl restart telegraf
```

[ <<< custom_key.brand_name >>> - Metrics - http_response, view test data ]

![image.png](../images/host-linux-21.png)

## Monitoring Rules

Used to set alarm rules and notification targets to monitor system stability in real time.

### Built-in Templates

<<< custom_key.brand_name >>> already includes some built-in detection library templates that can be used directly.

[ <<< custom_key.brand_name >>> - Monitoring - Create from Template - Host Detection Library]
[ <<< custom_key.brand_name >>> - Monitoring - Create from Template - Ping Status Detection Library]
[ <<< custom_key.brand_name >>> - Monitoring - Create from Template - Port Detection Library]

### Custom Detection Libraries

Add detection rules through customization. <<< custom_key.brand_name >>> supports multiple detections such as thresholds, processes, logs, and network detection.

#### Threshold Detection

[ <<< custom_key.brand_name >>> - Monitoring - Create Monitor - Threshold Detection ]

Detection Metric: Alarm rule expression, where <mem> is the data table, <used_percent> is the monitoring metric, <host> is the tag (only tags in the by conditions can be referenced in the event content).

![image.png](../images/host-linux-22.png)

Trigger Condition: Final threshold range, triggers an alarm when the condition is met; after triggering, if the threshold is not met again upon rechecking, it can recover (normal needs to have a detection cycle filled out).

![image.png](../images/host-linux-23.png)

Event name/content can reference variables, event content uses markdown text format (for example, a new line requires two spaces).

![image.png](../images/host-linux-24.png)

## Notification Targets

Customize settings for alarm rule notification targets.

[ <<< custom_key.brand_name >>> - Manage - Notification Targets ]

![image.png](../images/host-linux-25.png)

Group monitors and add notification targets according to the monitors.

[ <<< custom_key.brand_name >>> - Monitoring - Monitors - Grouping - Alert Configuration ]

![image.png](../images/host-linux-26.png)