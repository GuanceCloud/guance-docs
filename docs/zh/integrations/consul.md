---
title     : 'Consul'
summary   : '采集 Consul 的指标数据'
__int_icon      : 'icon/consul'
tags:
  - '中间件'
dashboard :
  - desc  : 'Consul'
    path  : 'dashboard/zh/consul'
monitor   :
  - desc  : 'Consul'
    path  : 'monitor/zh/consul'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Consul 采集器用于采集 Consul 相关的指标数据，目前只支持 Prometheus 格式的数据

## 配置 {#config}

### 前置条件 {#requirements}

安装 consul-exporter

- 下载 consul_exporter 压缩包

```shell
sudo wget https://github.com/prometheus/consul_exporter/releases/download/v0.7.1/consul_exporter-0.7.1.linux-amd64.tar.gz
```

- 解压 `consul_exporter` 压缩包

```shell
sudo tar -zxvf consul_exporter-0.7.1.linux-amd64.tar.gz  
```

- 进入 *consul_exporter-0.7.1.linux-amd64* 目录，运行 `consul_exporter` 脚本

```shell
./consul_exporter     
```

### 采集器配置 {input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/consul` 目录，复制 `consul.conf.sample` 并命名为 `consul.conf`。示例如下：
    
    ```toml
        
    [[inputs.prom]]
      url = "http://127.0.0.1:9107/metrics"
      source = "consul"
      metric_types = ["counter", "gauge"]
      metric_name_filter = ["consul_raft_leader", "consul_raft_peers", "consul_serf_lan_members", "consul_catalog_service", "consul_catalog_service_node_healthy", "consul_health_node_status", "consul_serf_lan_member_status"]
      measurement_prefix = ""
      tags_ignore = ["check"]
      interval = "10s"
    
    [[inputs.prom.measurements]]
      prefix = "consul_"
      name = "consul"
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

<!-- markdownlint-enable -->

## 指标 {#metric}



### `consul`

- 标签


| Tag | Description |
|  ----  | --------|
|`check`|Check.|
|`check_id`|Check id.|
|`check_name`|Check name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`key`|Key.|
|`member`|Member name.|
|`node`|Node name.|
|`service_id`|Service id.|
|`service_name`|Service name.|
|`status`|Status: critical, maintenance, passing, warning.|
|`tag`|Tag.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`catalog_kv`|The values for selected keys in Consul's key/value catalog. Keys with non-numeric values are omitted.|float|-|
|`catalog_service_node_healthy`|Is this service healthy on this node?|float|bool|
|`catalog_services`|How many services are in the cluster.|float|count|
|`health_node_status`|Status of health checks associated with a node.|float|bool|
|`health_service_status`|Status of health checks associated with a service.|float|bool|
|`raft_leader`|Does Raft cluster have a leader (according to this node).|float|bool|
|`raft_peers`|How many peers (servers) are in the Raft cluster.|float|count|
|`serf_lan_member_status`|Status of member in the cluster. 1=Alive, 2=Leaving, 3=Left, 4=Failed.|float|-|
|`serf_lan_members`|How many members are in the cluster.|float|count|
|`serf_wan_member_status`|SStatus of member in the wan cluster. 1=Alive, 2=Leaving, 3=Left, 4=Failed.|float|-|
|`service_checks`|Link the service id and check name if available.|float|bool|
|`service_tag`|Tags of a service.|float|count|
|`up`|Was the last query of Consul successful.|float|bool|



## 日志 {#logging}

如需采集 Consul 的日志，需要在开启 Consul 的时候，使用 -syslog 参数，例如

```shell
consul agent -dev -syslog
```

使用 logging 采集器采集日志，需要配置 logging 采集器。
进入 DataKit 安装目录下的 `conf.d/log` 目录，复制 `logging.conf.sample` 并命名为 `logging.conf`。
配置如下：

```toml
[[inputs.logging]]
  ## required
  logfiles = [
    "/var/log/syslog",
  ]

  ## glob filteer
  ignore = [""]

  ## your logging source, if it's empty, use 'default'
  source = "consul"

  ## add service tag, if it's empty, use $source.
  service = ""

  ## grok pipeline script path
  pipeline = "consul.p"

  ## optional status:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## optional encodings:
  ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
  character_encoding = ""

  ## The pattern should be a regexp. Note the use of '''this regexp'''
  ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
  multiline_match = '''^\S'''

  [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

日志原文：

```log
Sep 18 19:30:23 derrick-ThinkPad-X230 consul[11803]: 2021-09-18T19:30:23.522+0800 [INFO]  agent.server.connect: initialized primary datacenter CA with provider: provider=consul
```

切割后的字段列表如下：

| 字段名      | 字段值                                                             | 说明     |
| ---         | ---                                                                | ---      |
| `date`      | `2021-09-18T19:30:23.522+0800`                                     | 日志日期 |
| `level`     | `INFO`                                                             | 日志级别 |
| `character` | `agent.server.connect`                                             | 角色     |
| `msg`       | `initialized primary datacenter CA with provider: provider=consul` | 日志内容 |
