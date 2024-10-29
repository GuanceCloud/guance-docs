---
title     : 'GreenPlum'
summary   : '采集 greenplum 指标信息'
__int_icon: 'icon/greenplum'
dashboard :
  - desc  : 'GreenPlum'
    path  : 'dashboard/zh/greenplum'
monitor   :
  - desc  : 'GreenPlum'
    path  : 'monitor/zh/greenplum'
---

<!-- markdownlint-disable MD025 -->
# GreenPlum
<!-- markdownlint-enable -->

Greenplum 是一个基于大规模并行处理(MPP)架构的高性能、高可用的数据库系统，它主要用于处理和分析大规模数据集。Greenplum 适用于数据仓库、商业智能和大数据分析等场景，特别是在需要处理PB级数据量时，能够提供高效的数据存储和分析能力。Greenplum 的可观测性包括对数据库性能的监控、故障的检测和通知、以及对系统运行状态的可视化。

## 安装配置 {#config}

### 前置条件 {#requirement}

greenplum 5或6版本, 已测试的版本:

- 6.24.3

### Exporter 安装

可从此处下载并安装 [greenplum exporter](https://github.com/tangyibo/greenplum_exporter/releases/tag/v1.1) ，这是一个将 greenplum 指标暴露为 prometheus 的数据采集器，同时支持GP5和GP6.

- 以 CentOS 为例，启动命令如下：

```bash
export GPDB_DATA_SOURCE_URL=postgres://gpadmin:password@10.17.20.11:5432/postgres?sslmode=disable
./greenplum_exporter --web.listen-address="0.0.0.0:9297" --web.telemetry-path="/metrics" --log.level=error
```

- 如果是 Docker 运行，启动命令如下：

```bash
docker run -d -p 9297:9297 -e GPDB_DATA_SOURCE_URL=postgres://gpadmin:password@10.17.20.11:5432/postgres?sslmode=disable inrgihc/greenplum-exporter:latest 
```

注：环境变量 GPDB_DATA_SOURCE_URL 指定了连接 Greenplum 数据库的连接串（请使用 gpadmin 账号连接postgres库），该连接串以postgres://为前缀，具体格式如下：

```bash
postgres://gpadmin:password@10.17.20.11:5432/postgres?sslmode=disable
postgres://[数据库连接账号，必须为gpadmin]:[账号密码，即gpadmin的密码]@[数据库的IP地址]:[数据库端口号]/[数据库名称，必须为postgres]?[参数名]=[参数值]&[参数名]=[参数值] 
```

然后访问监控指标的URL地址：`http://127.0.0.1:9297/metrics`

更多启动参数：

```bash
usage: greenplum_exporter [<flags>]

Flags:
  -h, --help                   Show context-sensitive help (also try --help-long and --help-man).
      --web.listen-address="0.0.0.0:9297"  
                               web endpoint
      --web.telemetry-path="/metrics"
                               Path under which to expose metrics.
      --disableDefaultMetrics  do not report default metric
      (go metrics and process metrics)
      --version                Show application version.
      --log.level="info"       Only log messages with the given severity or above. Valid levels: [debug, info, warn, error, fatal]
      --log.format="logger:stderr"  
                               Set the log target and format. Example: "logger:syslog?appname=bob&local=7" or "logger:stdout?json=true"
```

### 采集器配置

#### 主机安装

- [安装Datakit](https://docs.guance.com/datakit/datakit-install/)
  
#### 配置采集器
由于`greenplum exporter` 能够直接暴露`metrics` url，所以可以直接通过 prom 采集器，配置对应的 url 进行采集。
进入 DataKit 安装目录下的 `conf.d/prom` 目录，复制 `prom.conf.sample` 并命名为 `greenplum.conf`

``` yaml
cp prom.conf.sample greenplum.conf
```

调整`greenplum.conf`内容如下：

```yaml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://127.0.0.1:9297/metrics"]
  ## Collector alias.
  source = "greenplum"
...
```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>，
调整参数说明 ：
<!-- markdownlint-enable -->
- urls：prom 指标地址，这里填写对应 greenplum 暴露出来的指标 url，如果DataKit安装在 greenplum 主机上，默认是`http://127.0.0.1:9297/metrics`
- source：数据源，修改为 greenplum，后续方便筛选指标
- interval：采集间隔

#### 重启Datakit

[重启Datakit](https://docs.guance.com/datakit/datakit-service-how-to/#manage-service)

## 指标 {#metric}

### GreenPlum指标集

| Metrics | 描述 |单位 |
|:--------|:-----|:-- |
|`cluster_state`|`gp 可达状态 ?：1→ 可用;0→ 不可用`|boolean |
|`cluster_uptime`|`启动持续的时间`| s |
|`cluster_max_connections`|`最大连接个数`| int |
|`cluster_total_connections`|`当前连接个数`| int |
|`cluster_idle_connections`|`idle连接数`| int |
|`cluster_active_connections`|`活动连接数`| int |
|`cluster_running_connections`|`正在执行查询的连接数`| int |
|`cluster_waiting_connections`|`等待执行查询的连接数`| int |
|`node_segment_status`|`segment的状态`| int |
|`node_segment_role`|`segment的role角色`| int |
|`node_segment_mode`|`segment的mode`| int |
|`node_segment_disk_free_mb_size`|`segment主机磁盘空间剩余大小（MB)`| MB |
|`cluster_total_connections_per_client`|`每个客户端的total连接数`| int |
|`cluster_idle_connections_per_client`|`每个客户端的idle连接数`| int |
|`cluster_active_connections_per_client`|`每个客户端的active连接数`| int |
|`cluster_total_online_user_count`|`在线账号数`| int |
|`cluster_total_client_count`|`当前所有连接的客户端个数`| int |
|`cluster_total_connections_per_user`|`每个账号的total连接数`| int |
|`cluster_idle_connections_per_user`|`每个账号的idle连接数`| int |
|`cluster_active_connections_per_user`|`每个账号的active连接数`| int |
|`cluster_config_last_load_time_seconds`|`系统配置加载时间`| s |
|`node_database_name_mb_size`|`每个数据库占用的存储空间大小`| MB |
|`node_database_table_total_count`|`每个数据库内表的总数量`| int |
|`exporter_total_scraped`|`成功抓取（scrape）的指标数量`| int |
|`exporter_total_error`|`错误总数`| int |
|`exporter_scrape_duration_second`|`采集数据的持续时间`| s |
|`server_users_name_list`|`用户总数`| int |
|`server_users_total_count`|`用户明细`| int |
|`server_locks_table_detail`|`锁信息`| int |
|`server_database_hit_cache_percent_rate`|`缓存命中率`| float |
|`server_database_transition_commit_percent_rate`|`事务提交率`| float |
|`server_database_table_bloat_list`|`数据膨胀列表`| int |
|`server_locks_table_detail`|`锁信息`| int |
