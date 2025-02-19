---
title     : 'Prometheus Push Gateway'
summary   : '开启 Pushgateway API，接收 Prometheus 指标数据'
tags:
  - '外部数据接入'
  - 'PROMETHEUS'
__int_icon      : 'icon/pushgateway'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker: · [:octicons-tag-24: Version-1.31.0](../datakit/changelog.md#cl-1.31.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

Pushgateway 采集器会开启对应的 API 接口，用于接收 Prometheus 指标数据。

## 配置  {#config}

<!-- markdownlint-disable MD046 -->

=== "主机部署"

    进入 DataKit 安装目录下的 `conf.d/pushgateway` 目录，复制 `pushgateway.conf.sample` 并命名为 `pushgateway.conf`。示例如下：

    ```toml
        
    [[inputs.pushgateway]]
      ## Prefix for the internal routes of web endpoints. Defaults to empty.
      route_prefix = ""
    
      ## Measurement name.
      ## If measurement_name is not empty, using this as measurement set name.
      # measurement_name = "prom_pushgateway"
    
      ## If job_as_measurement is true, use the job field for the measurement name.
      ## The measurement_name configuration takes precedence.
      job_as_measurement = false
    
      ## Keep Exist Metric Name.
      ## Split metric name by '_', the first field after split as measurement set name, the rest as current metric name.
      ## If the keep_exist_metric_name is true, keep the raw value for field names.
      keep_exist_metric_name = true
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 `ENV_DATAKIT_INPUTS`](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 `ENV_DEFAULT_ENABLED_INPUTS` 中加为默认采集器）：

    - **ENV_INPUT_PUSHGATEWAY_ROUTE_PREFIX**
    
        配置 endpoints 路由前缀
    
        **字段类型**: String
    
        **采集器配置字段**: `route_prefix`
    
        **示例**: `/v1/pushgateway`
    
    - **ENV_INPUT_PUSHGATEWAY_MEASUREMENT_NAME**
    
        配置指标集名称
    
        **字段类型**: String
    
        **采集器配置字段**: `measurement_name`
    
    - **ENV_INPUT_PUSHGATEWAY_JOB_AS_MEASUREMENT**
    
        是否使用 job 标签值作为指标集名称
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `job_as_measurement`
    
        **默认值**: false
    
    - **ENV_INPUT_PUSHGATEWAY_KEEP_EXIST_METRIC_NAME**
    
        是否保留原始的 Prometheus 字段名，详见 [Kubernetes Prometheus doc](kubernetes-prom.md#measurement-and-tags)
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `keep_exist_metric_name`
    
        **默认值**: true

<!-- markdownlint-enable -->

---

## 示例 {#example}

Pushgateway 采集器遵循 [Prometheus Pushgateway](https://github.com/prometheus/pushgateway?tab=readme-ov-file#prometheus-pushgateway) 协议，同时针对 Datakit 的采集特性有一些调整。目前支持以下功能：

- 接收 Prometheus 文本数据和 Protobuf 数据
- 在 URL 指定字符串 labels 和 base64 labels
- 解码 gzip 数据
- 指定指标集名称

下面是一个部署在 Kubernetes 集群中的简单示例：

- 开启 Pushgateway 采集器。此处选择在 Datakit YAML 以环境变量的方式开启。

```yaml
    # ..other..
    spec:
      containers:
      - name: datakit
        env:
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: dk,cpu,container,pushgateway  # 添加 pushgateway，开启采集器
    - name: ENV_INPUT_PUSHGATEWAY_ROUTE_PREFIX
      value: /v1/pushgateway               # 选填，指定 endpoints 路由前缀，目标路由会变成 "/v1/pushgateway/metrics"
    # ..other..
```

- 创建一个 Deployment，产生 Prometheus 数据并发送到 Datakit Pushgateway 的 API。

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pushgateway-client
  labels:
    app: pushgateway-client
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pushgateway-client
  template:
    metadata:
      labels:
        app: pushgateway-client
    spec:
      containers:
      - name: client
        image: pubrepo.guance.com/base/curl
        imagePullPolicy: IfNotPresent
        env:
        - name: MY_NODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
        - name: MY_POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: MY_POD_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: PUSHGATEWAY_ENDPOINT
          value: http://datakit-service.datakit.svc:9529/v1/pushgateway/metrics/job@base64/aGVsbG8=/node/$(MY_NODE_NAME)/pod/$(MY_POD_NAME)/namespace/$(MY_POD_NAMESPACE)
          ## job@base64 指定格式是 base64，使用命令 `echo -n hello | base64` 生成值 'aGVsbG8='
        args:
        - /bin/bash
        - -c
        - >
          i=100;
          while true;
          do
            ## 定期使用 cURL 命令向 Datakit Pushgateway API 发送数据
            echo -e "# TYPE pushgateway_count counter\npushgateway_count{name=\"client\"} $i" | curl --data-binary @- $PUSHGATEWAY_ENDPOINT;
            i=$((i+1));
            sleep 2;
          done
```

- 在观测云页面能看到指标集是 `pushgateway`，字段是 `count` 的指标数据。

## 指标集和 tags {#measurement-and-tags}

Pushgateway 采集器不会添加任何 tags。

指标集的命名有两种情况：

1. 使用配置项 `measurement_name` 指定指标集名称
1. 使用 job 标签值作为指标集名称
1. 对数据字段名称以下划线 `_` 进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
