
# Consul
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Consul collector is used to collect metric data related to Consul, and currently it only supports data in Prometheus format.

## Preconditions {#requirements}

- Installing consul-exporter
  - Download consul_exporter package

    ```shell
    sudo wget https://github.com/prometheus/consul_exporter/releases/download/v0.7.1/consul_exporter-0.7.1.linux-amd64.tar.gz
    ```
  - Unzip consul_exporter package

    ```shell
    sudo tar -zxvf consul_exporter-0.7.1.linux-amd64.tar.gz  
    ```
  - Go to the consul_exporter-0.7.1.linux-amd64 directory and run the consul_exporter script

    ```shell
    ./consul_exporter     
    ```

## Configuration {#input-config}

=== "host installation"

    Go to the `conf.d/consul` directory under the DataKit installation directory, copy `consul.conf.sample` and name it `consul.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.prom]]
      ## Exporter 地址
      url = "http://127.0.0.1:9107/metrics"
    
      ## 采集器别名
      source = "consul"
    
      ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
      # 默认只采集 counter 和 gauge 类型的指标
      # 如果为空，则不进行过滤
      metric_types = ["counter", "gauge"]
    
      ## 指标名称过滤
      # 支持正则，可以配置多个，即满足其中之一即可
      # 如果为空，则不进行过滤
      metric_name_filter = ["consul_raft_leader", "consul_raft_peers", "consul_serf_lan_members", "consul_catalog_service", "consul_catalog_service_node_healthy", "consul_health_node_status", "consul_serf_lan_member_status"]
    
      ## 指标集名称前缀
      # 配置此项，可以给指标集名称添加前缀
      measurement_prefix = ""
    
      ## 过滤tags, 可配置多个tag
      # 匹配的tag将被忽略
      tags_ignore = ["check"]
    
      ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
      interval = "10s"
    
      ## 自定义指标集名称
      # 可以将包含前缀prefix的指标归为一类指标集
      # 自定义指标集名称配置优先measurement_name配置项
      [[inputs.prom.measurements]]
      	prefix = "consul_"
    	name = "consul"
    
    ```
    
    After configuration, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}



### `consul_host`

- tag


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名称|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`catalog_service`|集群中服务数量|int|count|
|`raft_leader`|raft集群中leader数量|int|count|
|`raft_peers`|raft集群中peer数量|int|count|
|`serf_lan_members`|集群中成员数量|int|count|



### `consul_service`

- tag


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名称|
|`node`|结点名称|
|`service_id`|服务id|
|`service_name`|服务名称|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`catalog_service_node_healthy`|该服务在该结点上是否健康|int|-|



### `consul_health`

- tag


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名称|
|`node`|结点名称|
|`status`|状态，status有critical, maintenance, passing,warning四种|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`health_node_status`|结点的健康检查状态|int|-|



### `consul_member`

- tag


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名称|
|`member`|成员名称|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`serf_lan_member_status`|集群里成员的状态，其中1表示Alive，2表示Leaving，3表示Left，4表示Failed|int|-|



## Logs {#logging}

If you need to collect the log of Consul, you need to use the-syslog parameter when opening Consul, for example:

```shell
consul agent -dev -syslog
```

To use the logging collector to collect logs, you need to configure the logging collector. Go to the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample` and name it  `logging.conf`.
The configuration is as follows:

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

Original log:

```
Sep 18 19:30:23 derrick-ThinkPad-X230 consul[11803]: 2021-09-18T19:30:23.522+0800 [INFO]  agent.server.connect: initialized primary datacenter CA with provider: provider=consul
```

The list of cut fields is as follows:

| Field name      | Field value                                                             | Description     |
| ---         | ---                                                                | ---      |
| `date`      | `2021-09-18T19:30:23.522+0800`                                     | log date |
| `level`     | `INFO`                                                             | log level |
| `character` | `agent.server.connect`                                             | role     |
| `msg`       | `initialized primary datacenter CA with provider: provider=consul` | log content |
