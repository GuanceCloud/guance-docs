---
title     : 'Prometheus CRD'
summary   : 'Support for Prometheus-Operator CRD and collection of corresponding metrics'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
__int_icon: 'icon/kubernetes'
---

## Introduction {#intro}

This document explains how to enable Datakit to support Prometheus-Operator CRD and collect corresponding metrics.

## Description {#description}

Prometheus has a comprehensive Kubernetes application metric collection solution. The process is briefly described as follows:

1. Create Prometheus-Operator in the Kubernetes cluster
2. Based on requirements, create corresponding CRD instances. These instances must carry necessary configurations for collecting target metrics, such as `matchLabels`, `port`, `path`, etc.
3. Prometheus-Operator listens to CRD instances and initiates metric collection based on their configurations.

<!-- markdownlint-disable MD046 -->
???+ attention

    Prometheus-Operator [official link](https://github.com/prometheus-operator/prometheus-operator){:target="_blank"} and [application examples](https://alexandrev.medium.com/prometheus-concepts-servicemonitor-and-podmonitor-8110ce904908){:target="_blank"}.
<!-- markdownlint-enable -->

Here, Datakit plays the role of step 3 by listening and discovering Prometheus-Operator CRDs, initiating metric collection based on configurations, and finally uploading the data to Guance.

Currently, Datakit supports two types of Prometheus-Operator CRD resources —— `PodMonitor` and `ServiceMonitor`, along with their required configurations, which include the following parts:

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

Note: `tlsConfig` does not currently support retrieving certificates from Kubernetes Secrets/ConfigMaps.

The `params` field supports specifying the data's Metrics set using the `measurement` field, for example:

```yaml
params:
    measurement:
    - new-measurement
```

## Example {#example}

Using an Nacos cluster as an example.

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

Now there is an Nacos metrics service available for metric collection in the Kubernetes cluster.

### Creating Prometheus-Operator CRD {#create-crd}

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

Refer to the [documentation](https://doc.crds.dev/github.com/prometheus-operator/kube-prometheus/monitoring.coreos.com/PodMonitor/v1@v0.7.0){:target="_blank"} for configuration parameters. Currently, Datakit only supports the required sections and does not support authentication configurations such as `baseAuth`, `bearerTokenSecret`, and `tlsConfig`.

### Metrics Set and Tags {#measurement-and-tags}

Refer to [this section](kubernetes-prom.md#measurement-and-tags) for more details.

### Verification {#check}

Start Datakit and use `datakit monitor -V` or check on the Guance page to find Metrics sets starting with `nacos_`. This indicates successful collection.