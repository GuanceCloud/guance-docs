---
title: 'Istio'
summary: 'Istio performance metric display, including Incoming Request Volume, Incoming Success Rate, Incoming Requests By Source And Response Code, Outgoing Requests By Destination And Response Code, etc.'
dashboard:
  - desc: 'Istio Workload Monitoring View'
    path: 'dashboard/zh/istio_workload'
  - desc: 'Istio Control Plane Monitoring View'
    path: 'dashboard/zh/istio_control_plane'
  - desc: 'Istio Mesh Monitoring View'
    path: 'dashboard/zh/istio_mesh'
  - desc: 'Istio ServiceMonitoring View'
    path: 'dashboard/zh/istio_service'
monitor:
  - desc: 'No'
    path: ''
---

<!-- markdownlint-disable MD025 -->
# Istio
<!-- markdownlint-enable -->

Istio performance metrics display, including Incoming Request Volume, Incoming Success Rate, Incoming Requests By Source And Response Code, Outgoing Requests By Destination And Response Code, etc.

---

## Configuration {#config}

### Preconditions

- Deployed [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/)

- DataKit has been deployed, see Kubernetes Cluster [安装 Datakit](../datakit/datakit-daemonset-deploy.md)>

- Istio Deployed

---

Description: Example Istio version 1.11.2.

### DataKit Configuration

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data: 
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
        volumeMounts: # add
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

Redeploy DataKit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f  datakit.yaml
```

### Application Access Configuration

Open Envoy Metric Collector

Add the following annotations at the Business Pod (specific path `spec.template.metadata`) to collect Envoy's metric data.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: productpage-v1
spec:
  template:
    metadata:
    ...
      annotations:  # add
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

## Metric {#metric}

For all data collection below, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.{{.InputName}}.tags]`:

```toml
 [inputs.{{.InputName}}.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

### Metrics

| Metric                                                                 |Describe| Data type | unit   |
| ---                                                                  | ---                                                                                           | ---      | ---    |
| `istio_agent_process_virtual_memory_bytes`                           |Virtual memory size in bytes| int      | B      |
| `istio_agent_go_memstats_alloc_bytes`                                |Number of bytes allocated and still in use.| int      | B      |
| `istio_agent_go_memstats_heap_inuse_bytes`                           |Number of heap bytes that are in use.| int      | B      |
| `istio_agent_go_memstats_stack_inuse_bytes`                          |Number of bytes in use by the stack allocator.| int      | B      |
| `istio_agent_go_memstats_last_gc_time_seconds`                       |Number of seconds since 1970 of last garbage collection| int      | s      |
| `istio_agent_go_memstats_next_gc_bytes`                              |Number of heap bytes when next garbage collection will take place.| int      | B      |
| `istio_agent_process_cpu_seconds_total`                              |Total user and system CPU time spent in seconds.| int      | count  |
| `istio_agent_outgoing_latency`                                       |The latency of outgoing requests (e.g. to a token exchange server, CA, etc.) in milliseconds.| int      | count  |
| `istio_requests_total`                                               |requests total.| int      | <br /> |
| `istio_agent_pilot_xds`                                              |Number of endpoints connected to this pilot using XDS.| int      | count  |
| `istio_agent_pilot_xds_pushes`                                       |Pilot build and send errors for lds, rds, cds and eds.| int      | count  |
| `istio_agent_pilot_xds_expired_nonce`                                |Total number of XDS requests with an expired nonce.| int      | count  |
| `istio_agent_pilot_push_triggers`                                    |Total number of times a push was triggered, labeled by reason for the push.| int      | count  |
| `istio_agent_pilot_endpoint_not_ready`                               |Endpoint found in unready state.| int      | count  |
| `envoy_cluster_upstream_cx_total`                                    |envoy cluster upstream cx total| int      | count  |
| `istio_agent_pilot_conflict_inbound_listener`                        |Number of conflicting inbound listeners| int      | count  |
| `istio_agent_pilot_conflict_outbound_listener_http_over_current_tcp` |Number of conflicting wildcard http listeners with current wildcard tcp listener.| int      | count  |
| `istio_agent_pilot_conflict_outbound_listener_tcp_over_current_tcp`  |Number of conflicting tcp listeners with current tcp listener.| int      | count  |
| `istio_agent_pilot_conflict_outbound_listener_tcp_over_current_http` |Number of conflicting wildcard tcp listeners with current wildcard http listener.| int      | count  |

---

## APM Collection {#trace}

### 1 Turn on the Zipkin collector

Modify `datakit.yaml` and mount `zipkin.conf` to the `/usr/local/datakit/conf.d/zipkin/zipkin.conf` directory of the DataKit through ConfigMap. Modify `datakit.yaml` below:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data: # add
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
        volumeMounts: # add
        - mountPath: /usr/local/datakit/conf.d/zipkin/zipkin.conf
          name: datakit-conf
          subPath: zipkin.conf
```

```shell
kubectl delete -f datakit.yaml
kubectl apply -f  datakit.yaml
```

Link data is typed on Service with **zipkin.istio-system** and the reporting port is `9411`.

The Zipkin collector for link metrics collection was turned on when the DataKit was deployed. Since the namespace of the DataKit service is `datakit`, and the port is `9529`, a conversion is required here.

### 2 Define services for ClusterIP

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

Once deployed, containers within the cluster can use `datakit-service-ext.datakit.svc.cluster.local:9411` to access DataKit port 9529.

### 3 Define services for ExternalName

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

Once deployed, you can use `zipkin.istio-system.svc.cluster.local:9411` to push data to the DataKit in containers within the cluster.

---

## Logging {#logging}

DataKit default configuration, collection container output to `/dev/stdout` log. <br />

<!-- TODO: page 404
Refer to for more log collection

<[Pod logging collector best practices](../best-practices/cloud-native/pod-log.md)>

<[Kubernetes Several `gameplay` for log collection in clusters](../best-practices/cloud-native/k8s-logs.md)> -->

---

<!-- TODO: page 404
## Best Practices

Best practices include Istio installation, Istio built-in project deployment, RUM/APM associations, and other extensions, as detailed in [Best practices for observable microservices based on Istio](../best-practices/cloud-native/istio.md)
-->
