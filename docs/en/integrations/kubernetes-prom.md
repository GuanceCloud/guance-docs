---
title     : 'Kubernetes Prometheus Exporter'
summary   : 'Collect Prometheus Metrics exposed by custom Pods in a Kubernetes cluster'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
__int_icon: 'icon/kubernetes'
---

:fontawesome-brands-linux: :material-kubernetes:

---

## Introduction {#intro}

**Deprecated, related features have been moved to [KubernetesPrometheus Collector](kubernetesprometheus.md).**

This document explains how to collect Prometheus metrics exposed by custom Pods in a Kubernetes cluster. There are two ways:

- Expose the metric interface to DataKit via Annotations
- Automatically discover Kubernetes Endpoint Services to Prometheus and expose the metric interface to DataKit

The following will detail the usage of both methods.

## Using Annotations to Open Metric Interfaces {#annotations-of-prometheus}

Specific template annotations need to be added to the Kubernetes deployment to collect metrics exposed by the created Pods. The annotation requirements are as follows:

- Key must be fixed `datakit/prom.instances`
- Value is the complete configuration for the [prom collector](prom.md), for example:

```toml
[[inputs.prom]]
  urls   = ["http://$IP:9100/metrics"]
  source = "<your-service-name>"
  measurement_name = "<measurement-metrics>"
  interval = "30s"

  [inputs.prom.tags]
    # namespace = "$NAMESPACE"
    # pod_name = "$PODNAME"
    # node_name = "$NODENAME"
```

The following placeholders are supported:

- `$IP`: Wildcard for Pod's internal IP
- `$NAMESPACE`: Pod Namespace
- `$PODNAME`: Pod Name
- `$NODENAME`: Node name where the Pod resides

<!-- markdownlint-disable MD046 -->
!!! tip

    The Prom collector does not automatically add tags such as `namespace` and `pod_name`. You can use placeholders in the above config to add extra tags, for example:

    ``` toml
      [inputs.prom.tags]
        namespace = "$NAMESPACE"
        pod_name = "$PODNAME"
        node_name = "$NODENAME"
    ```
<!-- markdownlint-enable -->

### Steps {#steps}

- Log in to the host where Kubernetes is located
- Open `deployment.yaml` and add template annotations as shown below:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prom-deployment
  labels:
    app: prom
spec:
  template:
    metadata:
      labels:
        app: prom
      annotations:
        datakit/prom.instances: |
          [[inputs.prom]]
            urls   = ["http://$IP:9100/metrics"]
            source = "<your-service-name>"
            interval = "30s"
            [inputs.prom.tags]
              namespace = "$NAMESPACE"
              pod_name  = "$PODNAME"
              node_name = "$NODENAME"
```

<!-- markdownlint-disable MD046 -->
???+ attention

    `annotations` must be added under the `template` field so that the *deployment.yaml* created Pods carry `datakit/prom.instances`.
<!-- markdownlint-enable -->

- Create resources with the new yaml

```shell
kubectl apply -f deployment.yaml
```

At this point, Annotations have been added. DataKit will later read the Pod's Annotations and collect the metrics exposed at the `url`.

## Automatic Discovery of Prometheus Metrics for Pods/Services {#auto-discovery-metrics-with-prometheus}

[:octicons-tag-24: Version-1.5.10](../datakit/changelog.md#cl-1.5.10)

Based on specified Annotations for Pods or Services, an HTTP URL is constructed and used to create Prometheus metric collection.

This feature is disabled by default. To enable it in Datakit, add the following two environment variables as needed; see [container documentation](container.md) for details:

- `ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_POD_ANNOTATIONS`: `"true"`
- `ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_ANNOTATIONS`: `"true"`

**Note, this feature may generate a large number of time series.**

### Example {#auto-discovery-metrics-with-prometheu-example}

Using the example of adding Annotations to a Service. Use the following yaml configuration to create Pods and Services, and add `prometheus.io/scrape` and other Annotations to the Service:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  namespace: ns-testing
  labels:
    app.kubernetes.io/name: proxy
spec:
  containers:
  - name: nginx
    image: nginx:stable
    ports:
      - containerPort: 80
        name: http-web-svc

---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  namespace: ns-testing
  annotations:
    prometheus.io/scrape: "true"
    prometheus.io/port: "80"
spec:
  selector:
    app.kubernetes.io/name: proxy
  ports:
  - name: name-of-service-port
    protocol: TCP
    port: 8080
    targetPort: http-web-svc
```

