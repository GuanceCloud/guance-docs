---
title     : 'Prometheus CRD'
summary   : 'Support for Prometheus-Operator CRD and collection of corresponding metrics'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
__int_icon: 'icon/kubernetes'
---

## Introduction {#intro}

This document describes how to enable Datakit to support Prometheus-Operator CRD and collect corresponding metrics.

## Description {#description}

Prometheus has a comprehensive Kubernetes application metrics collection solution. The process is briefly described as follows:

1. Create Prometheus-Operator in the Kubernetes cluster.
2. Based on requirements, create the corresponding CRD instances. These instances must include necessary configurations for collecting target metrics, such as `matchLabels`, `port`, `path`, etc.
3. Prometheus-Operator will monitor the CRD instances and start metric collection based on their configuration items.

<!-- markdownlint-disable MD046 -->
???+ attention

    [Official link for Prometheus-Operator](https://github.com/prometheus-operator/prometheus-operator){:target="_blank"} and [application examples](https://alexandrev.medium.com/prometheus-concepts-servicemonitor-and-podmonitor-8110ce904908){:target="_blank"}.
<!-- markdownlint-enable -->

In this context, Datakit plays the role of step 3, monitoring and discovering Prometheus-Operator CRDs, initiating metric collection based on the configuration, and ultimately uploading them to Guance.

Currently, Datakit supports two types of Prometheus-Operator CRD resources —— `PodMonitor` and `ServiceMonitor`, along with their required (require) configurations, including the following parts:

```markdown
- PodMonitor [monitoring.coreos.com/v1]
    - podTargetLabels
    - podMetricsEndpoints:
        - interval
          port
          path
          params
    - namespaceSelector:
        any
        matchNames
- ServiceMonitor:
    - bearerTokenFile
    - targetLabels
    - podTargetLabels
    - endpoints:
        - interval
          port
          path
          params
          tlsConfig
              caFile
              certFile
              keyFile
              insecureSkipVerify
    - namespaceSelector:
        any
        matchNames
```

Note: `tlsConfig` does not currently support obtaining certificates from Kubernetes Secret/ConfigMap.

The `params` field supports specifying the data's Mearsurement using the `measurement` field, for example:

```yaml
params:
    measurement:
    - new-measurement
```

## Example {#example}

Take a Nacos cluster as an example.

Install Nacos:

<!-- markdownlint-disable MD014 -->
```shell
$ git clone https://github.com/nacos-group/nacos-k8s.git
$ cd nacos-k8s
$ chmod +x quick-startup.sh
$ ./quick-startup.sh
```
<!-- markdownlint-enable -->

*nacos/nacos-quick-start.yaml* container port configuration:

```yaml
containers:
  - name: k8snacos
    imagePullPolicy: Always
    image: nacos/nacos-server:latest
    ports:
      - containerPort: 8848
        name: client
      - containerPort: 9848
        name: client-rpc
      - containerPort: 9849
        name: raft-rpc
      - containerPort: 7848
        name: old-raft-rpc
```

- Metrics interface: `$IP:8848/nacos/actuator/prometheus`
- Metrics port: 8848

Now there is a Nacos metrics service in the Kubernetes cluster that can be used for metric collection.

### Create Prometheus-Operator CRD {#create-crd}

- Install Prometheus-Operator

<!-- markdownlint-disable MD014 -->
```shell
$ wget https://github.com/prometheus-operator/prometheus-operator/releases/download/v0.62.0/bundle.yaml
$ kubectl apply -f bundle.yaml
$ kubectl get crd

NAME                                        CREATED AT
alertmanagerconfigs.monitoring.coreos.com   2022-08-11T03:15:57Z
alertmanagers.monitoring.coreos.com         2022-08-11T03:15:57Z
podmonitors.monitoring.coreos.com           2022-08-11T03:15:57Z
probes.monitoring.coreos.com                2022-08-11T03:15:57Z
prometheuses.monitoring.coreos.com          2022-08-11T03:15:57Z
servicemonitors.monitoring.coreos.com       2022-08-11T03:15:57Z
thanosrulers.monitoring.coreos.com          2022-08-11T03:15:57Z
```
<!-- markdownlint-enable -->

- Create PodMonitor

<!-- markdownlint-disable MD014 -->
``` shell
$ cat pod-monitor.yaml

apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  name: nacos
  labels:
    app: nacos
spec:
  podMetricsEndpoints:
  - port: client
    interval: 15s
    path: /nacos/actuator/prometheus
  namespaceSelector:
    matchNames:
    - default
  selector:
    matchLabels:
      app: nacos

$ kubectl apply -f pod-monitor.yaml
```
<!-- markdownlint-enable -->

Several important configuration items need to match those of Nacos:

- namespace: default
- app: `nacos`
- port: client
- path: `/nacos/actuator/prometheus`

Refer to the [documentation](https://doc.crds.dev/github.com/prometheus-operator/kube-prometheus/monitoring.coreos.com/PodMonitor/v1@v0.7.0){:target="_blank"} for configuration parameters. Currently, Datakit only supports the require section and does not support authentication configurations such as `baseAuth`, `bearerTokenSecret`, and `tlsConfig`.

### Metrics Set and Tags {#measurement-and-tags}

Refer to [this reference](kubernetes-prom.md#measurement-and-tags).

### Verification {#check}

Start Datakit and use `datakit monitor -V` or check on the Guance page to find metrics sets starting with `nacos_`. This indicates successful collection.