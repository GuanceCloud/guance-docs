---
title     : 'Ingress Nginx (Prometheus)'
summary   : '采集 Ingress Nginx (Prometheus) 相关指标信息'
__int_icon: 'icon/ingress'
dashboard :
  - desc  : 'Ingress Nginx 监控视图'
    path  : 'dashboard/zh/ingress_nginx'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Ingress Nginx (Prometheus)
<!-- markdownlint-enable -->


Ingress 性能指标展示，包括 Ingress Controller 的平均 CPU 使用率、平均内存使用、网络请求/响应合计、Ingress Config 的加载次数、Ingress Config 上次加载结果、Ingress 的转发成功率等。


## 配置 {#config}

### 前置条件

- 已部署 DataKit，请参考 Kubernetes 集群 <[安装 Datakit](../datakit/datakit-daemonset-deploy.md)>

### 安装部署
说明：示例 Ingress 版本为 `willdockerhub/ingress-nginx-controller:v1.0.0`(CentOS 环境下 `kubeadmin` 部署)，各个不同版本指标可能存在差异。

### 指标采集

- 获取部署 Ingress 的 yaml 文件

```shell
wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/baremetal/deploy.yaml
```

- 编辑 deploy.yaml
把 service 的 type 设置成 `NodePort`，并对外暴露 `10254` 端口

```yaml

spec:
  type: NodePort
......
    - name: prometheus
      port: 10254
      targetPort: prometheus
```

找到 kind: Deployment 部分，修改如下内容：

```shell
kind: DaemonSet #修改

---
hostNetwork: true #新增
dnsPolicy: ClusterFirstWithHostNet #修改

```

-开启 Input
<<< custom_key.brand_name >>>接入 Ingress 指标数据，需要 DataKit 开启 prom 插件，在 prom 插件配置中指定 exporter 的 url，在 Kubernetes 集群中采集 Ingress Controller 指标，推荐使用 annotations 增加注解的方式。打开部署 Ingress 的 deploy.yaml 文件，找到上步中修改的 DaemonSet 部分 ，增加 annotations。

```yaml
annotations:
  datakit/prom.instances: |
    [[inputs.prom]]
      url = "http://$IP:10254/metrics"
      source = "prom-ingress"
      metric_types = ["counter", "gauge", "histogram"]
      # metric_name_filter = ["cpu"]
      # measurement_prefix = ""
      measurement_name = "prom_ingress"
      interval = "60s"
      tags_ignore = ["build","le","path","method","release","repository"]
      metric_name_filter = ["nginx_process_cpu_seconds_total","nginx_process_resident_memory_bytes","request_size","response_size","requests","success","config_last_reload_successful"]
      [[inputs.prom.measurements]]
        prefix = "nginx_ingress_controller_"
        name = "prom_ingress"
      [inputs.prom.tags]
      namespace = "$NAMESPACE"
```

- 参数说明：

- url: Exporter urls，多个 url 用逗号分割
- source: 采集器别名
- metric_types: 指标类型，可选值是 counter、 gauge、 histogram、 summary
- measurement_name: 指标集名称
- interval: 采集频率
- inputs.prom.measurements: 指标集为 prefix 的前缀归为 name 的指标集
- tags_ignore: 忽略的 tag
- metric_name_filter: 保留的指标名

- 部署 Ingress

```shell
kubectl apply -f deploy.yaml
```

## 指标 {#metric}

如果配置了 `inputs.prom.measurements` ，<<< custom_key.brand_name >>>采集到的指标需要加上前缀才能与表格匹配。<br />
举例，如下配置了前缀 `nginx*ingress_controller` ，指标集是 `prom_ingress` 。

```toml
 [[inputs.prom.measurements]]
              prefix = "nginx_ingress_controller_"
              name = "prom_ingress"
```

`nginx_ingress_controller_requests` 指标在<<< custom_key.brand_name >>>上的指标就是 `prom_ingress` 指标集下的 `requests` 指标。

| 指标                                                         | 描述                                                         | 数据类型 | 单位  |
| ------------------------------------------------------------ | ------------------------------------------------------------ | -------- | ----- |
| nginx_ingress_controller_requests                            | The total number of client requests                          | int      | count |
| nginx_ingress_controller_nginx_process_connections           | current number of client connections with state {active, reading, writing, waiting} | int      | count |
| nginx_ingress_controller_success                             | Cumulative number of Ingress controller reload operations    | int      | count |
| nginx_ingress_controller_config_last_reload_successful       | Whether the last configuration reload attempt was successful | int      | count |
| nginx_ingress_controller_nginx_process_resident_memory_bytes | number of bytes of memory in use                             | float    | B     |
| nginx_ingress_controller_nginx_process_cpu_seconds_total     | Cpu usage in seconds                                         | float    | B     |
| nginx_process_resident_memory_bytes                          | number of bytes of memory in use                             | int      | B     |
| nginx_ingress_controller_request_duration_seconds_bucket     | The request processing time in milliseconds                  | int      | count |
| nginx_ingress_controller_request_size_sum                    | The request length (including request line, header, and request body) | int      | count |
| nginx_ingress_controller_response_size_sum                   | The response length (including request line, header, and request body) | int      | count |
| nginx_ingress_controller_ssl_expire_time_seconds             | Number of seconds since 1970 to the SSL Certificate expire   | int      | count |

## 最佳实践 {#more-reading}

<[Nginx Ingress 可观测最佳实践](../best-practices/cloud-native/ingress-nginx.md)>
