---
title     : 'kube Proxy'
summary   : 'By tracking the runtime metrics of kube-proxy, it helps to understand information such as the load of the network proxy, response time, synchronization status, etc.'
__int_icon: 'icon/kube_proxy'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
dashboard :
  - desc  : 'kube Proxy'
    path  : 'dashboard/en/kube_proxy'
monitor   :
  - desc  : 'kube Proxy'
    path  : 'monitor/en/kube_proxy'
---

By tracking the runtime metrics of kube-proxy, it helps to understand information such as the load of the network proxy, response time, synchronization status, etc.

## Configuration {#config}

### Prerequisites {#requirement}

- [x] Datakit has been installed

### Configure Datakit

- Go to the `conf.d/prom` directory under the datakit installation directory, copy `prom.conf.sample` and rename it to `kube-proxy.conf`

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

## Metrics {#metric}

### kube-proxy Metrics Set

The Kube Proxy metrics are located under the kubeproxy metrics set. Here we introduce relevant explanations for Kube Proxy metrics.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`network_programming_duration_seconds_bucket`|`Time distribution of network programming operations`| s |
|`network_programming_duration_seconds_count`|`Total number of network programming operations that occurred`| count |
|`network_programming_duration_seconds_sum`|`Total time spent on all network programming operations`| s |
|`sync_proxy_rules_duration_seconds_bucket`|`Time distribution of sync proxy rules operations`| s |
|`sync_proxy_rules_duration_seconds_count`|`Total number of sync proxy rules operations`| count |
|`sync_proxy_rules_duration_seconds_sum`|`Total time spent on all sync proxy rules operations`| count |
|`sync_proxy_rules_endpoint_changes_pending`|`Number of endpoint changes waiting to be synchronized`| count |
|`sync_proxy_rules_endpoint_changes_total`|`Total number of times endpoints have been synchronized`| count |
|`sync_proxy_rules_iptables_restore_failures_total`|`Number of times IPTables rule restoration failed`| count |
|`sync_proxy_rules_no_local_endpoints_total`|`Number of services with no local endpoints`| count |
|`sync_proxy_rules_service_changes_pending`|`Number of service configuration changes waiting to be synchronized`| count |