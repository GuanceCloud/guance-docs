
# System
---

## 视图预览

系统性能指标展示，包括 CPU 平均负载，在线用户数，系统运行时间等

![image](../imgs/input-system-1.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 安装部署

说明：示例 Linux 版本为：CentOS Linux release 7.8.2003 (Core)，Windows 版本请修改对应的配置文件

### 前置条件

- 服务器 <[安装 DataKit](../datakit/datakit-install.md)>

### 配置实施

(Linux / Windows 环境相同)

#### 指标采集 (默认)

1、 System 数据采集默认开启，对应配置文件 /usr/local/datakit/conf.d/host/system.conf

参数说明

- interval：数据采集频率
```
[[inputs.system]]
  interval = '10s'
```

2、 System 指标采集验证  /usr/local/datakit/datakit -M |egrep "最近采集|system"

![image](../imgs/input-system-2.png)

指标预览

![image](../imgs/input-system-3.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 system 指标都会带有 app = oa 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../best-practices/insight/tag.md)>

```
# 示例
[inputs.system.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```
## 场景视图

<场景 - 新建仪表板 - 内置模板库 - System 监控视图>

## 监控规则

<监控 - 监控器 - 从模板新建 - 主机检测库>

## 指标详解

| 指标 | 描述 | 数据类型 | 单位 |
| --- | --- | --- | --- |
| `cpu_usage` | cpu使用占比（%*100），进程自启动以来所占 CPU 百分比，该值相对会比较稳定（跟 top 的瞬时百分比不同） | float | percent |
| `mem_used_percent` | mem使用占比（%*100） | float | percent |
| `open_files` | open_files 个数(仅支持linux) | int | count |
| `rss` | Resident Set Size （常驻内存大小） | int | B |
| `threads` | 线程数 | int | count |

## 常见问题排查

<[无数据上报排查](../datakit/why-no-data.md)>

## 进一步阅读
<[主机可观测最佳实践](../best-practices/monitoring/host-linux)>

