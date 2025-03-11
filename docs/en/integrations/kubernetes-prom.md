---
title: 'Kubernetes Prometheus Exporter'
summary: 'Collect Prometheus Metrics exposed by custom Pods in Kubernetes clusters'
tags:
  - 'PROMETHEUS'
  - 'KUBERNETES'
__int_icon: 'icon/kubernetes'
---

:fontawesome-brands-linux: :material-kubernetes:

---

## Introduction {#intro}

**Deprecated, relevant features have been moved to [KubernetesPrometheus Collector](kubernetesprometheus.md).**

This document describes how to collect Prometheus Metrics exposed by custom Pods in Kubernetes clusters. There are two methods:

- Expose the metrics interface to DataKit via Annotations
- Automatically discover Kubernetes Endpoint Services to Prometheus and expose the metrics interface to DataKit

The following sections will detail the usage of both methods.

## Using Annotations to Expose Metrics Interface {#annotations-of-prometheus}

Specific template annotations need to be added to the Kubernetes deployment to collect metrics exposed by the created Pods. The annotations require the following:

- Key must be `datakit/prom.instances`
- Value is the complete configuration for the [Prometheus collector](prom.md), for example:

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

- `$IP`: Pod's internal IP
- `$NAMESPACE`: Pod Namespace
- `$PODNAME`: Pod Name
- `$NODENAME`: Node name where the Pod resides

<!-- markdownlint-disable MD046 -->
!!! tip

    The Prometheus collector does not automatically add tags like `namespace` and `pod_name`. You can use placeholders in the above config to add extra tags, for example:

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

- Apply the new yaml to create resources

```shell
kubectl apply -f deployment.yaml
```

At this point, the annotations have been added. DataKit will read the Pod's annotations and collect the metrics exposed at the specified `url`.

## Auto-discovery of Prometheus Metrics for Pods/Services {#auto-discovery-metrics-with-prometheus}

[:octicons-tag-24: Version-1.5.10](../datakit/changelog.md#cl-1.5.10)

Based on specified annotations for Pods or Services, an HTTP URL is constructed to create a Prometheus metric collection.

This feature is disabled by default. To enable it in Datakit, add the following two environment variables as needed; see [container documentation](container.md):

- `ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_POD_ANNOTATIONS`: `"true"`
- `ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_ANNOTATIONS`: `"true"`

**Note that this feature may generate a large number of time series.**

### Example {#auto-discovery-metrics-with-prometheu-example}

Using Service annotations as an example. Use the following YAML configuration to create Pods and Services with `prometheus.io/scrape` annotations:

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

Datakit will automatically discover Services annotated with `prometheus.io/scrape: "true"`, find matching Pods through `selector`, and build Prometheus collection:

- `prometheus.io/scrape`: Only collects Services set to "true", mandatory.
- `prometheus.io/port`: Specifies the metrics port, mandatory. This port must exist in the Pod, otherwise collection will fail.
- `prometheus.io/scheme`: Choose between `https` and `http` based on the metrics endpoint, defaults to `http`.
- `prometheus.io/path`: Configure the metrics path, defaults to `/metrics`.
- `prometheus.io/param_measurement`: Configure the measurement name, defaults to the parent OwnerReference of the current Pod.

The IP address of the collection target is the `PodIP`.

<!-- markdownlint-disable MD046 -->
???+ attention

    Datakit does not collect the Service itself but rather the matched Pod associated with the Service.
<!-- markdownlint-enable -->

Default collection interval is 1 minute.

### Measurements and Tags {#measurement-and-tags}

For auto-discovered Pod/Service Prometheus, there are four scenarios for naming measurements, prioritized as follows:

1. Manually configured measurement

    - In Pod/Service annotations, configure `prometheus.io/param_measurement` with the desired measurement name, for example:

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

    - For Prometheus PodMonitor/ServiceMonitor CRDs, you can specify `measurement` using `params`, for example:

      ```yaml
      params:
          measurement:
          - new-measurement
      ```

1. Derived from data segmentation

    - By default, the metric name is segmented by underscores `_`, with the first segment becoming the measurement name and the remaining segments forming the metric name.

      For example, the following Prometheus raw data:

      ```not-set
      # TYPE promhttp_metric_handler_errors_total counter
      promhttp_metric_handler_errors_total{cause="encoding"} 0
      ```

      Segmented by the first underscore, the left side `promhttp` is the measurement name, and the right side `metric_handler_errors_total` is the field name.

    - To ensure field names match the original Prom data, the container collector supports "retaining original prom field names". Enable this feature as follows:

        - Configuration file: `keep_exist_prometheus_metric_name = true`
        - Environment variable: `ENV_INPUT_CONTAINER_KEEP_EXIST_PROMETHEUS_METRIC_NAME = "true"`

      Using the `promhttp_metric_handler_errors_total` data as an example, enabling this feature sets the measurement to `promhttp`, while the field name remains unchanged as `promhttp_metric_handler_errors_total`.

Datakit adds additional tags to locate this resource within the Kubernetes cluster:

- For `Service`, it adds `namespace`, `service_name`, and `pod_name` tags.
- For `Pod`, it adds `namespace` and `pod_name` tags.

### Collecting Current Kubernetes Prometheus Data {#kube-self-metrtic}

This feature is experimental and may change in future releases.

Datakit supports simple configuration to collect Prometheus data from the Kubernetes cluster using the environment variable `ENV_INPUT_CONTAINER_ENABLE_K8S_SELF_METRIC_BY_PROM="true"`.

Data sources include APIServer, Controller, etc., with collection methods as follows:

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

- For Static Pods, Datakit first checks if such Pods exist on the current Node, for example, `kubectl get pod -n kube-system -l tier=control-plane,component=kube-scheduler --field-selector spec.nodeName=Node-01` to check if Scheduler service exists on Node-01. If it does, Datakit collects data using the default URL.

Collecting Etcd requires configuring certificates. Follow these steps:

1. Ask the Kubernetes administrator for the Etcd certificate storage path. For example:

```shell
$ ls /etc/kubernetes/pki/etcd
ca.crt  ca.key  healthcheck-client.crt  healthcheck-client.key  peer.crt  peer.key  server.crt  server.key
```

1. Create a Secret using the Etcd certificates with the following command:

```shell
$ kubectl create secret generic datakit-etcd-ssl --from-file=/etc/kubernetes/pki/etcd/ca.crt --from-file=/etc/kubernetes/pki/etcd/peer.crt --from-file=/etc/kubernetes/pki/etcd/peer.key -n datakit
secret/datakit-etcd-ssl created
```

1. Add the following configuration to the Datakit YAML:

```yaml
    spec:
      containers:
      - name: datakit
        env:
        - name: ENV_INPUT_CONTAINER_ENABLE_K8S_SELF_METRIC_BY_PROM    # Enable Kubernetes Prometheus data collection
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

The environment variable `ENV_INPUT_CONTAINER_K8S_SELF_METRIC_CONFIG` is a JSON configuration with the following format:

```json
{
    "etcd": {
        "ca_file":   "/tmp/etcd/ca.crt",
        "cert_file": "/tmp/etcd/peer.crt",
        "key_file":  "/tmp/etcd/peer.key"
    }
}
```

**Note that if Datakit is deployed on a cloud platform, it no longer supports collecting Kubernetes system services and Etcd components because cloud platforms typically hide these resources, making them unqueryable.**

## Further Reading {#more-readings}

- [Prometheus Exporter Data Collection](prom.md)
