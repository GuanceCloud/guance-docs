
# IPMI_Sensor
---

### 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>
- 服务器安装 Telegraf

### 安装 Telegraf

离线方式：

1、 下载安装包 [[Telegraf 官方文档](https://docs.influxdata.com/telegraf/v1.19/introduction/installation/)]

2、 解压缩

```
tar xf telegraf-1.23.4_static_linux_amd64.tar.gz -C /usr/local/
mv /usr/local/telegraf-1.23.4/ /usr/local/telegraf
```

3、 添加启动命令 

```
vi /usr/lib/systemd/system/telegraf.service
```

```
[Unit]
Description=The plugin-driven server agent for reporting metrics into InfluxDB
Documentation=https://github.com/influxdata/telegraf
After=network.target

[Service]
EnvironmentFile=-/etc/default/telegraf
User=root
ExecStart=/usr/local/telegraf/usr/bin/telegraf -config /usr/local/telegraf/etc/telegraf/telegraf.conf -config-directory /usr/local/telegraf/etc/telegraf/telegraf.d $TELEGRAF_OPTS
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
RestartForceExitStatus=SIGPIPE
KillMode=control-group

[Install]
WantedBy=multi-user.target
```

### 部署实施

#### 指标采集 (必选)

1、 数据上传至 datakit，修改主配置文件 `telegraf.conf`

```
vi /usr/local/telegraf/etc/telegraf/telegraf.conf
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

4、 开启 IPMI 检测 (需要安装 ipmitool，修改 userid、password、ip)

```
[[inputs.ipmi_sensor]]
  path = "/usr/bin/ipmitool"
  servers = ["userid:password@lan(ip)"]
  interval = "60s"
  timeout = "20s"
  metric_version = 2
```

5、 启动 Telegraf

```
systemctl start telegraf
```

6、 指标验证

```
/usr/local/telegraf/usr/bin/telegraf --config /usr/local/telegraf/etc/telegraf/telegraf.conf --input-filter ipmi_sensor --test
```

7、 重启 telegraf

```
systemctl restart telegraf
```
