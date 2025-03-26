---
title     : 'Consul'
summary   : 'Collect metrics of Consul'
tags:
  - 'MIDDLEWARE'
__int_icon      : 'icon/consul'
dashboard :
  - desc  : 'Consul'
    path  : 'dashboard/en/consul'
monitor   :
  - desc  : 'Consul'
    path  : 'monitor/en/consul'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Consul collector is used to collect metric data related to Consul, and currently it only supports data in Prometheus format.

## Configuration {#config}

### Preconditions {#requirements}

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

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
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
    
    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).

<!-- markdownlint-enable -->

## Metric {#metric}



### `consul`

- Tags


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

- Metrics


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

```log
Sep 18 19:30:23 derrick-ThinkPad-X230 consul[11803]: 2021-09-18T19:30:23.522+0800 [INFO]  agent.server.connect: initialized primary datacenter CA with provider: provider=consul
```

The list of cut fields is as follows:

| Field name      | Field value                                                             | Description     |
| ---         | ---                                                                | ---      |
| `date`      | `2021-09-18T19:30:23.522+0800`                                     | log date |
| `level`     | `INFO`                                                             | log level |
| `character` | `agent.server.connect`                                             | role     |
| `msg`       | `initialized primary datacenter CA with provider: provider=consul` | log content |
