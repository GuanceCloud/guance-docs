---
title: 'Istio'
summary: 'Istio 性能指标展示，包括 Incoming Request Volume、Incoming Success Rate、Incoming Requests By Source And Response Code、Outgoing Requests By Destination And Response Code 等'
dashboard:
  - desc: 'Istio Workload 监控视图'
    path: 'dashboard/zh/istio_workload'
  - desc: 'Istio Control Plane 监控视图'
    path: 'dashboard/zh/istio_control_plane'
  - desc: 'Istio Mesh 监控视图'
    path: 'dashboard/zh/istio_mesh'
  - desc: 'Istio Service 监控视图'
    path: 'dashboard/zh/istio_service'
monitor:
  - desc: '暂无'
    path: ''
---

<!-- markdownlint-disable MD025 -->
# Istio
<!-- markdownlint-enable -->

Istio 性能指标展示，包括 Incoming Request Volume、Incoming Success Rate、Incoming Requests By Source And Response Code、Outgoing Requests By Destination And Response Code 等。

---

## 采集器配置 {#config}

### 前置条件

- 已部署 [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/)

- 已部署 DataKit，请参考 Kubernetes 集群 [安装 Datakit](../datakit/datakit-daemonset-deploy.md)

- Istio 已部署

---

说明：示例 Istio 版本为 1.11.2。

### DataKit 配置

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data: # 下面是新增部分
  prom_istiod.conf: |-
    [[inputs.prom]] 
      url = "http://istiod.istio-system.svc.cluster.local:15014/metrics"
      source = "prom-istiod"
      metric_types = ["counter", "gauge"]
      interval = "60s"
      tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
      metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
      #measurement_prefix = ""
      measurement_name = "istio_prom"
      #[[inputs.prom.measurements]]
      # prefix = "cpu_"
      # name ="cpu"
      [inputs.prom.tags]
        app_id="istiod"
  #### ingressgateway
  prom-ingressgateway.conf: |-
    [[inputs.prom]] 
      url = "http://istio-ingressgateway-ext.istio-system.svc.cluster.local:15020/stats/prometheus"
      source = "prom-ingressgateway"
      metric_types = ["counter", "gauge"]
      interval = "60s"
      tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
      metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
      #measurement_prefix = ""
      measurement_name = "istio_prom"
      #[[inputs.prom.measurements]]
      # prefix = "cpu_"
      # name ="cpu"
  #### egressgateway
  prom-egressgateway.conf: |-
    [[inputs.prom]] 
      url = "http://istio-egressgateway-ext.istio-system.svc.cluster.local:15020/stats/prometheus"
      source = "prom-egressgateway"
      metric_types = ["counter", "gauge"]
      interval = "60s"
      tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
      metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
      #measurement_prefix = ""
      measurement_name = "istio_prom"
      #[[inputs.prom.measurements]]
      # prefix = "cpu_"
      # name ="cpu"
```

```yaml
apiVersion: apps/v1
kind: DaemonSet
...
spec:
  template
    spec:
      containers:
      - env:
        volumeMounts: # 下面是新增部分
        - mountPath: /usr/local/datakit/conf.d/prom/prom_istiod.conf
          name: datakit-conf
          subPath: prom_istiod.conf
        - mountPath: /usr/local/datakit/conf.d/prom/prom-ingressgateway.conf
          name: datakit-conf
          subPath: prom-ingressgateway.conf
        - mountPath: /usr/local/datakit/conf.d/prom/prom-egressgateway.conf
          name: datakit-conf
          subPath: prom-egressgateway.conf
```

重新部署 DataKit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f  datakit.yaml
```

### 应用接入配置

开启 Envoy 指标采集器

