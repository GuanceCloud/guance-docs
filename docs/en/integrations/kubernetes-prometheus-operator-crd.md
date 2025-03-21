---
title     : 'Prometheus CRD'
summary   : 'Support Prometheus-Operator CRD and collect corresponding Metrics'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
__int_icon: 'icon/kubernetes'
---

## Introduction {#intro}

This document describes how to enable Datakit to support Prometheus-Operator CRD and collect corresponding Metrics.

## Description {#description}

Prometheus has a comprehensive Kubernetes application Metrics collection solution. The process is briefly described as follows:

1. Create Prometheus-Operator in the Kubernetes cluster
2. Based on requirements, create corresponding CRD instances that must carry necessary configurations for collecting target Metrics, such as `matchLabels` `port` `path` and other configurations.
3. Prometheus-Operator will listen to CRD instances and start Metric collection according to their configuration items.

<!-- markdownlint-disable MD046 -->
???+ attention

    Prometheus-Operator [official link](https://github.com/prometheus-operator/prometheus-operator){:target="_blank"} and [application example](https://alexandrev.medium.com/prometheus-concepts-servicemonitor-and-podmonitor-8110ce904908){:target="_blank"}.
<!-- markdownlint-enable -->

Here, Datakit plays the role of step 3, where Datakit listens and discovers Prometheus-Operator CRDs and initiates Metric collection based on configurations, ultimately uploading them to <<< custom_key.brand_name >>>.

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

`params` supports specifying the data Measurement set via the `measurement` field, for example:

```yaml
params:
    measurement:
    - new-measurement
```

## Example {#example}

Take the Nacos cluster as an example.

Install Nacos:

<!-- markdownlint-disable MD014 -->
```shell
$ git clone https://github.com/nacos-group/nacos-k8s.git
$ cd nacos-k8s
$ chmod +x quick-startup.sh
$ ./quick-startup.sh
```
<!-- markdownlint-enable -->

*nacos/nacos-quick-start.yaml* CONTAINERS port configuration:

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

- metrics interface: `$IP:8848/nacos/actuator/prometheus`
- metrics port: 8848

Now there is a Nacos Metrics service available in the Kubernetes cluster to collect Metrics.

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

Several important configuration items need to be consistent with Nacos:

- namespace: default
- app: `nacos`
- port: client
- path: `/nacos/actuator/prometheus`

Configuration parameters [documentation](https://doc.crds.dev/github.com/prometheus-operator/kube-prometheus/monitoring.coreos.com/PodMonitor/v1@v0.7.0){:target="_blank"}, currently Datakit only supports the require part, it does not yet support authentication configurations such as `baseAuth` `bearerTokenSecret` and `tlsConfig`.

### Measurements and Tags {#measurement-and-tags}

Refer to [here](kubernetes-prom.md#measurement-and-tags).

### Verification {#check}

Start Datakit, use `datakit monitor -V` or check on the <<< custom_key.brand_name >>> page; finding Metrics starting with `nacos_` indicates successful collection.