Datakit will automatically discover Services with `prometheus.io/scrape: "true"`, find matching Pods through `selector`, and build prom collection:

- `prometheus.io/scrape`: Only collects Services set to "true", mandatory option.
- `prometheus.io/port`: Specifies the metrics port, mandatory option. Note that this port must exist in the Pod otherwise collection will fail.
- `prometheus.io/scheme`: Selects between `https` and `http` based on the metrics endpoint, default is `http`.
- `prometheus.io/path`: Configures the metrics path, default is `/metrics`.
- `prometheus.io/param_measurement`: Configures the measurement name, default is the parent OwnerReference of the current Pod.

The IP address for the collection target is `PodIP`.

<!-- markdownlint-disable MD046 -->
???+ attention


    Datakit does not collect the Service itself but collects the paired Pod of the Service.
<!-- markdownlint-enable -->

Default collection interval is 1 minute.

### Measurements and Tags {#measurement-and-tags}

Automatic discovery of Pod/Service Prometheus metrics has four naming cases for measurements, prioritized as follows:

1. Manually configured measurement

    - Configure `prometheus.io/param_measurement` in Pod/Service Annotations, its value being the specified measurement name, for example:

      ```yaml
      apiVersion: v1
      kind: Pod
      metadata:
        name: testing-prom
        labels:
          app.kubernetes.io/name: MyApp
        annotations:
          prometheus.io/scrape: "true"
          prometheus.io/port: "8080"
          prometheus.io/param_measurement: "pod-measurement"
      ```

      Its Prometheus data measurement is `pod-measurement`.

    - If using Prometheus PodMonitor/ServiceMonitor CRDs, you can specify `measurement` using `params`, for example:

      ```yaml
      params:
          measurement:
          - new-measurement
      ```

1. Derived from data slicing

    - By default, it slices the metric name using underscores `_`, the first field after slicing becomes the measurement name, and the remaining fields become the current metric name.

      For example, consider the following Prometheus raw data:

      ```not-set
      # TYPE promhttp_metric_handler_errors_total counter
      promhttp_metric_handler_errors_total{cause="encoding"} 0
      ```

      The first underscore separates `promhttp` as the measurement name and `metric_handler_errors_total` as the field name.

    - To ensure the field name matches the original Prom data, the container collector supports "retaining the original prometheus metric name," which can be enabled as follows:

        - Configuration file setting is `keep_exist_prometheus_metric_name = true`
        - Environment variable is `ENV_INPUT_CONTAINER_KEEP_EXIST_PROMETHEUS_METRIC_NAME = "true"`

      Taking the `promhttp_metric_handler_errors_total` data as an example, after enabling this function, the measurement is `promhttp`, and the field name remains uncut, using the original value `promhttp_metric_handler_errors_total`.

Datakit adds extra tags to locate this resource within the Kubernetes cluster:

- For `Service`, it adds `namespace`, `service_name`, and `pod_name` three tags
- For `Pod`, it adds `namespace` and `pod_name` two tags

### Collecting Current Kubernetes Prometheus Data {#kube-self-metrtic}

This feature is experimental and may change in the future.

Datakit supports simple configuration using the environment variable `ENV_INPUT_CONTAINER_ENABLE_K8S_SELF_METRIC_BY_PROM="true"` to start collecting Prometheus data from the Kubernetes cluster.

Data sources include APIServer, Controller, etc., the collection method refers to the following:

