# DiskIO

---

## 视图预览

DiskIO 性能指标展示，包括磁盘读写、磁盘读写时间、IOPS 等。

![image](../../imgs/input-diskio-1.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 前置条件

- 服务器 <[安装 DataKit](../../../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为 CentOS Linux release 7.8.2003 (Core)，Windows 版本请修改对应的配置文件。

(Linux / Windows 环境相同)

### 指标采集 (默认)

1、 DiskIO 数据采集默认开启，对应配置文件 `/usr/local/datakit/conf.d/host/diskio.conf`

参数说明

- interval：数据采集频率
- devices：设备名称 (支持正则匹配)
- skip_serial_number：是否忽略序列号 (默认忽略)
- device_tags：设备标签
- name_templates：名称模板 (设备标签关联)

```
[[inputs.disk]]
  interval = '10s'
  # devices = ['''^sda\d*''', '''^sdb\d*''', '''vd.*''']
  # skip_serial_number = true
  # device_tags = ["ID_FS_TYPE", "ID_FS_USAGE"]
  # name_templates = ["$ID_FS_LABEL","$DM_VG_NAME/$DM_LV_NAME", "$device:$ID_FS_TYPE"]
```

2、 指标预览

![image](../../imgs/input-diskio-3.png)

### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 DiskIO 指标都会带有 `app = "oa"` 的标签，可以进行快速查询
- 相关文档 <[TAG 在观测云中的最佳实践](../../../best-practices/insight/tag.md)>

```
# 示例
[inputs.diskio.tags]
   app = "oa"
```

重启 Datakit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - DiskIO 监控视图>

## 异常检测

<监控 - 监控器 - 从模板新建 - 主机检测库>

## [指标详解](../../../../datakit/diskio#measurements)

## 常见问题排查

<[无数据上报排查](../../../datakit/why-no-data.md)>

Q： Windows 服务器 DiskIO 数据无法正常采集<br />
A：需要先开启磁盘性能计数器 (Powershell 执行命令)，并重启 DataKit

```
diskperf  -Y
```

## 进一步阅读

<[主机可观测最佳实践](../../../best-practices/monitoring/host-linux.md)>
