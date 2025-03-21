---
title: 'Istio'
summary: 'Display of Istio performance Metrics, including Incoming Request Volume, Incoming Success Rate, Incoming Requests By Source And Response Code, Outgoing Requests By Destination And Response Code, etc.'
dashboard:
  - desc: 'Istio Workload Monitoring View'
    path: 'dashboard/en/istio_workload'
  - desc: 'Istio Control Plane Monitoring View'
    path: 'dashboard/en/istio_control_plane'
  - desc: 'Istio Mesh Monitoring View'
    path: 'dashboard/en/istio_mesh'
  - desc: 'Istio Service Monitoring View'
    path: 'dashboard/en/istio_service'
monitor:
  - desc: 'Not exist'
    path: ''
---

<!-- markdownlint-disable MD025 -->
# Istio
<!-- markdownlint-enable -->

Display of Istio performance Metrics, including Incoming Request Volume, Incoming Success Rate, Incoming Requests By Source And Response Code, Outgoing Requests By Destination And Response Code, etc.

---

## Collector Configuration {#config}

### Prerequisites

- [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/) has been deployed

- DataKit has been deployed. Please refer to the Kubernetes cluster <[Install Datakit](../datakit/datakit-daemonset-deploy.md)>

- Istio has been deployed

---

Note: The example Istio version is 1.11.2.

### DataKit Configuration

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data: # Below is the added part
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
        volumeMounts: # Below is the added part
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

Enable Envoy Metrics Collector

Add the following annotations to the business Pod (specific path under `spec.template.metadata`), so that Envoy's metrics data can be collected.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: productpage-v1
spec:
  template:
    metadata:
    ...
      annotations:  # Below is the added part
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

Parameter Description

- url: Exporter address
- source: Collector name
- metric_types: Metric type filtering
- measurement_name: Measurement name after collection
- interval: Metric collection frequency, in seconds
- $IP: Wildcard for the internal network IP of the Pod
- $NAMESPACE: Namespace where the Pod resides
- tags_ignore: Ignored tags
- metric_name_filter: Retained metric names

## Metrics {#metric}

By default, all the data collected will append a global tag named `host` (the tag value is the hostname of the host where DataKit is located). You can also specify other labels through `[inputs.{{.InputName}}.tags]` in the configuration:

```toml
 [inputs.{{.InputName}}.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

### Metric Details

| Metric                                                                 | Description                                                                                          | Data Type | Unit   |
| ---                                                                    | ---                                                                                                 | ---       | ---    |
| `istio_agent_process_virtual_memory_bytes`                             | Virtual memory size in bytes                                                                        | int       | B      |
| `istio_agent_go_memstats_alloc_bytes`                                  | Number of bytes allocated and still in use.                                                         | int       | B      |
| `istio_agent_go_memstats_heap_inuse_bytes`                             | Number of heap bytes that are in use.                                                               | int       | B      |
| `istio_agent_go_memstats_stack_inuse_bytes`                            | Number of bytes in use by the stack allocator.                                                      | int       | B      |
| `istio_agent_go_memstats_last_gc_time_seconds`                         | Number of seconds since 1970 of last garbage collection                                              | int       | s      |
| `istio_agent_go_memstats_next_gc_bytes`                                | Number of heap bytes when next garbage collection will take place.                                  | int       | B      |
| `istio_agent_process_cpu_seconds_total`                                 | Total user and system CPU time spent in seconds                                                     | int       | count  |
| `istio_agent_outgoing_latency`                                          | The latency of outgoing requests (e.g., to a token exchange server, CA, etc.) in milliseconds.        | int       | count  |
| `istio_requests_total`                                                  | Total number of requests                                                                            | int       | <br /> |
| `istio_agent_pilot_xds`                                                 | Number of endpoints connected to this pilot using XDS                                               | int       | count  |
| `istio_agent_pilot_xds_pushes`                                          | Pilot build and send errors for lds, rds, cds and eds                                               | int       | count  |
| `istio_agent_pilot_xds_expired_nonce`                                   | Total number of XDS requests with an expired nonce                                                  | int       | count  |
| `istio_agent_pilot_push_triggers`                                       | Total number of times a push was triggered, labeled by reason for the push                           | int       | count  |
| `istio_agent_pilot_endpoint_not_ready`                                  | Endpoint found in unready state                                                                     | int       | count  |
| `envoy_cluster_upstream_cx_total`                                       | envoy cluster upstream cx total                                                                     | int       | count  |
| `istio_agent_pilot_conflict_inbound_listener`                           | Number of conflicting inbound listeners                                                              | int       | count  |
| `istio_agent_pilot_conflict_outbound_listener_http_over_current_tcp`    | Number of conflicting wildcard http listeners with current wildcard tcp listener                     | int       | count  |
| `istio_agent_pilot_conflict_outbound_listener_tcp_over_current_tcp`     | Number of conflicting tcp listeners with current tcp listener                                        | int       | count  |
| `istio_agent_pilot_conflict_outbound_listener_tcp_over_current_http`    | Number of conflicting wildcard tcp listeners with current wildcard http listener                      | int       | count  |

---

## APM Collection {#trace}

### 1 Enable Zipkin Collector

Modify `datakit.yaml`, mount `zipkin.conf` via ConfigMap to `/usr/local/datakit/conf.d/zipkin/zipkin.conf` directory in DataKit. Modify `datakit.yaml` as follows:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data: # Below is the added part
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
        volumeMounts: # Below is the added part
        - mountPath: /usr/local/datakit/conf.d/zipkin/zipkin.conf
          name: datakit-conf
          subPath: zipkin.conf
```

```shell
kubectl delete -f datakit.yaml
kubectl apply -f  datakit.yaml
```

Trace data will be sent to the **zipkin.istio-system** Service, and the reporting port is `9411`. <br />
The Zipkin collector for trace metric collection has been enabled during DataKit deployment. Since the service namespace of DataKit is `datakit`, and the port is `9529`, a conversion is required here.

### 2 Define ClusterIP Service

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

After deployment, containers within the cluster can access DataKit's port 9529 via `datakit-service-ext.datakit.svc.cluster.local:9411`.

### 3 Define ExternalName Service

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

After deployment, within the cluster's containers, you can push data to DataKit via `zipkin.istio-system.svc.cluster.local:9411`.

---

## Logs {#logging}

DataKit's default configuration collects logs output by containers to `/dev/stdout`. <br />

For more log collection, please refer to

<[Pod Log Collection Best Practices](../best-practices/cloud-native/pod-log.md)>

<[Several Playbooks for Log Collection in Kubernetes Clusters](../best-practices/cloud-native/k8s-logs.md)>


---

## Best Practices

Best practices include Istio installation, deployment of Istio's built-in projects, RUM/APM association, and other extended operations. For details, please refer to [Best Practices for Achieving Microservices Observability Based on Istio](../best-practices/cloud-native/istio.md)