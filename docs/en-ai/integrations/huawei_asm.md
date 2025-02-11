---
title: 'Huawei Cloud ASM Tracing Data to Guance'
tags: 
  - Huawei Cloud
summary: 'Exporting tracing data from Huawei Cloud ASM to Guance for viewing and analysis.'
__int_icon: 'icon/huawei_asm'
---

<!-- markdownlint-disable MD025 -->
# Huawei Cloud ASM Tracing Data to Guance
<!-- markdownlint-enable -->

Exporting tracing data from Huawei Cloud ASM to Guance for viewing and analysis.

## Configuration {#config}

### Prerequisites
Before using ASM, you need to purchase a CCE cluster and deploy the `datakit` [`daemonset`](https://docs.guance.com/datakit/datakit-daemonset-deploy/).

### Creation of ASM
Service Mesh => Purchase Mesh => Basic Edition
![img](imgs/huawei_asm/huawei_asm.png)

Enter the mesh name, select the `istio` version, choose the cluster version and `istio` control nodes, and submit directly.

![img](imgs/huawei_asm/huawei_asm01.png)

After approximately 1-3 minutes, the installation completion page will look like this:

![img](imgs/huawei_asm/huawei_asm02.png)

After installation, create the `bookinfo` application.

![img](imgs/huawei_asm/huawei_asm03.png)

Before installation, prepare a load balancer; I have already prepared one. Select it, choose port 80 externally, select the image repository address as `docker.io/istio`, and install.

![img](imgs/huawei_asm/huawei_asm04.png)

View the created gateway and services.

![img](imgs/huawei_asm/huawei_asm05.png)
![img](imgs/huawei_asm/huawei_asm06.png)

Access `http://124.70.68.49/productpage` to check if the service is running normally.

![img](imgs/huawei_asm/huawei_asm07.png)

### Sending Tracing Data to Guance

#### Enable OpenTelemetry Collector

Refer to the [OpenTelemetry collector integration documentation](https://docs.guance.com/datakit/opentelemetry/).

- Add to ConfigMap

```shell
opentelemetry.conf: |
      [[inputs.opentelemetry]]
          [inputs.opentelemetry.http]
            enable = true
            http_status_ok = 200
            trace_api = "/otel/v1/trace"
            metric_api = "/otel/v1/metric"
          [inputs.opentelemetry.grpc]
            trace_enable = true
            metric_enable = true
            addr = "0.0.0.0:4317"
```

- Mount `opentelemetry.conf`

```shell
- mountPath: /usr/local/datakit/conf.d/opentelemetry/opentelemetry.conf
    name: datakit-conf
    subPath: opentelemetry.conf
```

Redeploy `datakit`

```shell
kubectl apply -f datakit.yaml
```

After deployment, check if `opentelemetry` is enabled in the monitor.

```shell
# kubectl exec -it -n datakit pods/datakit-lfb95 datakit monitor
```

![img](imgs/huawei_asm/huawei_asm08.png)

#### Modify ASM Output Address

For testing convenience, first modify the sampling rate of ASM.

```shell
# kubectl edit -n istio-system cm istio-1-15-5-r4
...
sampling: 100   # Change this parameter from 1 to 100
...
```

Modify ASM output to Guance.

```shell
# kubectl edit -n monitoring cm otel-collector-conf
...
exporters:
      apm:
        address: "100.125.0.78:8923"
        project_id: f5f4c067d68b4b3aad86e173b18367bf
        cluster_id: 5f642ce9-4aca-11ee-9dbd-0255ac10024d
      otlp:   # Add otlp output
        endpoint: "http://datakit-service.datakit:4317"
        tls:
          insecure: true
        compression: none # Do not enable gzip
...
traces/apm:
          receivers: [ zipkin ]
          processors: [ memory_limiter, batch ]
          exporters: [ otlp ]   # Change exporter to otlp
```

![img](imgs/huawei_asm/huawei_asm09.png)

After configuration changes, access `http://124.70.68.49/productpage` a few times, then check the traces in the Guance workspace.

![img](imgs/huawei_asm/huawei_asm10.png)

Click on a trace to view detailed information.

![img](imgs/huawei_asm/huawei_asm11.png)

### Sending Metrics Data to Guance
#### Metric Collection Configuration

1. Enable `Prometheus Exporter` data collection in DataKit. Refer to [**Prometheus Exporter**](https://docs.guance.com/integrations/prom/#__tabbed_1_2). The ConfigMap is as follows:

   ```yaml
       prom.conf: |
         [[inputs.prom]]
           urls = ["http://istiod.istio-system:15014/metrics"] ## istiod address
           uds_path = ""
           ignore_req_err = false
           source = "prom"
           measurement_prefix = ""
           measurement_name = "istio_prom"
   ```

2. Mount the configuration file:

   ```yaml
           - mountPath: /usr/local/datakit/conf.d/prom/prom.conf
             name: datakit-conf
             subPath: prom.conf
   ```

3. Redeploy DataKit:

   ```yaml
   Kubectl apply -f datakit.yml 
   ```