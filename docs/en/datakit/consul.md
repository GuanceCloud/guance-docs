
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
    
    After configuration, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}



### `consul`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|主机名称|
|`member`|成员名称|
|`node`|结点名称|
|`service_id`|服务 ID|
|`service_name`|服务名称|
|`status`|状态。status 有 critical/maintenance/passing/warning 四种|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`catalog_service_node_healthy`|该服务在该结点上是否健康|int|-|
|`catalog_services`|集群中服务数量|int|count|
|`health_node_status`|结点的健康检查状态|int|-|
|`raft_leader`|raft 集群中 leader 数量|int|count|
|`raft_peers`|raft 集群中 peer 数量|int|count|
|`serf_lan_member_status`|集群里成员的状态。其中 1 表示 Alive/2 表示 Leaving/3 表示 Left/4 表示 Failed|int|-|
|`serf_lan_members`|集群中成员数量|int|count|



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
