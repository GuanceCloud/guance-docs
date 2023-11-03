---
title: 'HUAWEI ASM'
summary: 'The link tracking data from HUAWEI CLOUD's ASM is exported to Guance for viewing and analysis.'
__int_icon: 'icon/huawei_asm'
---

<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD ASM
<!-- markdownlint-enable -->

The link tracking data from HUAWEI CLOUD ASM is exported to Guance for viewing and analysis.

## Config {#config}

### Preparatory work
The prerequisite for using ASM is to have purchased a CCE (Cloud Container Engine) cluster.Deploy the  `datakit`  [`daemonset`](https://docs.guance.com/en/datakit/datakit-daemonset-deploy/).


### Creating ASM
Service Mesh -> Purchasing a Mesh -> Basic Edition
![img](imgs/huawei_asm/huawei_asm.png)

Grid name," select the "**Istio**" version, choose the cluster version, and the control nodes for "**Istio**", then submit directly.

After approximately 1-3 minutes, the installed page will displays the running status of ASM, billing methods, and the number and status of clusters, instances, and **grayscale** tasks.

After the installation is completed, create the "**bookinfo**" application.

Before installation, you need to prepare a load balancer. Here, I have already prepared it. You can select it, choose port 80 for external access, and select the Docker image repository address as `docker.io/istio`. Then, proceed with the installation.

After that, it will view the created services and gateways in chart of 'service management' and 'gateway management'.

Accessing the external access address (such as `http://external-access-address-ip/productpage`) to check if the service is functioning properly.

![img](imgs/huawei_asm/huawei_asm07.png)

### Sending trace data to the Guance

#### Enable the OpenTelemetry collector

Reference[`OpenTelemetry` Documentation for Integrating the Collector](https://docs.guance.com/datakit/opentelemetry/)

- ConfigMap Add

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

After deployment, check in the monitor to see if "**opentelemetry**" has been enabled.

```shell
# kubectl exec -it -n datakit pods/datakit-lfb95 datakit monitor
```

![img](imgs/huawei_asm/huawei_asm08.png)

#### Modify the ASM output address

To facilitate testing, first modify the sampling rate of ASM

```shell
# kubectl edit -n istio-system cm istio-1-15-5-r4
...
sampling: 100   #This parameter has been changed from 1 to 100.
...
```

Modify ASM output to the Guance

```shell
# kubectl edit -n monitoring cm otel-collector-conf
...
exporters:
      apm:
        address: "100.125.0.78:8923"
        project_id: f5f4c067d68b4b3aad86e173b18367bf
        cluster_id: 5f642ce9-4aca-11ee-9dbd-0255ac10024d
      otlp:   # Add OTLP output.
        endpoint: "http://datakit-service.datakit:4317"
        tls:
          insecure: true
        compression: none 
...
traces/apm:
          receivers: [ zipkin ]
          processors: [ memory_limiter, batch ]
          exporters: [ otlp ]   #Change the output to OTLP.
```

![img](imgs/huawei_asm/huawei_asm09.png)

After configuring the changes, let's access the address `http://124.70.68.49/productpage` several times. Then, go to the Guance workspace, into the 'APM' -> 'Traces', select the host ip, and enter 'All Traces', you can check the traces.

Click on a trace, and point the 'Service Invocation Relation' to view detailed information.
