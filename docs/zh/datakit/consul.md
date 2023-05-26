
# Consul
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Consul 采集器用于采集 Consul 相关的指标数据，目前只支持 Prometheus 格式的数据

## 前置条件 {#requirements}

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

## 配置 {#input-config}

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

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

<!-- markdownlint-enable -->

## 指标集 {#measurements}



### `consul`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|主机名称|
|`member`|成员名称|
|`node`|结点名称|
|`service_id`|服务 ID|
|`service_name`|服务名称|
|`status`|状态。status 有 critical/maintenance/passing/warning 四种|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`catalog_service_node_healthy`|该服务在该结点上是否健康|int|-|
|`catalog_services`|集群中服务数量|int|count|
|`health_node_status`|结点的健康检查状态|int|-|
|`raft_leader`|raft 集群中 leader 数量|int|count|
|`raft_peers`|raft 集群中 peer 数量|int|count|
|`serf_lan_member_status`|集群里成员的状态。其中 1 表示 Alive/2 表示 Leaving/3 表示 Left/4 表示 Failed|int|-|
|`serf_lan_members`|集群中成员数量|int|count|



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