在业务 Pod 处添加如下 annotations（具体路径 `spec.template.metadata` 下），这样即可采集 Envoy 的指标数据。

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: productpage-v1
spec:
  template:
    metadata:
    ...
      annotations:  # 下面是新增部分
        datakit/prom.instances: |
          [[inputs.prom]]
            url = "http://$IP:15020/stats/prometheus"
            source = "bookinfo-istio-product"
            metric_types = ["counter", "gauge"]
            interval = "60s"
            tags_ignore = ["cache","cluster_type","component","destination_app","destination_canonical_revision","destination_canonical_service","destination_cluster","destination_principal","group","grpc_code","grpc_method","grpc_service","grpc_type","reason","request_protocol","request_type","resource","responce_code_class","response_flags","source_app","source_canonical_revision","source_canonical-service","source_cluster","source_principal","source_version","wasm_filter"]
            metric_name_filter = ["istio_requests_total","pilot_k8s_cfg_events","istio_build","process_virtual_memory_bytes","process_resident_memory_bytes","process_cpu_seconds_total","envoy_cluster_assignment_stale","go_goroutines","pilot_xds_pushes","pilot_proxy_convergence_time_bucket","citadel_server_root_cert_expiry_timestamp","pilot_conflict_inbound_listener","pilot_conflict_outbound_listener_http_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_tcp","pilot_conflict_outbound_listener_tcp_over_current_http","pilot_virt_services","galley_validation_failed","pilot_services","envoy_cluster_upstream_cx_total","envoy_cluster_upstream_cx_connect_fail","envoy_cluster_upstream_cx_active","envoy_cluster_upstream_cx_rx_bytes_total","envoy_cluster_upstream_cx_tx_bytes_total","istio_request_duration_milliseconds_bucket","istio_request_duration_seconds_bucket","istio_request_bytes_bucket","istio_response_bytes_bucket"]
            #measurement_prefix = ""
            measurement_name = "istio_prom"
            #[[inputs.prom.measurements]]
            # prefix = "cpu_"
            # name = "cpu"
            [inputs.prom.tags]
            namespace = "$NAMESPACE"
```

参数说明

- url：Exporter 地址
- source：采集器名称
- metric_types：指标类型过滤
- measurement_name：采集后的指标集名称
- interval：采集指标频率，s 秒
- $IP：通配 Pod 的内网 IP
- $NAMESPACE：Pod 所在命名空间
- tags_ignore: 忽略的 tag
- metric_name_filter: 保留的指标名

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.{{.InputName}}.tags]` 指定其它标签：

