---
title     : 'kube Proxy'
summary   : 'By tracking the performance metrics of kube proxy, it helps to understand the load, response time, synchronization status, and other information of network agents'
__int_icon: 'icon/kube_proxy'
dashboard :
  - desc  : 'kube Proxy'
    path  : 'dashboard/en/kube_proxy'
monitor   :
  - desc  : 'kube Proxy'
    path  : 'monitor/en/kube_proxy'
---

By tracking the performance metrics of kube proxy, it helps to understand the load, response time, synchronization status, and other information of network agents

## Config {#config}

### Preconditions {#requirement}

- [x] Installed datakit

### Configure Datakit

- Go to the `conf.d/prom` directory under the datakit installation directory, copy `prom.conf.sample` and name it `kube-proxy.conf`

```shell
cp prom.conf.sample kube-proxy.conf
```

- Adjust the content of `kube-proxy.conf` as follows:

```yaml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://127.0.0.1:10249/metrics"]

  uds_path = ""

  ignore_req_err = false

  source = "kube-proxy"

  measurement_prefix = ""

  keep_exist_metric_name = false


  election = true

  disable_host_tag = false

  disable_instance_tag = false

  disable_info_tag = false


  [[inputs.prom.measurements]]
    prefix = "etcd_network_"
    name = "etcd_network"
    
  [[inputs.prom.measurements]]
    prefix = "etcd_server_"
    name = "etcd_server"

  [inputs.prom.tags_rename]
    overwrite_exist_tags = false

  [inputs.prom.as_logging]
    enable = false
    service = "service_name"
```

- Restart datakit
Execute the following command

```shell
datakit service -R
```

## Metric {#metric}

### kube-proxy Metric set

The Kube Proxy metric is located under the kubeproxy metric set. Here is an introduction to the Kube Proxy metric

| Metrics | description | unit |
|:--------|:-----|:--|
|`network_programming_duration_seconds_bucket`|`Time distribution of network programming operations`| s |
|`network_programming_duration_seconds_count`|`The total number of occurrences of network programming operations`| count |
|`network_programming_duration_seconds_sum`|`The total time required for all network programming operations`| s |
|`sync_proxy_rules_duration_seconds_bucket`|`Time distribution of synchronous proxy rule operations`| s |
|`sync_proxy_rules_duration_seconds_count`|`The total number of synchronous proxy rule operations`| count |
|`sync_proxy_rules_duration_seconds_sum`|`The total time required for all synchronous proxy rule operations`| count |
|`sync_proxy_rules_endpoint_changes_pending`|`How many endpoint changes are waiting to be synchronized`| count |
|`sync_proxy_rules_endpoint_changes_total`|`The total number of synchronized endpoint changes`| count |
|`sync_proxy_rules_iptables_restore_failures_total`|`The number of times IPTables rule recovery failed`| count |
|`sync_proxy_rules_no_local_endpoints_total`|`Number of services without local endpoints`| count |
|`sync_proxy_rules_service_changes_pending`|`How many service configuration changes are waiting to be synchronized`| count |
