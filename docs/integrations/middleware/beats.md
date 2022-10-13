
# Beats
---

## 视图预览

Beats 指标展示，包括 CPU 负载、内存、事件、配置、输出流量等。

![image](../imgs/input-beats-1.png)

## 版本支持

操作系统支持：Linux / Windows 

## 前置条件

- 服务器 <[安装 Datakit](../../datakit/datakit-install.md)>
- 服务器安装 Telegraf
- Beats 应用开启 HTTP endpoint

### 安装 Telegraf

以 **CentOS** 为例，其他系统参考 [[Telegraf 官方文档](https://docs.influxdata.com/telegraf/v1.19/introduction/installation/)]

1、 添加 yum 源

```
cat <<EOF | tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
```

2、 安装 Telegraf

```
yum -y install telegraf
```

3、 开启 endpoint，修改主配置文件 xxx.yml

```
http.enabled: true
http.host: localhost
http.port: 5066
```

4、 重启 Beats 

```
systemctl restart xxxbeats
```

## 安装配置

说明：示例 Linux 版本为 CentOS Linux release 7.8.2003 (Core)，Windows 版本请修改对应的配置文件

### 部署实施

#### 指标采集 (必选)

1、 数据上传至 DataKit，修改主配置文件 `telegraf.conf`

```
vi /etc/telegraf/telegraf.conf
```

2、 关闭 InfluxDB，开启 outputs.http (修改对应的行)

```
#[[outputs.influxdb]]
[[outputs.http]]
url = "http://127.0.0.1:9529/v1/write/metric?input=telegraf"
```

3、 关闭主机检测 (否则会与 DataKit 冲突)

```
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

4、 开启 Beats 检测

主要参数说明

- urls：beats 检测地址 (默认 5066 端口)
- include：数据采集的状态列表
- timeout：超时时间
```
[[inputs.beat]]
  url = "http://127.0.0.1:5066"
  include = ["beat","system","libbeat","filebeat"]
  timeout = "5s"
```

5、 启动 Telegraf

```
systemctl start telegraf
```

6、 指标验证

```
/usr/bin/telegraf --config /etc/telegraf/telegraf.conf --input-filter beat --test
```

有数据返回 (行协议)，代表能够正常采集

![image](../imgs/input-beats-2.png)

7、 指标预览

![image](../imgs/input-beats-3.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 Beats 指标都会带有 app = oa 的标签，可以进行快速查询
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
# 示例
[inputs.beat.tags]
   app = "oa"
```

重启 Telegraf

```
systemctl restart telegraf
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Beats 监控视图>

## 指标详解

**主要指标**

| 指标 | 描述 | 数据类型 |
| --- | --- | --- |
| memstats_memory_alloc | 内存分配 | int |
| memstats_memory_total | 内存总量 | int |
| memstats_rss | 真实内存 | int |
| events_active | 活跃事件 | int |
| events_added | 添加事件 | int |
| events_done | 已完成事件 | int |
| config_reloads | 配置重载次数 | int |
| output_read_bytes | 读取字节数 | int |
| output_write_bytes | 写入字节数 | int |
| load_1 | CPU  1分钟负载 | int |
| load_5 | CPU 5 分钟负载 | int |
| load_15 | CPU 15 分钟负载 | int |

## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>

## 进一步阅读

<[Elastic Beats 数据采集](https://www.elastic.co/beats/)>
