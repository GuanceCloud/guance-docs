# Best Practices for Host Observability (Linux)

---

## Basic Overview

Linux, fully known as GNU/Linux, is a free-to-use and freely distributed Unix-like operating system. As the most widely used operating system in enterprises, its stability is crucial. Guance, through years of customer experience, has achieved comprehensive host observability, helping customers quickly gain insights into infrastructure operations and significantly reducing maintenance costs.

## Scenario Overview

< Guance - Scenario - Dashboard - Create Dashboard - Host Overview_Linux >

![image.png](../images/host-linux-1.png)
![image.png](../images/host-linux-2.png)
![image.png](../images/host-linux-3.png)
![image.png](../images/host-linux-4.png)
![image.png](../images/host-linux-5.png)
![image.png](../images/host-linux-6.png)

## Prerequisites

Visit the official website [Guance](https://www.guance.com/) to register an account and log in using your registered credentials.

## Deployment Implementation

### One-click Installation

DataKit is the official data collection application released by Guance, supporting the collection of hundreds of types of data.

Log in to the Guance console, click on "Integration" - "DataKit", copy the command line, and run it directly on the server.

![image.png](../images/host-linux-7.png)

### Default Paths

| Directory         | Path                                   |
| ------------ | -------------------------------------- |
| Installation Directory     | /usr/local/datakit/                    |
| Log Directory     | /var/log/datakit/                      |
| Main Configuration File   | /usr/local/datakit/conf.d/datakit.conf |
| Plugin Configuration Directory | /usr/local/datakit/conf.d/             |

### Default Plugins

After installation, some plugins (data collection) are enabled by default, which can be viewed in the main configuration file `datakit.conf`

```bash
default_enabled_inputs = ["cpu", "disk", "diskio", "mem", "swap", "hostobject", "net", "host_processes", "container", "system"]
```

Plugin Description:

Metric data can be viewed in [ Guance - Metrics ], and object data can be viewed directly on the relevant pages.

| Plugin Name       | Description                                           | Data Type |
| -------------- | ---------------------------------------------- | -------- |
| cpu            | Collects CPU usage information                        | Metrics     |
| disk           | Collects disk usage information                               | Metrics     |
| diskio         | Collects disk IO information                         | Metrics     |
| mem            | Collects memory usage information                         | Metrics     |
| swap           | Collects Swap memory usage information                         | Metrics     |
| system         | Collects host OS load information                           | Metrics     |
| net            | Collects network traffic information                           | Metrics     |
| host_processes | Collects long-running (more than 10 minutes) process lists      | Object     |
| hostobject     | Collects basic host information (such as OS information, hardware information, etc.) | Object     |

## Data Collection

When viewing metrics using Guance, you can use tags for quick condition filtering.

### Default Collection

#### CPU Metrics

[ Guance - Metrics - cpu, view CPU status data ]
[ Guance - Metrics - system, view CPU load and core count data ]

![image.png](../images/host-linux-8.png)

#### Memory Metrics

[ Guance - Metrics - mem, view memory data ]
[ Guance - Metrics - swap, view swap memory data ]

![image.png](../images/host-linux-9.png)

#### Disk Metrics

[ Guance - Metrics - disk, view disk data ]
[ Guance - Metrics - diskio, view disk IO data ]

![image.png](../images/host-linux-10.png)

#### Network Metrics

[ Guance - Metrics - net, view network data ]

![image.png](../images/host-linux-11.png)

#### Host Objects

[ Guance - Infrastructure - Host, view all host object lists ]

![image.png](../images/host-linux-12.png)

[ Guance - Infrastructure - Host - Click any host to view basic system information ]

_Integration status represents the list of plugins running on that server_

![image.png](../images/host-linux-13.png)

#### Process Objects

[ Guance - Infrastructure - Process, view all process object lists ]

![image.png](../images/host-linux-14.png)

[ Guance - Infrastructure - Process - Click any process name to view related information ]

![image.png](../images/host-linux-15.png)

### Advanced Collection

In addition to the default metrics/object data, DataKit can enhance OS monitoring data with other plugins.

#### Process List

To get real-time process list information from all hosts, enable the process plugin (global top feature)

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

[ Guance - Metrics - host_processes, view process data ]

![image.png](../images/host-linux-16.png)

#### Network Interface Metrics

Use ebpf technology to collect TCP/UDP connection information from host network interfaces

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

[ Guance - Infrastructure - Host - Click the host with the ebpf plugin installed - Network, view system network interface information ]

![image.png](../images/host-linux-17.png)

#### Security Check

Perform real-time detection of security vulnerabilities on the host operating system

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

[ Guance - Security Check - Explorer, view all security events ]

![image.png](../images/host-linux-18.png)

### Extended Collection

In addition to its own data collection, DataKit is fully compatible with the Telegraf collector.

Install Telegraf, for CentOS as an example, refer to the [Telegraf Official Documentation](https://docs.influxdata.com/telegraf/v1.19/introduction/installation/) for other systems

1. Add yum repository

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

2. Install the Telegraf collector

```bash
yum -y install telegraf
```

3. Modify the main configuration file telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

4. Disable influxdb, enable outputs.http (to upload data to DataKit)

```bash
#[[outputs.influxdb]]
[[outputs.http]]
url = "http://127.0.0.1:9529/v1/write/metric?input=telegraf"
```

5. Disable default Telegraf collections

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

6. Start Telegraf

```bash
systemctl start telegraf
```

#### Port Metrics

Monitor important ports in the operating system

1. Modify the main configuration file telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

2. Enable port monitoring

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

3. Restart Telegraf

```bash
systemctl restart telegraf
```

[ Guance - Metrics - net_response, view port data ]

![image.png](../images/host-linux-19.png)

#### Process Metrics

Monitor important processes in the operating system

1. Modify the main configuration file telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

2. Enable process monitoring

```bash
[[inputs.procstat]]
    pattern = "zookeeper"
[[inputs.procstat]]
    pattern = "httpd"
```

3. Restart Telegraf

```bash
systemctl restart telegraf
```

[ Guance - Metrics - procstat, view process data ]

![image.png](../images/host-linux-20.png)

#### Single-point Dial Testing

Use this machine as a dial test point to monitor important interfaces/sites

For multi-point dial testing, see Synthetic Tests

1. Modify the main configuration file telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

2. Enable HTTP monitoring

```bash
[[inputs.http_response]]
    urls = ["https://www.baidu.com","https://guance.com","http://localhost:9090"]
```

3. Restart Telegraf

```bash
systemctl restart telegraf
```

[ Guance - Metrics - http_response, view dial test data ]

![image.png](../images/host-linux-21.png)

## Monitoring Rules

Set up alert rules and notification targets to understand system stability in real-time

### Built-in Templates

Guance already includes some built-in templates for monitoring libraries, which can be used directly

[ Guance - Monitoring - Create from Template - Host Monitoring Library]
[ Guance - Monitoring - Create from Template - Ping Status Monitoring Library]
[ Guance - Monitoring - Create from Template - Port Monitoring Library]

### Custom Monitoring Libraries

Add monitoring rules via customization; Guance supports multiple types of monitoring, such as thresholds, processes, logs, and network monitoring.

#### Threshold Monitoring

[ Guance - Monitoring - Create Monitor - Threshold Monitoring ]

Monitored metric: Alarm rule expression, where <mem> is the data table, <used_percent> is the monitored metric, and <host> is the tag (only tags in the by clause can be referenced in event content)

![image.png](../images/host-linux-22.png)

Trigger Conditions: Final threshold range, triggering an alarm when conditions are met; after triggering, if the conditions are no longer met, it can recover (specify the check cycle in Normal).

![image.png](../images/host-linux-23.png)

Event names/content can reference variables, and event content uses markdown text format (e.g., a new line is two spaces)

![image.png](../images/host-linux-24.png)

## Notification Targets

Customize alarm rule notification targets

[ Guance - Manage - Notification Targets ]

![image.png](../images/host-linux-25.png)

Group monitors and add notification targets

[ Guance - Monitoring - Monitors - Grouping - Alert Configuration ]

![image.png](../images/host-linux-26.png)