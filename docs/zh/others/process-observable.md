# 如何开启进程监测
---

## 简介

<<< custom_key.brand_name >>>支持对系统中各种运行的进程进行实施监测， 获取、分析进程运行时各项指标，包括内存使用率、占用CPU时间、进程当前状态、进程监听的端口等，通过开启进程采集器，您可以通过「基础设施」快速查看和分析进程运行时的各项指标信息，配置相关告警，了解进程的状态，在进程发生故障时，可以及时对发生故障的进程进行维护。

## 前置条件

- 您需要先创建一个 [<<< custom_key.brand_name >>>账号](https://www.guance.com/)
- 安装 DataKit（[DataKit 安装文档](../datakit/datakit-install.md)）
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

## 方法/步骤

### Step1：开启进程采集器

在宿主机/服务器上完成 DataKit 安装后，自动开启主机相关的采集器，包括进程对象采集器，更多配置可参考 [采集器配置](../datakit/datakit-input-conf.md)。 

| 采集器名称       | 说明                                           |
| ---------------- | ---------------------------------------------- |
| `cpu`            | 采集主机的 CPU 使用情况                        |
| `disk`           | 采集磁盘占用情况                               |
| `diskio`         | 采集主机的磁盘 IO 情况                         |
| `mem`            | 采集主机的内存使用情况                         |
| `swap`           | 采集 Swap 内存使用情况                         |
| `system`         | 采集主机操作系统负载                           |
| `net`            | 采集主机网络流量情况                           |
| `host_processes` | 采集主机上常驻（存活 10min 以上）进程列表      |
| `hostobject`     | 采集主机基础信息（如操作系统信息、硬件信息等） |
| `container`      | 采集主机上可能的容器对象以及容器日志           |

### Step2：开启进程的指标采集

进程采集器默认不采集进程指标数据，如需采集指标相关数据，您可以在 `host_processes.conf` 中 将 `open_metric` 设置为 `true`。配置过程如下：

1. 进入 DataKit 安装目录下的 `conf.d/host` 目录
1. 复制 `host_processes.conf.sample` 并命名为 `host_processes.conf` 
1. 打开  `host_processes.conf` ，将`open_metric` 设置为 `true`。示例如下：

```toml
[[inputs.host_processes]]
  # Only collect these matched process' metrics. For process objects
  # these white list not applied. Process name support regexp.
  # process_name = [".*nginx.*", ".*mysql.*"]

  # Process minimal run time(default 10m)
  # If process running time less than the setting, we ignore it(both for metric and object)
  min_run_time = "10m"

  ## Enable process metric collecting
  open_metric = true

  # Extra tags
  [inputs.host_processes.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

4. 配置完成后， 使用命令 datakit --restart，重启datakit 即可生效。

若您通过 [K8S daemonset 安装 DataKit](../datakit/datakit-daemonset-deploy) ，支持以环境变量的方式修改进程采集器的配置参数。更多详情可参考文档 [进程采集器](../integrations/host_processes.md)。

| 环境变量名                              | 对应的配置参数项 | 参数示例                                                     |
| --------------------------------------- | :--------------- | :----------------------------------------------------------- |
| `ENV_INPUT_HOST_PROCESSES_OPEN_METRIC`  | `open_metric`    | `true`/`false`                                               |
| `ENV_INPUT_HOST_PROCESSES_TAGS`         | `tags`           | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
| `ENV_INPUT_HOST_PROCESSES_PROCESS_NAME` | `process_name`   | `".*datakit.*", "guance"` 以英文逗号隔开                     |
| `ENV_INPUT_HOST_PROCESSES_MIN_RUN_TIME` | `min_run_time`   | `"10m"`                                                      |

