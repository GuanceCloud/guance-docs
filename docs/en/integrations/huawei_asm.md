---
title: 'Huawei Cloud ASM Tracing TO <<< custom_key.brand_name >>>'
tags: 
  - Huawei Cloud
summary: 'Output tracing data from Huawei Cloud ASM to <<< custom_key.brand_name >>> for viewing and analysis.'
__int_icon: 'icon/huawei_asm'
---

<!-- markdownlint-disable MD025 -->
# Huawei Cloud ASM Tracing TO <<< custom_key.brand_name >>>
<!-- markdownlint-enable -->

Output tracing data from Huawei Cloud ASM to <<< custom_key.brand_name >>> for viewing and analysis.

## Configuration {#config}

### Preparation
To use ASM, you need to purchase a CCE cluster and deploy the `datakit` [`daemonset`](<<< homepage >>>/datakit/datakit-daemonset-deploy/).

### Creation of ASM
Service Mesh => Purchase Mesh => Basic Edition
![img](imgs/huawei_asm/huawei_asm.png)

Grid name, select `istio` version, choose cluster version and `istio` control node, submit directly.

![img](imgs/huawei_asm/huawei_asm01.png)

After about 1~3 minutes, the installation completed page looks like this:

![img](imgs/huawei_asm/huawei_asm02.png)

After installation, create the `bookinfo` application.

![img](imgs/huawei_asm/huawei_asm03.png)

Before installation, we need to prepare a load balancer, which I have already done. Select it, choose external port as 80, select image repository address as `docker.io/istio`, then install.

![img](imgs/huawei_asm/huawei_asm04.png)

Check the created gateway and services.

![img](imgs/huawei_asm/huawei_asm05.png)

![img](imgs/huawei_asm/huawei_asm06.png)

Access `http://124.70.68.49/productpage` to check if the service is normal.

![img](imgs/huawei_asm/huawei_asm07.png)

### Sending Trace Data to <<< custom_key.brand_name >>>

#### Enable OpenTelemetry Collector

Refer to the [`OpenTelemetry` collector connection documentation](<<< homepage >>>/datakit/opentelemetry/)

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

After deployment, check in monitor whether `opentelemetry` has been enabled.

```shell
# kubectl exec -it -n datakit pods/datakit-lfb95 datakit monitor
```

![img](imgs/huawei_asm/huawei_asm08.png)

#### Modify asm Output Address

For easy testing, first modify the sampling rate of ASM.

```shell
# kubectl edit -n istio-system cm istio-1-15-5-r4
...
sampling: 100   # Change this parameter from 1 to 100
...
```

Modify asm output to <<< custom_key.brand_name >>>

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

After configuration modification, access the address `http://124.70.68.49/productpage` several times, then check the traces in <<< custom_key.brand_name >>> workspace.

![img](imgs/huawei_asm/huawei_asm10.png)

Click on a trace to view detailed information.

![img](imgs/huawei_asm/huawei_asm11.png)

### Sending Metrics Data to <<< custom_key.brand_name >>>
#### Metric Collection Configuration

1. Enable `Prometheus Exportter` data collection in DataKit. Refer to [**Prometheus Exportter**](<<< homepage >>>/integrations/prom/#__tabbed_1_2), ConfigMap as follows:


   ``` yaml
       prom.conf: |
         [[inputs.prom]]
           urls = ["http://istiod.istio-system:15014/metrics"] ## istiod address
           uds_path = ""
           ignore_req_err = false
           source = "prom"
           measurement_prefix = ""
           measurement_name = "istio_prom"
   ```

2. Mount configuration file


   ``` yaml
           - mountPath: /usr/local/datakit/conf.d/prom/prom.conf
             name: datakit-conf
             subPath: prom.conf
   ```

3. Redeploy DataKit


   ``` yaml
   Kubectl apply -f datakit.yml 
   ```