```toml
 [inputs.{{.InputName}}.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

### 指标详解


| 指标   | 描述  | 数据类型 | 单位 |
| ------------------------------------------------------------------ | --------------------------------------------------------------------------------------------- | -------- | ------ |
| istio_agent_process_virtual_memory_bytes                           | Virtual memory size in bytes                                                                  | int      | B      |
| istio_agent_go_memstats_alloc_bytes                                | Number of bytes allocated and still in use.                                                   | int      | B      |
| istio_agent_go_memstats_heap_inuse_bytes                           | Number of heap bytes that are in use.                                                         | int      | B      |
| istio_agent_go_memstats_stack_inuse_bytes                          | Number of bytes in use by the stack allocator.                                                | int      | B      |
| istio_agent_go_memstats_last_gc_time_seconds                       | Number of seconds since 1970 of last garbage collection                                       | int      | s      |
| istio_agent_go_memstats_next_gc_bytes                              | Number of heap bytes when next garbage collection will take place.                            | int      | B      |
| istio_agent_process_cpu_seconds_total                              | Total user and system CPU time spent in seconds.                                              | int      | count  |
| istio_agent_outgoing_latency                                       | The latency of outgoing requests (e.g. to a token exchange server, CA, etc.) in milliseconds. | int      | count  |
| istio_requests_total                                               | requests total.                                                                               | int      | <br /> |
| istio_agent_pilot_xds                                              | Number of endpoints connected to this pilot using XDS.                                        | int      | count  |
| istio_agent_pilot_xds_pushes                                       | Pilot build and send errors for lds, rds, cds and eds.                                        | int      | count  |
| istio_agent_pilot_xds_expired_nonce                                | Total number of XDS requests with an expired nonce.                                           | int      | count  |
| istio_agent_pilot_push_triggers                                    | Total number of times a push was triggered, labeled by reason for the push.                   | int      | count  |
| istio_agent_pilot_endpoint_not_ready                               | Endpoint found in unready state.                                                              | int      | count  |
| envoy_cluster_upstream_cx_total                                    | envoy cluster upstream cx total                                                               | int      | count  |
| istio_agent_pilot_conflict_inbound_listener                        | Number of conflicting inbound listeners                                                       | int      | count  |
| istio_agent_pilot_conflict_outbound_listener_http_over_current_tcp | Number of conflicting wildcard http listeners with current wildcard tcp listener.             | int      | count  |
| istio_agent_pilot_conflict_outbound_listener_tcp_over_current_tcp  | Number of conflicting tcp listeners with current tcp listener.                                | int      | count  |
| istio_agent_pilot_conflict_outbound_listener_tcp_over_current_http | Number of conflicting wildcard tcp listeners with current wildcard http listener.             | int      | count  |


---

## APM 采集 {#trace}

### 1 开启 Zipkin 采集器

修改 `datakit.yaml`，通过 ConfigMap 把 `zipkin.conf` 挂载到 DataKit 的 `/usr/local/datakit/conf.d/zipkin/zipkin.conf` 目录，下面修改 `datakit.yaml` :

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data: # 下面是新增部分
  zipkin.conf: |-
    [[inputs.zipkin]]
      pathV1 = "/api/v1/spans"
      pathV2 = "/api/v2/spans"
```

```yaml
apiVersion: apps/v1
kind: DaemonSet
...
spec:
  template
    spec:
      containers:
      - env:
        volumeMounts: # 下面是新增部分
        - mountPath: /usr/local/datakit/conf.d/zipkin/zipkin.conf
          name: datakit-conf
          subPath: zipkin.conf
```

```shell
kubectl delete -f datakit.yaml
kubectl apply -f  datakit.yaml
```

链路数据会被打到 **zipkin.istio-system** 的 Service 上，且上报端口是 `9411`。<br />
在部署 DataKit 时已开通链路指标采集的 Zipkin 采集器，由于 DataKit 服务的名称空间是 `datakit`，端口是 `9529`，所以这里需要做一下转换。

### 2 定义 ClusterIP 的服务

```yaml
apiVersion: v1
kind: Service
metadata:
  name: datakit-service-ext
  namespace: datakit
spec:
  selector:
    app: daemonset-datakit
  ports:
    - protocol: TCP
      port: 9411
      targetPort: 9529
```

部署完成后，集群内部的容器就可以使用 `datakit-service-ext.datakit.svc.cluster.local:9411` 来访问 DataKit 的 9529 端口。

### 3 定义 ExternalName 的服务

```yaml
apiVersion: v1
kind: Service
metadata:
  name: zipkin
  namespace: istio-system
spec:
  type: ExternalName
  externalName: datakit-service-ext.datakit.svc.cluster.local
```

部署完成后，在集群内部的容器中，就可以使用 `zipkin.istio-system.svc.cluster.local:9411` 推送数据到  DataKit 了。

---

## 日志 {#logging}

DataKit 默认的配置，采集容器输出到 `/dev/stdout` 的日志。<br />

更多日志采集请参考

<[Pod 日志采集最佳实践](../best-practices/cloud-native/pod-log.md)>

<[Kubernetes 集群中日志采集的几种玩法](../best-practices/cloud-native/k8s-logs.md)>


---

## 最佳实践

最佳实践中包含 istio 安装， istio 自带项目部署， RUM+APM 关联等扩展操作，详细请参考

<[基于 Istio 实现微服务可观测最佳实践](../best-practices/cloud-native/istio.md)>

---

