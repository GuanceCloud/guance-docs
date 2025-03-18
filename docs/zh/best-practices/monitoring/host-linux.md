# 主机可观测最佳实践 (Linux)

---

## 基本概述

Linux，全称 GNU/Linux，是一套免费使用和自由传播的类 Unix 操作系统，作为企业中应用最为广泛的操作系统，其稳定性必然成为最重要的一环，<<< custom_key.brand_name >>>通过多年的客户经验积累，实现了主机可观测的全覆盖，帮助客户快速洞察基础设施运行情况，大幅缩减运维成本。

## 场景概览

< <<< custom_key.brand_name >>> - 场景 - 仪表板 - 新建仪表板 - 主机概览_Linux >

![image.png](../images/host-linux-1.png)
![image.png](../images/host-linux-2.png)
![image.png](../images/host-linux-3.png)
![image.png](../images/host-linux-4.png)
![image.png](../images/host-linux-5.png)
![image.png](../images/host-linux-6.png)

## 前置条件

前往官方网站 [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/) 注册账号，使用已注册的账号/密码进行登录。

## 部署实施

### 一键安装

DataKit 是<<< custom_key.brand_name >>>官方发布的数据采集应用，支持上百种数据的采集。

登陆<<< custom_key.brand_name >>>控制台，点击「集成」 - 「DataKit」，复制命令行并直接在服务器运行。

![image.png](../images/host-linux-7.png)

### 默认路径

| 目录         | 路径                                   |
| ------------ | -------------------------------------- |
| 安装目录     | /usr/local/datakit/                    |
| 日志目录     | /var/log/datakit/                      |
| 主配置文件   | /usr/local/datakit/conf.d/datakit.conf |
| 插件配置目录 | /usr/local/datakit/conf.d/             |

### 默认插件

安装完成后，会默认开启一些插件(数据采集)，可以在主配置文件中查看 `datakit.conf` 

```bash
default_enabled_inputs = ["cpu", "disk", "diskio", "mem", "swap", "hostobject", "net", "host_processes", "container", "system"]
```

插件说明：

指标数据可以在 [ <<< custom_key.brand_name >>> - 指标 ] 中查看，对象数据可以直接在相关页面查看

| 插件名称       | 说明                                           | 数据类型 |
| -------------- | ---------------------------------------------- | -------- |
| cpu            | 采集主机的 CPU 使用情况                        | 指标     |
| disk           | 采集磁盘占用情况                               | 指标     |
| diskio         | 采集主机的磁盘 IO 情况                         | 指标     |
| mem            | 采集主机的内存使用情况                         | 指标     |
| swap           | 采集 Swap 内存使用情况                         | 指标     |
| system         | 采集主机操作系统负载                           | 指标     |
| net            | 采集主机网络流量情况                           | 指标     |
| host_processes | 采集主机上常驻（存活 10min 以上）进程列表      | 对象     |
| hostobject     | 采集主机基础信息（如操作系统信息、硬件信息等） | 对象     |

## 数据采集

使用<<< custom_key.brand_name >>>查看指标时，可以通过标签进行快速的条件筛选

### 默认采集

#### CPU 指标

[ <<< custom_key.brand_name >>> - 指标 - cpu，查看 cpu 状态数据 ]
[ <<< custom_key.brand_name >>> - 指标 - systecm，查看 cpu 负载以及核数数据 ]

![image.png](../images/host-linux-8.png)

#### 内存指标

[ <<< custom_key.brand_name >>> - 指标 - mem，查看内存数据 ]
[ <<< custom_key.brand_name >>> - 指标 - swap，查看内存 swap 数据 ]

![image.png](../images/host-linux-9.png)

#### 磁盘指标

[ <<< custom_key.brand_name >>> - 指标 - disk，查看磁盘数据 ]
[ <<< custom_key.brand_name >>> - 指标 - disk，查看磁盘 IO 数据 ]

![image.png](../images/host-linux-10.png)

#### 网络指标

[ <<< custom_key.brand_name >>> - 指标 - net，查看网络数据 ]

![image.png](../images/host-linux-11.png)

#### 主机对象

[ <<< custom_key.brand_name >>> - 基础设施 - 主机，查看所有主机对象列表 ]

![image.png](../images/host-linux-12.png)

[ <<< custom_key.brand_name >>> - 基础设施 - 主机 - 点击任意主机，查看基本系统信息 ]

_集成运行情况代表该服务器上已经运行的插件列表_

![image.png](../images/host-linux-13.png)

#### 进程对象

[ <<< custom_key.brand_name >>> - 基础设施 - 进程，查看所有进程对象列表 ]

![image.png](../images/host-linux-14.png)

[ <<< custom_key.brand_name >>> - 基础设施 - 进程 - 点击任意进程名称，查看该进程相关信息 ]

![image.png](../images/host-linux-15.png)

### 进阶采集

DataKit 除了默认的一些指标/对象数据外，还可以通过其他插件完善操作系统的监控数据

#### 进程列表

想要了解所有主机实时进程列表信息，可以开启进程插件 (全局 top 功能)

1.进入插件配置目录，复制 sample 文件

```bash
cd /usr/local/datakit/conf.d/host/
cp host_processes.conf.sample host_processes.conf
vi host_processes.conf
```

2.开启进程插件

```bash
[[inputs.host_processes]]
  min_run_time = "10m"
  open_metric = true
```

3.重启 datakit

```bash
systemctl restart datakit
```

[ <<< custom_key.brand_name >>> - 指标 - host_processes，查看进程数据 ]

![image.png](../images/host-linux-16.png)

#### 网口指标

使用 ebpf 技术采集主机网络接口 tcp/udp 连接信息

1.安装 ebpf 插件

