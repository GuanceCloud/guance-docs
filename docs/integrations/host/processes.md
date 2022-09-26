
# Processes
---


## 视图预览

Processes 性能指标展示，包括 CPU 使用率，内存使用率，线程数，打开的文件数等

![image](../imgs/input-processes-1.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 前置条件

- 服务器 <[安装 DataKit](../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为：CentOS Linux release 7.8.2003 (Core)

### 部署实施

(Linux / Windows 环境相同)

#### 指标采集 (必选)

1、 开启 Datakit Processes 插件，复制 sample 文件

```
cd /usr/local/datakit/conf.d/host/
cp host_processes.conf.sample host_processes.conf
```

2、 修改配置文件 host_processes.conf

参数说明

- process_name：进程名称 (不填写代表采集所有进程)
- min_run_time：进程最低运行时间 (默认进程运行 10m 才会被采集)
- open_metric：是否开启指标 (默认 false)

```
[[inputs.host_processes]]
  # process_name = [".*datakit.*"]
  min_run_time = "10m"
  open_metric = true
```

3、 Processes 指标采集验证  /usr/local/datakit/datakit -M |egrep "最近采集|host_processes"

![image](../imgs/input-processes-2.png)

指标预览

![image](../imgs/input-processes-3.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 processes 指标都会带有 app = oa 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../best-practices/insight/tag.md)>

```
# 示例
[inputs.host_processes.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```
## 场景视图

<场景 - 新建仪表板 - 内置模板库 - Processes 监控视图>

## 检测库

<监控 - 监控器 - 从模板新建 - 主机检测库>

## 指标详解

| 指标 | 描述 | 数据类型 | 单位 |
| --- | --- | --- | --- |
| `cpu_usage` | cpu使用占比（%*100），进程自启动以来所占 CPU 百分比，该值相对会比较稳定（跟 top 的瞬时百分比不同） | float | percent |
| `cpu_usage_top` | cpu使用占比（%*100）, 一个采集周期内的进程的 CPU 使用率均值 | float | percent |
| `mem_used_percent` | mem使用占比（%*100） | float | percent |
| `open_files` | open_files 个数(仅支持linux) | int | count |
| `rss` | Resident Set Size （常驻内存大小） | int | B |
| `threads` | 线程数 | int | count |

## 常见问题排查

<[无数据上报排查](../datakit/why-no-data.md)>

## 进一步阅读

<[主机可观测最佳实践](../best-practices/monitoring/host-linux)>

