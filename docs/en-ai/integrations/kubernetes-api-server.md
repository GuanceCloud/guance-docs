---
title: 'Kubernetes API Server'
summary: 'Collect metrics related to the Kubernetes API Server'
__int_icon: 'icon/kubernetes'
dashboard:
  - desc: 'Kubernetes API Server monitoring view'
    path: 'dashboard/en/kubernetes_api_server'
monitor:
  - desc: 'Not available'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# Kubernetes API Server
<!-- markdownlint-enable -->


Display performance metrics of the Kubernetes API Server, including request counts, work queue growth rate, work queue depth, CPU, Memory, Goroutine, etc.

## Configuration {#config}

### Version Support

- Operating system support: Linux
- Kubernetes version: 1.18+

### Prerequisites

- DataKit has been deployed; refer to [Install DataKit](../datakit/datakit-daemonset-deploy.md) for Kubernetes clusters.
- To collect metrics from the Kubernetes API Server, you need to install the [Metrics-Server component](https://github.com/kubernetes-sigs/metrics-server#installation){:target="_blank"}.

### Metrics Collection

- Create `bearer-token` authorization information using `yaml`

```yaml
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: bearer-token
rules:
  - apiGroups: [""]
    resources:
      - nodes
      - nodes/metrics
      - nodes/stats
      - nodes/proxy
      - services
      - endpoints
      - pods
      - configmaps
      - secrets
      - resourcequotas
      - replicationcontrollers
      - limitranges
      - persistentvolumeclaims
      - persistentvolumes
      - namespaces
    verbs: ["get", "list", "watch"]
  - apiGroups:
      - extensions
      - networking.k8s.io
    resources:
      - ingresses
    verbs: ["get", "list", "watch"]
  - nonResourceURLs: ["/metrics", "/metrics/cadvisor"]
    verbs: ["get"]
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: bearer-token
  namespace: default
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: bearer-token
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: bearer-token
subjects:
- kind: ServiceAccount
  name: bearer-token
  namespace: default
```

- Obtain the bearer_token

```shell
kubectl get secret `kubectl get secret -ndefault | grep bearer-token | awk '{print $1}'` -o jsonpath={.data.token} | base64 -d
```

- Add `api-server.conf` to ConfigMap

Add `api-server.conf` to the `ConfigMap` resource in the `datakit.yaml` file used for deploying DataKit.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
  #### api-server ## Below is the new part
  api-server.conf: |-
    [[inputs.prom]]
      ## Exporter address or file path (include http or https protocol for Exporter addresses)
      ## File paths differ across operating systems
      ## Windows example: C:\\Users
      ## UNIX-like example: /usr/local/
      url = "https://172.31.16.148:6443/metrics"
      ## Collector alias
      source = "prom-api-server"

      ## Metric type filter, optional values are counter, gauge, histogram, summary
      # By default, only counter and gauge types are collected
      # If empty, no filtering is performed
      metric_types = ["counter", "gauge"]

      ## Metric name filter
      # Supports regex, multiple configurations can be set where any one match is sufficient
      # If empty, no filtering is performed
      #metric_name_filter = [""]

      ## Prefix for measurement names
      # Configure this to add a prefix to the measurement names
      #measurement_prefix = "prom_api_server"

      ## Measurement name
      # By default, it splits the metric name by underscores ("_"), with the first field as the measurement name and the rest as the current metric name
      # If measurement_name is configured, it will not split the metric name
      # The final measurement name will include the measurement_prefix prefix
      measurement_name = "prom_api_server"

      ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
      interval = "60s"

      ## Filter tags, multiple tags can be configured
      # Matching tags will be ignored
      tags_ignore = ["apiservice","bound","build_date","compiler","component","crd","dry_run","endpoint","error_type","flow_schema","git_commit","git_tree_state","git_version","go_version","group","grpc_code","grpc_method","grpc_service","grpc_type","kind","major","method","minor","operation","platform","priority_level","reason","rejection_code","removed_release","request_kind","resource","result","scope","source","status","subresource","type","usage","username","verb","version"]
      metric_name_filter = ["workqueue_adds_total","workqueue_depth","apiserver_request_total","process_resident_memory_bytes","process_cpu_seconds_total","go_goroutines"]
      
      ## TLS configuration
      tls_open = true
      tls_ca = "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
      #tls_cert = "/etc/kubernetes/pki/apiserver.crt"
      #tls_key = "/etc/kubernetes/pki/apiserver.key"

      ## Custom authentication method, currently supports Bearer Token only
      [inputs.prom.auth]
       type = "bearer_token"
       token = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImlfX2V6UXdXWkpKUWZ6QlBxTGdSRTBpa0J1a2VpQUU3Q0JMWGFfYWNDYWcifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImJlYXJlci10b2tlbi10b2tlbi05emI5dCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJiZWFyZXItdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJkNWQxNDkzNi00NmM1LTRjZjMtYmI2MS00ODhhOTFiYTRjMTQiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpiZWFyZXItdG9rZW4ifQ.sBQUGE67N6BV6mnC0g72k8ciiSjEZ-ctFjHcyiP_rBp9paUnGwd3ouheF0ddGormn6esOGR1t6vvDdta9BiE3i5mHpJsOifkVXzv85N3qllJfSpXvIIn-LNq-wxnK55QbOhXQjeFKF0PBanJk4m_kWCM6SOuFrH9s8cHGhKEVCYw_7ScUwHCDGQVUq_zKCfKll20GHSwhlzjjt2tz07UYdQs5kQ9AN8VbM9qNIJmpasPOeqod9hTbevnL3kO5Lcd4h4NUOT8JfJ2Om72NvH71-xWNH0U_Hqf2yS0_ZlnneBESq4FDjbm1VnJPxeIOJL0dMaoRJVPPtA0yUhX5MYV7A"
       #token_file = "/var/run/secrets/kubernetes.io/serviceaccount/token"

      ## Custom tags
      [inputs.prom.tags]
        instance = "172.31.16.148:6443"
```

- Parameter descriptions:

- url: Address of the api-server metrics endpoint
- source: Collector alias
- metric_types: Metric type filter
- metric_name_filter: Metric name filter
- measurement_prefix: Prefix for measurement names
- measurement_name: Measurement name
- interval: Collection interval
- tags_ignore: Tags to ignore
- metric_name_filter: Retained metric names
- tls_open: Whether to skip security verification (set to true if using HTTPS and provide corresponding certificates), set to true here
- tls_ca: Path to CA certificate
- type: Custom authentication method, api-server uses bearer_token authentication
- token_file: Path to authentication file
- inputs.prom.tags: Refer to plugin tags

- Mount `api-server.conf`

Add the following content under `volumeMounts` in the `datakit.yaml` file.

```yaml
- mountPath: /usr/local/datakit/conf.d/prom/api-server.conf
  name: datakit-conf
  subPath: api-server.conf
```

- Kubernetes exposes metrics by default, which can be viewed directly using curl.

```shell
curl -k "https://172.31.16.148:6443/metrics" -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImlfX2V6UXdXWkpKUWZ6QlBxTGdSRTBpa0J1a2VpQUU3Q0JMWGFfYWNDYWcifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImJlYXJlci10b2tlbi10b2tlbi05emI5dCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJiZWFyZXItdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJkNWQxNDkzNi00NmM1LTRjZjMtYmI2MS00ODhhOTFiYTRjMTQiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpiZWFyZXItdG9rZW4ifQ.sBQUGE67N6BV6mnC0g72k8ciiSjEZ-ctFjHcyiP_rBp9paUnGwd3ouheF0ddGormn6esOGR1t6vvDdta9BiE3i5mHpJsOifkVXzv85N3qllJfSpXvIIn-LNq-wxnK55QbOhXQjeFKF0PBanJk4m_kWCM6SOuFrH9s8cHGhKEVCYw_7ScUwHCDGQVUq_zKCfKll20GHSwhlzjjt2tz07UYdQs5kQ9AN8VbM9qNIJmpasPOeqod9hTbevnL3kO5Lcd4h4NUOT8JfJ2Om72NvH71-xWNH0U_Hqf2yS0_ZlnneBESq4FDjbm1VnJPxeIOJL0dMaoRJVPPtA0yUhX5MYV7A"
```

- Restart DataKit

```yaml
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

### Plugin Tags (Required)

Parameter description

- This configuration allows custom tags with any key-value pairs.
- After configuring the following example, all api-server metrics will have similar tags for quick querying.
- For collecting api-server metrics, the required key is `instance`, and its value should be the api-server address.

```toml
    ## Custom tags
      [inputs.prom.tags]
          instance = "172.16.0.229:6443"
```

Restart DataKit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## Metrics {#metric}

| Metric                         | Description                                                         | Data Type |
| ------------------------------ | ------------------------------------------------------------------- | --------- |
| `apiserver_request_total`       | Counter of apiserver requests broken out for each verb, dry run value, group, version, resource, scope, component, and HTTP response code. | int      |
| `workqueue_adds_total`          | Total number of adds handled by workqueue                          | int      |
| `workqueue_depth`               | Current depth of workqueue                                         | int      |
| `process_resident_memory_bytes` | Resident memory size in bytes                                      | B        |
| `process_cpu_seconds_total`     | Total user and system CPU time spent in seconds                    | float    |
| `go_goroutines`                 | Number of goroutines that currently exist                         | int      |

## Common Issues Troubleshooting {#faq}

[No data reporting troubleshooting](../datakit/why-no-data.md)

## Further Reading {#more-reading}

- [Best practices for using TAGs in Guance](../best-practices/insight/tag.md)
- [Best practices for collecting metrics from multiple Kubernetes clusters](../best-practices/cloud-native/multi-cluster.md)