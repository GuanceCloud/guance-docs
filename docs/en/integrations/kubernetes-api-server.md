---
title     : 'Kubernetes API Server'
summary   : 'Collect information about Kubernetes API Server related metrics'
__int_icon: 'icon/kubernetes'
dashboard :
  - desc  : 'Kubernetes API Server Monitoring View'
    path  : 'dashboard/zh/kubernetes_api_server'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Kubernetes API Server
<!-- markdownlint-enable -->


Kubernetes API Server performance metrics display, including number of requests, work queue growth, work queue depth, CPU, Memory, Goroutine, etc.


## Configuration {#config}

### Version support

- Operating system support: Linux

- Kubernetes version: 1.18+

### Preconditions

- DataKit has been deployed, see Kubernetes Cluster [安装 Datakit](../datakit/datakit-daemonset-deploy.md)>

- Kubernetes API Server metric data was collected, [Kubernetes is required to install the Metrics-Server component](https://github.com/kubernetes-sigs/metrics-server#installation){: target="_blank"}.

### Metric Collection

- Use `yaml` to create `bearer-token` authorization information

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

- Get bearer token

```shell
kubectl get secret `kubectl get secret -ndefault | grep bearer-token | awk '{print $1}'` -o jsonpath={.data.token} | base64 -d
```


- ConfigMap increase `api-server.conf` Configuration

In the `datakit.yaml` file used to deploy DataKit, add `api-server.conf` to the ConfigMap resource.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
  #### api-server ## add
  api-server.conf: |-
    [[inputs.prom]]
      ## Windows example: C:\\Users
      ## UNIX-like example: /usr/local/
      url = "https://172.31.16.148:6443/metrics"

      source = "prom-api-server"

      metric_types = ["counter", "gauge"]

      measurement_name = "prom_api_server"

      interval = "60s"

      tags_ignore = ["apiservice","bound","build_date","compiler","component","crd","dry_run","endpoint","error_type","flow_schema","git_commit","git_tree_state","git_version","go_version","group","grpc_code","grpc_method","grpc_service","grpc_type","kind","major","method","minor","operation","platform","priority_level","reason","rejection_code","removed_release","request_kind","resource","result","scope","source","status","subresource","type","usage","username","verb","version"]
      metric_name_filter = ["workqueue_adds_total","workqueue_depth","apiserver_request_total","process_resident_memory_bytes","process_cpu_seconds_total","go_goroutines"]
      
      tls_open = true
      tls_ca = "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"

      [inputs.prom.auth]
       type = "bearer_token"
       token = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImlfX2V6UXdXWkpKUWZ6QlBxTGdSRTBpa0J1a2VpQUU3Q0JMWGFfYWNDYWcifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImJlYXJlci10b2tlbi10b2tlbi05emI5dCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJiZWFyZXItdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJkNWQxNDkzNi00NmM1LTRjZjMtYmI2MS00ODhhOTFiYTRjMTQiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpiZWFyZXItdG9rZW4ifQ.sBQUGE67N6BV6mnC0g72k8ciiSjEZ-ctFjHcyiP_rBp9paUnGwd3ouheF0ddGormn6esOGR1t6vvDdta9BiE3i5mHpJsOifkVXzv85N3qllJfSpXvIIn-LNq-wxnK55QbOhXQjeFKF0PBanJk4m_kWCM6SOuFrH9s8cHGhKEVCYw_7ScUwHCDGQVUq_zKCfKll20GHSwhlzjjt2tz07UYdQs5kQ9AN8VbM9qNIJmpasPOeqod9hTbevnL3kO5Lcd4h4NUOT8JfJ2Om72NvH71-xWNH0U_Hqf2yS0_ZlnneBESq4FDjbm1VnJPxeIOJL0dMaoRJVPPtA0yUhX5MYV7A"
       #token_file = "/var/run/secrets/kubernetes.io/serviceaccount/token"

      [inputs.prom.tags]
        instance = "172.31.16.148:6443"
```

- Mount `api-server.conf`

Add the following under `datakit.yaml` file `volumeMounts`.

```yaml
- mountPath: /usr/local/datakit/conf.d/prom/api-server.conf
  name: datakit-conf
  subPath: api-server.conf
```

- Kubernetes has exposed metrics by default and can view them directly through curl.

```shell
curl -k "https://172.31.16.148:6443/metrics" -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImlfX2V6UXdXWkpKUWZ6QlBxTGdSRTBpa0J1a2VpQUU3Q0JMWGFfYWNDYWcifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImJlYXJlci10b2tlbi10b2tlbi05emI5dCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJiZWFyZXItdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJkNWQxNDkzNi00NmM1LTRjZjMtYmI2MS00ODhhOTFiYTRjMTQiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpiZWFyZXItdG9rZW4ifQ.sBQUGE67N6BV6mnC0g72k8ciiSjEZ-ctFjHcyiP_rBp9paUnGwd3ouheF0ddGormn6esOGR1t6vvDdta9BiE3i5mHpJsOifkVXzv85N3qllJfSpXvIIn-LNq-wxnK55QbOhXQjeFKF0PBanJk4m_kWCM6SOuFrH9s8cHGhKEVCYw_7ScUwHCDGQVUq_zKCfKll20GHSwhlzjjt2tz07UYdQs5kQ9AN8VbM9qNIJmpasPOeqod9hTbevnL3kO5Lcd4h4NUOT8JfJ2Om72NvH71-xWNH0U_Hqf2yS0_ZlnneBESq4FDjbm1VnJPxeIOJL0dMaoRJVPPtA0yUhX5MYV7A"
```

- Restart DataKit

```yaml
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## Metric {#metric}

| Tag                          |Describe| Data type |
| ----------------------------- | ------------------------------------------------------------ | -------- |
| `apiserver_request_total`       |Counter of apiserver requests broken out for each verb, dry run value, group, version, resource, scope, component, and HTTP response code.| int      |
| `workqueue_adds_total`          |Total number of adds handled by workqueue| int      |
| `workqueue_depth`               |Current depth of workqueue| int      |
| `process_resident_memory_bytes` |Resident memory size in bytes| B        |
| `process_cpu_seconds_total`     |Total user and system CPU time spent in seconds| float    |
| `go_goroutines`                 |Number of goroutine that currently exist| int      |

## Faq {#faq}

[Why no data](../datakit/why-no-data.md)

## Extended reading {#more-reading}

- [TAG best practices](../best-practices/insight/tag.md)
- [Multiple Kubernetes cluster metric best practices](../best-practices/cloud-native/multi-cluster.md)
