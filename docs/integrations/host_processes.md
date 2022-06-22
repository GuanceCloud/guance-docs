
# 进程
---

- DataKit 版本：1.4.3
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

# host_processes

进程采集器可以对系统中各种运行的进程进行实施监控， 获取、分析进程运行时各项指标，包括内存使用率、占用CPU时间、进程当前状态、进程监听的端口等，并根据进程运行时的各项指标信息，用户可以在观测云中配置相关告警，使用户了解进程的状态，在进程发生故障时，可以及时对发生故障的进程进行维护。

> 注：进程采集器（不管是对象还是指标），在 macOS 上可能消耗比较大，导致 CPU 飙升，可以手动将其关闭。目前默认采集器仍然开启进程对象采集器（默认 5min 运行一次）。

## 前置条件

- 进程采集器默认不采集进程指标数据，如需采集指标相关数据，可在 `host_processes.conf` 中 将 `open_metric` 设置为 `true`。比如：
                              
```toml
[[inputs.host_processes]]
	...
	 open_metric = true
```

## 配置

进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `host_processes.conf.sample` 并命名为 `host_processes.conf`。示例如下：

```toml

[[inputs.host_processes]]
  # Only collect these matched process' metrics. For process objects
  # these white list not applied. Process name support regexp.
  # process_name = [".*nginx.*", ".*mysql.*"]

  # Process minimal run time(default 10m)
  # If process running time less than the setting, we ignore it(both for metric and object)
  min_run_time = "10m"

  ## Enable process metric collecting
  open_metric = false

  # Extra tags
  [inputs.host_processes.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...

```

配置好后，重启 DataKit 即可。

支持以环境变量的方式修改配置参数（只在 DataKit 以 K8s daemonset 方式运行时生效，主机部署的 DataKit 不支持此功能）：

| 环境变量名                              | 对应的配置参数项 | 参数示例                                                     |
| :---                                    | ---              | ---                                                          |
| `ENV_INPUT_HOST_PROCESSES_OPEN_METRIC`  | `open_metric`    | `true`/`false`                                               |
| `ENV_INPUT_HOST_PROCESSES_TAGS`         | `tags`           | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
| `ENV_INPUT_HOST_PROCESSES_PROCESS_NAME` | `process_name`   | `".*datakit.*", "guance"` 以英文逗号隔开                     |
| `ENV_INPUT_HOST_PROCESSES_MIN_RUN_TIME` | `min_run_time`   | `"10m"`                                                      |

## 视图预览

Processes 性能指标展示，包括 CPU 使用率，内存使用率，线程数，打开的文件数等

![image](imgs/input-host-processes-1.png)

## 版本支持

操作系统支持：Linux / Windows / Mac

## 前置条件

- 服务器 <[安装 Datakit](../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为：CentOS Linux release 7.8.2003 (Core)

### 部署实施

(Linux / Windows 环境相同)

#### 指标采集 (必选)

1、开启 Datakit Processes 插件，复制 sample 文件

```
cd /usr/local/datakit/conf.d/host/
cp host_processes.conf.sample host_processes.conf
```

2、修改配置文件 host_processes.conf

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

3、Processes 指标采集验证  /usr/local/datakit/datakit -M |egrep "最近采集|host_processes"

![image](imgs/input-host-processes-2.png)

指标预览

![image](imgs/input-host-processes-3.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 processes 指标都会带有 app = oa 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../best-practices/guance-skill/tag.md)>

```
# 示例
[inputs.host_processes.tags]
   app = "oa"
```

重启 Datakit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 内置模板库 - Processes>

## 异常检测

<监控 - 模板新建 - 主机检测库>

## 指标详解

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.host_processes.tags]` 指定其它标签：

``` toml
 [inputs.host_processes.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

### 指标





#### `host_processes`

采集进程指标数据,包括cpu内存使用率等

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|
|`pid`|进程id|
|`process_name`|进程名|
|`username`|用户名|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`cpu_usage`|cpu使用占比（%*100），进程==自启动以来==所占 CPU 百分比，该值相对会比较稳定（==跟 top 的瞬时百分比不同==）|float|percent|
|`cpu_usage_top`|cpu使用占比（%*100）, 一个采集周期内的进程的 CPU 使用率均值|float|percent|
|`mem_used_percent`|mem使用占比（%*100）|float|percent|
|`open_files`|open_files 个数(仅支持linux)|int|count|
|`rss`|Resident Set Size （常驻内存大小）|int|B|
|`threads`|线程数|int|count|








### 对象









#### `host_processes`

采集进程对象的数据，包括进程名，cmd等

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`class`|分类: host_processes|
|`host`|主机名|
|`listen_ports`|进程正在监听的端口|
|`name`|name 字段，由 host_pid 组成|
|`process_name`|进程名|
|`state`|进程状态，暂不支持 windows|
|`username`|用户名|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`cmdline`|进程的命令行参数|string|-|
|`cpu_usage`|cpu使用占比（%*100），进程==自启动以来==所占 CPU 百分比，该值相对会比较稳定（==跟 top 的瞬时百分比不同==）|float|percent|
|`cpu_usage_top`|cpu使用占比（%*100）, 一个采集周期内的进程的 CPU 使用率均值|float|percent|
|`mem_used_percent`|mem使用占比（%*100）|float|percent|
|`message`|进程详细信息|string|-|
|`open_files`|open_files 个数(仅支持linux)|int|count|
|`pid`|进程id|int|-|
|`rss`|Resident Set Size （常驻内存大小）|int|B|
|`start_time`|进程启动时间|int|msec|
|`state_zombie`|是否是僵尸进程|bool|-|
|`threads`|线程数|int|count|
|`work_directory`|工作目录(仅支持linux)|string|-|




## 常见问题排查

<[无数据上报排查](why-no-data.md)>

## 进一步阅读

<[主机可观测最佳实践](./best-practices/integrations/host.md)>
