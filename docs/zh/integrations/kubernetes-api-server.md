---
title     : 'Kubernetes API Server'
summary   : '采集 Kubernetes API Server 相关指标信息'
__int_icon: 'icon/kubernetes'
dashboard :
  - desc  : 'Kubernetes API Server 监控视图'
    path  : 'dashboard/zh/kubernetes_api_server'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Kubernetes API Server
<!-- markdownlint-enable -->


Kubernetes API Server 性能指标展示，包括请求数、工作队列增速、工作队列深度、 CPU 、 Memory 、 Goroutine 等


## 配置 {#config}

### 版本支持

- 操作系统支持：Linux

- Kubernetes 版本：1.18+

### 前置条件

- 已部署 DataKit，请参考 Kubernetes 集群 <[安装 Datakit](../datakit/datakit-daemonset-deploy.md)>

- 采集 Kubernetes API Server 指标数据，[需要 Kubernetes 安装 Metrics-Server 组件](https://github.com/kubernetes-sigs/metrics-server#installation){:target="_blank"}。

### 指标采集

- 使用`yaml` 创建`bearer-token`授权信息

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

- 获取bearer_token

```shell
kubectl get secret `kubectl get secret -ndefault | grep bearer-token | awk '{print $1}'` -o jsonpath={.data.token} | base64 -d
```


- ConfigMap 增加 `api-server.conf` 配置

在部署 DataKit 使用的 `datakit.yaml` 文件中，ConfigMap 资源中增加 `api-server.conf`。

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
  #### api-server ##下面是新增部分
  api-server.conf: |-
    [[inputs.prom]]
      ## Exporter地址或者文件路径（Exporter地址要加上网络协议http或者https）
      ## 文件路径各个操作系统下不同
      ## Windows example: C:\\Users
      ## UNIX-like example: /usr/local/
      url = "https://172.31.16.148:6443/metrics"
      ## 采集器别名
      source = "prom-api-server"

      ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
      # 默认只采集 counter 和 gauge 类型的指标
      # 如果为空，则不进行过滤
      metric_types = ["counter", "gauge"]

      ## 指标名称过滤
      # 支持正则，可以配置多个，即满足其中之一即可
      # 如果为空，则不进行过滤
      #metric_name_filter = [""]

      ## 指标集名称前缀
      # 配置此项，可以给指标集名称添加前缀
      #measurement_prefix = "prom_api_server"

      ## 指标集名称
      # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
      # 如果配置measurement_name, 则不进行指标名称的切割
      # 最终的指标集名称会添加上measurement_prefix前缀
      measurement_name = "prom_api_server"

      ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
      interval = "60s"

      ## 过滤tags, 可配置多个tag
      # 匹配的tag将被忽略
      tags_ignore = ["apiservice","bound","build_date","compiler","component","crd","dry_run","endpoint","error_type","flow_schema","git_commit","git_tree_state","git_version","go_version","group","grpc_code","grpc_method","grpc_service","grpc_type","kind","major","method","minor","operation","platform","priority_level","reason","rejection_code","removed_release","request_kind","resource","result","scope","source","status","subresource","type","usage","username","verb","version"]
      metric_name_filter = ["workqueue_adds_total","workqueue_depth","apiserver_request_total","process_resident_memory_bytes","process_cpu_seconds_total","go_goroutines"]
      
      ## TLS 配置
      tls_open = true
      tls_ca = "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
      #tls_cert = "/etc/kubernetes/pki/apiserver.crt"
      #tls_key = "/etc/kubernetes/pki/apiserver.key"

      ## 自定义指标集名称
      # 可以将包含前缀prefix的指标归为一类指标集
      # 自定义指标集名称配置优先measurement_name配置项
      #[[inputs.prom.measurements]]
      #  prefix = ""
      #  name = ""

      ## 自定义认证方式，目前仅支持 Bearer Token
      [inputs.prom.auth]
       type = "bearer_token"
       token = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImlfX2V6UXdXWkpKUWZ6QlBxTGdSRTBpa0J1a2VpQUU3Q0JMWGFfYWNDYWcifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImJlYXJlci10b2tlbi10b2tlbi05emI5dCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJiZWFyZXItdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJkNWQxNDkzNi00NmM1LTRjZjMtYmI2MS00ODhhOTFiYTRjMTQiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpiZWFyZXItdG9rZW4ifQ.sBQUGE67N6BV6mnC0g72k8ciiSjEZ-ctFjHcyiP_rBp9paUnGwd3ouheF0ddGormn6esOGR1t6vvDdta9BiE3i5mHpJsOifkVXzv85N3qllJfSpXvIIn-LNq-wxnK55QbOhXQjeFKF0PBanJk4m_kWCM6SOuFrH9s8cHGhKEVCYw_7ScUwHCDGQVUq_zKCfKll20GHSwhlzjjt2tz07UYdQs5kQ9AN8VbM9qNIJmpasPOeqod9hTbevnL3kO5Lcd4h4NUOT8JfJ2Om72NvH71-xWNH0U_Hqf2yS0_ZlnneBESq4FDjbm1VnJPxeIOJL0dMaoRJVPPtA0yUhX5MYV7A"
       #token_file = "/var/run/secrets/kubernetes.io/serviceaccount/token"

      ## 自定义Tags
      [inputs.prom.tags]
        instance = "172.31.16.148:6443"
```

- 参数说明：

- url：api-server metrics 地址
- source：采集器别名
- metric_types：指标类型过滤
- metric_name_filter：指标名称过滤
- measurement_prefix：指标集名称前缀
- measurement_name：指标集名称
- interval：采集间隔
- tags_ignore: 忽略的 tag
- metric_name_filter: 保留的指标名
- tls_open：是否忽略安全验证 (如果是 HTTPS，请设置为 true，并设置相应证书)，此处为 true
- tls_ca：ca 证书路径
- type：自定义认证方式，api-server 使用 bearer_token 认证
- token_file：认证文件路径
- inputs.prom.tags：请参考插件标签

- 挂载 `api-server.conf`

在 `datakit.yaml` 文件的 `volumeMounts` 下面增加下面内容。

```yaml
- mountPath: /usr/local/datakit/conf.d/prom/api-server.conf
  name: datakit-conf
  subPath: api-server.conf
```

- Kubernetes默认已暴露指标，可以直接通过 curl 方式来查看相关指标。

```shell
curl -k "https://172.31.16.148:6443/metrics" -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImlfX2V6UXdXWkpKUWZ6QlBxTGdSRTBpa0J1a2VpQUU3Q0JMWGFfYWNDYWcifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImJlYXJlci10b2tlbi10b2tlbi05emI5dCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJiZWFyZXItdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJkNWQxNDkzNi00NmM1LTRjZjMtYmI2MS00ODhhOTFiYTRjMTQiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpiZWFyZXItdG9rZW4ifQ.sBQUGE67N6BV6mnC0g72k8ciiSjEZ-ctFjHcyiP_rBp9paUnGwd3ouheF0ddGormn6esOGR1t6vvDdta9BiE3i5mHpJsOifkVXzv85N3qllJfSpXvIIn-LNq-wxnK55QbOhXQjeFKF0PBanJk4m_kWCM6SOuFrH9s8cHGhKEVCYw_7ScUwHCDGQVUq_zKCfKll20GHSwhlzjjt2tz07UYdQs5kQ9AN8VbM9qNIJmpasPOeqod9hTbevnL3kO5Lcd4h4NUOT8JfJ2Om72NvH71-xWNH0U_Hqf2yS0_ZlnneBESq4FDjbm1VnJPxeIOJL0dMaoRJVPPtA0yUhX5MYV7A"
```

- 重启 DataKit

```yaml
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```


### 插件标签 (必选）

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，api-server 指标都会带有如下类似的标签，可以进行快速查询
- 采集 api-server 指标，必填的 key 是 instance，值是 api-server 的地址

```toml
    ## 自定义Tags
      [inputs.prom.tags]
          instance = "172.16.0.229:6443"
```

重启 DataKit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## 指标 {#metric}

| 指标                          | 描述                                                         | 数据类型 |
| ----------------------------- | ------------------------------------------------------------ | -------- |
| `apiserver_request_total`       | Counter of apiserver requests broken out for each verb, dry run value, group, version, resource, scope, component, and HTTP response code. | int      |
| `workqueue_adds_total`          | Total number of adds handled by workqueue                    | int      |
| `workqueue_depth`               | Current depth of workqueue                                   | int      |
| `process_resident_memory_bytes` | Resident memory size in bytes                                | B        |
| `process_cpu_seconds_total`     | Total user and system CPU time spent in seconds              | float    |
| `go_goroutines`                 | Number of goroutine that currently exist                    | int      |

## 常见问题排查 {#faq}

<[无数据上报排查](../datakit/why-no-data.md)>

## 延伸阅读 {#more-reading}

- <[TAG 在观测云中的最佳实践](../best-practices/insight/tag.md)>
- <[多个 Kubernetes 集群指标采集最佳实践](../best-practices/cloud-native/multi-cluster.md)>
