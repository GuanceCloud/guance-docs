
# PHP-FPM
---

## 视图预览

PHP-FPM 指标展示，包括运行时间，活跃进程，慢请求，请求队列等

![image](../imgs/input-fph-1.png)

## 版本支持

操作系统支持：Linux / Windows 

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>
- 服务器安装 Telegraf
- PHP 开启 status 页面

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

2、 安装 telegraf

```
yum -y install telegraf
```

3、 开启 PHP status 页面，编辑 /etc/php-fpm.d/www.conf (以实际文件为准)

```
pm.status_path = /status
```

4、 重启 php-fpm

```
systemctl restart php-fpm
```

## 安装配置

说明：示例 Linux 版本为 CentOS Linux release 7.8.2003 (Core)，Windows 版本请修改对应的配置文件

### 部署实施

#### 指标采集 (必选)

1、 数据上传至 DataKit，修改主配置文件 telegraf.conf

```
vi /etc/telegraf/telegraf.conf
```

2、 关闭 influxdb，开启 outputs.http (修改对应的行)

```
#[[outputs.influxdb]]
[[outputs.http]]
url = "http://127.0.0.1:9529/v1/write/metric?input=telegraf"
```

3、 关闭主机检测 (否则会与 datakit 冲突)

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

4、 开启 PHP-FPM 检测

主要参数说明

- urls：检测地址/域名 (支持 http/unixsocket/fcgi 三种方式)
- timeout：超时时间
```
[[inputs.phpfpm]]
  urls = ["fcgi://127.0.0.1:9000/status"]
  timeout = 5
```

5、 启动 Telegraf

```
systemctl start telegraf
```

6、  指标验证

```
/usr/bin/telegraf --config /etc/telegraf/telegraf.conf --input-filter phpfpm --test
```

有数据返回 (行协议)，代表能够正常采集

![image](../imgs/input-fph-2.png)

7、 指标预览

![image](../imgs/input-fph-3.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 phpfpm 指标都会带有 app = oa 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../../best-practices/insight/tag.md)>

```
# 示例
[inputs.phpfpm.tags]
   app = "oa"
```

重启 Telegraf

```
systemctl restart telegraf
```

## 场景视图

<场景 - 新建仪表板 - 内置模板库 - PHP-FPM 监控视图>

## 检测库

<监控 - 监控器 - 从模板新建 - PHP-FPM 检测库>

## 指标详解

| 指标 | 描述 | 数据类型 |
| --- | --- | --- |
| accepted_conn | 当前池接受的请求数 | int |
| start_since | 运行时间 | int |
| listen_queue | 请求等待队列 | int |
| max_listen_queue | 请求等待队列最高的数量 | int |
| listen_queue_len | socket 等待队列长度 | int |
| idle_processes | 空闲进程 | int |
| active_processes | 活跃进程 | int |
| total_processes | 进程总数 | int |
| max_active_processes | 最大的活跃进程数量 | int |
| slow_requests | 慢请求 | int |
| max_children_reached | 进程最大数量限制的次数 | int |

## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>