<!-- markdownlint-disable -->
| Resource   | From                   | Election | Measurement      | Method                                        |
| ---        | --                     | --       | --               | --                                            |
| APIServer  | Kubernetes             | true     | `kube-apiserver`   | `https://kubernetes.default.com:443/metrics`    |
| Controller | Kubernetes Static Pods | false    | `kube-controller`  | `https://127.0.0.1:10257/metrics`               |
| Scheduler  | Kubernetes Static Pods | false    | `kube-scheduler`   | `https://127.0.0.1:10259/metrics`               |
| Etcd       | Kubernetes Static Pods | false    | `kube-etcd`        | `https://127.0.0.1:2379/metrics` (requires certificate configuration) |
| CoreDNS    | Kubernetes Pods        | true     | `kube-coredns`     | `http://Endpoint-IP:Port/metrics`               |
| Proxy      | Kubernetes Proxy       | false    | `kube-proxy`       | `http://127.0.0.1:10249/metrics`                |
| cAdvisor   | Kubelet cAdvisor       | false    | `kubelet-cadvisor` | `https://127.0.0.1:10250/metrics/cadvisor`      |
| Resource   | Kubelet Resource       | false    | `kubelet-resource` | `https://127.0.0.1:10250/metrics/resource`      |
<!-- markdownlint-enable -->

- Kubernetes-related services (APIServer, Controller, Scheduler) use BearerToken for authentication.

- For Static Pods, Datakit first checks if such Pods exist on the current Node, for example, `kubectl get pod -n kube-system -l tier=control-plane,component=kube-scheduler --field-selector spec.nodeName=Node-01` to check if Scheduler service exists on Node-01. If it exists, it collects data according to the default url.

Collecting Etcd requires configuring certificates, follow these steps:

1. Ask the Kubernetes administrator for the Etcd certificate storage path. For example:

```shell
$ ls /etc/kubernetes/pki/etcd
ca.crt  ca.key  healthcheck-client.crt  healthcheck-client.key  peer.crt  peer.key  server.crt  server.key
```

1. Create a Secret using the Etcd certificate, command as follows:

```shell
$ kubectl create secret generic datakit-etcd-ssl --from-file=/etc/kubernetes/pki/etcd/ca.crt --from-file=/etc/kubernetes/pki/etcd/peer.crt --from-file=/etc/kubernetes/pki/etcd/peer.key -n datakit
secret/datakit-etcd-ssl created
```

1. Add the following configuration to the Datakit yaml:

```yaml
    spec:
      containers:
      - name: datakit
        env:
        - name: ENV_INPUT_CONTAINER_ENABLE_K8S_SELF_METRIC_BY_PROM    # Enable collection of Kubernetes Prometheus data
          value: "true"
        - name: ENV_INPUT_CONTAINER_K8S_SELF_METRIC_CONFIG    # Specify configuration and certificate paths
          value: '{"etcd":{"ca_file":"/tmp/etcd/ca.crt","cert_file":"/tmp/etcd/peer.crt","key_file":"/tmp/etcd/peer.key"}}' 
        volumeMounts:
        - name: etcd-ssl    # Add volumeMount
          mountPath: /tmp/etcd   
          
      # ..other..

      volumes:
      - name: etcd-ssl    # Create volume using Secret
        secret:
          secretName: datakit-etcd-ssl
```

The environment variable `ENV_INPUT_CONTAINER_K8S_SELF_METRIC_CONFIG` is a JSON configuration, format as follows:

```json
{
    "etcd": {
        "ca_file":   "/tmp/etcd/ca.crt",
        "cert_file": "/tmp/etcd/peer.crt",
        "key_file":  "/tmp/etcd/peer.key"
    }
}
```

**Note, if Datakit is deployed on a cloud platform, it no longer supports collecting Kubernetes system services and Etcd components because cloud platforms typically hide these resources and they cannot be queried anymore.**

## Further Reading {#more-readings}

- [Prometheus Exporter Data Collection](prom.md)