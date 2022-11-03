# CPU

---

## 视图预览

CPU 性能指标展示，包括 CPU 使用率、IO 等待、用户态、核心态、软中断、硬中断等。

![image](../../imgs/input-cpu-1.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 前置条件

- 服务器 <[安装 DataKit](../../../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为 CentOS Linux release 7.8.2003 (Core)，Windows 版本请修改对应的配置文件。

### 部署实施

(Linux / Windows 环境相同)

#### 指标采集 (默认)

1、 CPU 数据采集默认开启，对应配置文件 `/usr/local/datakit/conf.d/host/cpu.conf`

参数说明

- interval：数据采集频率
- percpu：是否开启每核 cpu 指标 (不开启仅采集 cpu-total)
- enable_temperature：是否开启 cpu 温度指标 (仅对有温度传感器的服务器生效)

```
[[inputs.cpu]]
  interval = '10s'
  percpu = false
  enable_temperature = true
```

2、 CPU 指标采集验证 `/usr/local/datakit/datakit -M |egrep "最近采集|cpu"`

![image](../../imgs/input-cpu-2.png)

指标预览

![image](../../imgs/input-cpu-3.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 cpu 指标都会带有 `app = "oa"` 的标签，可以进行快速查询
- 相关文档 <[TAG 在观测云中的最佳实践](../../../best-practices/insight/tag.md)>

```
# 示例
[inputs.cpu.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - CPU 监控视图>

## 监控规则

<监控 - 监控器 - 从模板新建 - 主机检测库>

## [指标详解](../../../../datakit/cpu#measurements)

## 常见问题排查

<[无数据上报排查](../../../datakit/why-no-data.md)>

## 进一步阅读

<[主机可观测最佳实践](../../../best-practices/monitoring/host-linux.md)>