```bash
datakit install --datakit-ebpf
```

2.进入插件配置目录，复制 sample 文件

```bash
cd /usr/local/datakit/conf.d/host
cp ebpf.conf.sample ebpf.conf
vi ebpf.conf
```

3.开启 ebpf 插件

```bash
[[inputs.ebpf]]
  daemon = true
  name = 'ebpf'
  cmd = "/usr/local/datakit/externals/datakit-ebpf"
  args = ["--datakit-apiserver", "0.0.0.0:9529"]
  enabled_plugins = ["ebpf-net"]
```

4.重启 datakit

```bash
systemctl restart datakit
```

[ <<< custom_key.brand_name >>> - 基础设施 - 主机 - 点击安装了 ebpf 插件的主机 - 网络，查看系统网络接口信息 ]

![image.png](../images/host-linux-17.png)

#### 安全巡检

针对主机操作系统上的安全漏洞进行实时检测

1.安装 Scheck 服务

```bash
bash -c "$(curl https://static.dataflux.cn/security-checker/install.sh)"
```

安装说明

| 目录         | 路径                          |
| ------------ | ----------------------------- |
| 安装目录     | /usr/local/scheck             |
| 日志目录     | /usr/local/scheck/log         |
| 主配置文件   | /usr/local/scheck/scheck.conf |
| 检测规则目录 | /usr/local/scheck/rules.d     |

2.修改主配置文件

```bash
rule_dir='/usr/local/scheck/rules.d'
output='http://127.0.0.1:9529/v1/write/security'
log='/usr/local/scheck/log'
log_level='info'
```

3.启动服务

```bash
systemctl start scheck
```

[ <<< custom_key.brand_name >>> - 安全巡检 - 查看器，查看所有安全事件 ]

![image.png](../images/host-linux-18.png)

### 扩展采集

DataKit 除了自身的数据采集外，还完美兼容 telegraf 采集器

安装 Telegraf ，以 CentOS 为例，其他系统参考 [Telegraf 官方文档](https://docs.influxdata.com/telegraf/v1.19/introduction/installation/)

1.添加 yum 源

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

2.安装 telegraf 采集器

```bash
yum -y install telegraf
```

3.修改主配置文件 telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

4.关闭 influxdb，开启 outputs.http (使数据上传至 datakit)

```bash
#[[outputs.influxdb]]
[[outputs.http]]
url = "http://127.0.0.1:9529/v1/write/metric?input=telegraf"
```

5.关闭 telegraf 默认采集

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

6.启动 telegraf

```bash
systemctl start telegraf
```

#### 端口指标

对于操作系统中重要端口进行检测

1.修改主配置文件 telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

2.开启端口检测

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

3.重启 telegraf

```bash
systemctl restart telegraf
```

[ <<< custom_key.brand_name >>> - 指标 - net_response，查看端口数据 ]

![image.png](../images/host-linux-19.png)

#### 进程指标

对于操作系统中重要进程进行检测

1.修改主配置文件 telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

2.开启进程检测

```bash
[[inputs.procstat]]
    pattern = "zookeeper"
[[inputs.procstat]]
    pattern = "httpd"
```

3.重启 telegraf

```bash
systemctl restart telegraf
```

[ <<< custom_key.brand_name >>> - 指标 - procstat，查看进程数据 ]

![image.png](../images/host-linux-20.png)

#### 单点拨测

以本机为拨测点，对于重要接口/站点进行检测

多点拨测可以查看 可用性监测

1.修改主配置文件 telegraf.conf

```bash
vi /etc/telegraf/telegraf.conf
```

2.开启 http 检测

```bash
[[inputs.http_response]]
    urls = ["https://www.baidu.com","https://<<< custom_key.brand_main_domain >>>","http://localhost:9090"]
```

3.重启 telegraf

```bash
systemctl restart telegraf
```

[ <<< custom_key.brand_name >>> - 指标 - http_response，查看拨测数据 ]

![image.png](../images/host-linux-21.png)

## 监控规则

用于设置报警规则以及通知对象，实时了解系统稳定情况

### 内置模板

<<< custom_key.brand_name >>>已经内置了一些检测库模板，可以直接使用

[ <<< custom_key.brand_name >>> - 监控 - 从模板创建 - 主机检测库]
[ <<< custom_key.brand_name >>> - 监控 - 从模板创建 - Ping 状态检测库]
[ <<< custom_key.brand_name >>> - 监控 - 从模板创建 - Port 检测库]

### 自定义检测库

通过自定义的方式添加检测规则，<<< custom_key.brand_name >>>支持多种检测，例如阈值、进程，日志，网络检测

#### 阈值检测

[ <<< custom_key.brand_name >>> - 监控 - 新建监控器 - 阈值检测 ]

检测指标：报警规则表达式，其中 <mem> 为数据表，<used_percent> 为监控指标，<host> 为标签 (只有 by 条件里的标签才可以被事件内容引用)

![image.png](../images/host-linux-22.png)

触发条件：最终的阈值范围，达到条件触发报警；触发后，再次检测如果未达阈值，可恢复 (需要在 正常 里填写检测周期)

![image.png](../images/host-linux-23.png)

事件名称/内容可以进行变量引用，事件内容采用 markdown 文本格式 (例如换行为两个空格)

![image.png](../images/host-linux-24.png)

## 通知对象

自定义设置报警规则通知对象

[ <<< custom_key.brand_name >>> - 管理 - 通知对象 ]

![image.png](../images/host-linux-25.png)

根据监控器分组，添加通知对象

[ <<< custom_key.brand_name >>> - 监控 - 监控器 - 分组 - 告警配置 ]

![image.png](../images/host-linux-26.png)
