---
title     : 'kube Proxy'
summary   : '通过跟踪 kube-proxy 运行指标,帮助了解网络代理的负载、响应时间、同步状态等信息'
__int_icon: 'icon/kube_proxy'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
dashboard :
  - desc  : 'kube Proxy'
    path  : 'dashboard/zh/kube_proxy'
monitor   :
  - desc  : 'kube Proxy'
    path  : 'monitor/zh/kube_proxy'
---

通过跟踪 kube-proxy 运行指标,帮助了解网络代理的负载、响应时间、同步状态等信息

## 配置 {#config}

### 前置条件 {#requirement}

- [x] 已安装 datakit

### 配置 Datakit

- 进入 datakit 安装目录下的 `conf.d/prom` 目录，复制 `prom.conf.sample` 并命名为 `kube-proxy.conf`

```shell
cp prom.conf.sample kube-proxy.conf
```

- 调整 `kube-proxy.conf` 内容如下：

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

- 重启 datakit
执行以下命令

```shell
datakit service -R
```

## 指标 {#metric}

### kube-proxy 指标集

Kube Proxy 指标位于 kubeproxy 指标集下，这里介绍 Kube Proxy 指标相关说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`network_programming_duration_seconds_bucket`|`网络编程操作的时间分布`| s |
|`network_programming_duration_seconds_count`|`网络编程操作发生的总次数`| count |
|`network_programming_duration_seconds_sum`|`所有网络编程操作的总耗时`| s |
|`sync_proxy_rules_duration_seconds_bucket`|`同步代理规则操作的时间分布`| s |
|`sync_proxy_rules_duration_seconds_count`|`同步代理规则操作的总次数`| count |
|`sync_proxy_rules_duration_seconds_sum`|`所有同步代理规则操作的总耗时`| count |
|`sync_proxy_rules_endpoint_changes_pending`|`有多少端点变更正在等待同步`| count |
|`sync_proxy_rules_endpoint_changes_total`|`同步端点变更的总次数`| count |
|`sync_proxy_rules_iptables_restore_failures_total`|`IPTables 规则恢复失败的次数`| count |
|`sync_proxy_rules_no_local_endpoints_total`|`没有本地端点的服务数量`| count |
|`sync_proxy_rules_service_changes_pending`|`有多少服务配置变更正在等待同步`| count |
