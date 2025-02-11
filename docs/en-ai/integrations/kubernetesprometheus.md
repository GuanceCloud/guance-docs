---
title: 'Kubernetes Prometheus Discovery'
summary: 'Supports discovering and collecting Prometheus metrics exposed in Kubernetes'
tags:
  - 'PROMETHEUS'
  - 'KUBERNETES'
__int_icon: 'icon/kubernetes'
---

[:octicons-tag-24: Version-1.34.0](../datakit/changelog.md#cl-1.34.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

## Overview {#overview}

KubernetesPrometheus is a collector specifically designed for use within Kubernetes. It automatically discovers and collects data from Prometheus services based on custom configurations, greatly simplifying the usage process.

This collector requires some familiarity with Kubernetes, such as being able to view various properties of resources like Services and Pods using the `kubectl` command.

To better understand and use this collector, here’s an overview of its implementation steps:

1. Register event notification mechanisms with the Kubernetes APIServer to promptly receive updates about the creation, modification, and deletion of various resources.
1. When a resource (e.g., a Pod) is created, KubernetesPrometheus receives a notification and determines whether to collect data from that Pod based on the configuration file.
1. If the Pod meets the criteria, it locates the corresponding attributes (e.g., Port) according to the placeholders in the configuration file and constructs an access URL.
1. KubernetesPrometheus accesses this URL, parses the data, and adds labels.
1. If the Pod is updated or deleted, the KubernetesPrometheus collector stops collecting data from that Pod and decides whether to start new collections based on specific conditions.

### Configuration Description {#input-config-added}

- Below is a basic configuration with only two settings: selecting the target as Pod and specifying the target port. This configuration enables Prometheus data collection from all Pods, even if they do not export Prometheus data:

```yaml
[[inputs.kubernetesprometheus.instances]]
  role       = "pod"
  port       = "__kubernetes_pod_container_nginx_port_metrics_number"
```

- Expanding on the above configuration, instead of collecting data from all Pods, it now collects data from Pods specified by Namespace and Selector. As shown in the configuration, it only collects data from Pods in the `middleware` namespace that have the label `app=nginx`:

```yaml
[[inputs.kubernetesprometheus.instances]]
  role       = "pod"
  namespaces = ["middleware"]
  selector   = "app=nginx"

  port       = "__kubernetes_pod_container_nginx_port_metrics_number"
```

- Further expanding the configuration, additional tags are added. Tag values are dynamic, based on the properties of the target Pod. Here, four tags are added:

```yaml
[[inputs.kubernetesprometheus.instances]]
  role       = "pod"
  namespaces = ["middleware"]
  selector   = "app=nginx"

  port       = "__kubernetes_pod_container_nginx_port_metrics_number"

  [inputs.kubernetesprometheus.instances.custom]
    [inputs.kubernetesprometheus.instances.custom.tags]
      instance         = "__kubernetes_mate_instance"
      host             = "__kubernetes_mate_host"
      pod_name         = "__kubernetes_pod_name"
      pod_namespace    = "__kubernetes_pod_namespace"
```

- If the Prometheus service of the target Pod uses HTTPS, additional certificate authentication must be configured. These certificates are pre-mounted into the Datakit container:

```yaml
[[inputs.kubernetesprometheus.instances]]
  role       = "pod"
  namespaces = ["middleware"]
  selector   = "app=nginx"

  scheme     = "https"
  port       = "__kubernetes_pod_container_nginx_port_metrics_number"

  [inputs.kubernetesprometheus.instances.custom]
    [inputs.kubernetesprometheus.instances.custom.tags]
      instance         = "__kubernetes_mate_instance"
      host             = "__kubernetes_mate_host"
      pod_name         = "__kubernetes_pod_name"
      pod_namespace    = "__kubernetes_pod_namespace"

  [inputs.kubernetesprometheus.instances.auth]
    [inputs.kubernetesprometheus.instances.auth.tls_config]
      insecure_skip_verify = false
      ca_certs = ["/opt/nginx/ca.crt"]
      cert     = "/opt/nginx/peer.crt"
      cert_key = "/opt/nginx/peer.key"
```

- Finally, this is a complete configuration that includes all settings:

```yaml
[[inputs.kubernetesprometheus.instances]]
  role       = "pod"
  namespaces = ["middleware"]
  selector   = "app=nginx"

  scrape     = "true"
  scheme     = "https"
  port       = "__kubernetes_pod_container_nginx_port_metrics_number"
  path       = "/metrics"
  params     = ""

  [inputs.kubernetesprometheus.instances.custom]
    measurement        = "pod-nginx"
    job_as_measurement = false
    [inputs.kubernetesprometheus.instances.custom.tags]
      instance         = "__kubernetes_mate_instance"
      host             = "__kubernetes_mate_host"
      pod_name         = "__kubernetes_pod_name"
      pod_namespace    = "__kubernetes_pod_namespace"

  [inputs.kubernetesprometheus.instances.auth]
    bearer_token_file      = "/var/run/secrets/kubernetes.io/serviceaccount/token"
    [inputs.kubernetesprometheus.instances.auth.tls_config]
      insecure_skip_verify = false
      ca_certs = ["/opt/nginx/ca.crt"]
      cert     = "/opt/nginx/peer.crt"
      cert_key = "/opt/nginx/peer.key"
```

There is also a set of global configurations at the top level, primarily responsible for enabling or disabling certain features and adding tags to all instances:

```yaml
[inputs.kubernetesprometheus]
  node_local      = true   # Enable NodeLocal mode, distributing collection across nodes
  scrape_interval = "30s"  # Set the collection interval, default is 30 seconds

  enable_discovery_of_prometheus_pod_annotations     = false  # Enable predefined Pod Annotations configuration
  enable_discovery_of_prometheus_service_annotations = false  # Enable predefined Service Annotations configuration
  enable_discovery_of_prometheus_pod_monitors        = false  # Enable Prometheus PodMonitors CRD feature
  enable_discovery_of_prometheus_service_monitors    = false  # Enable Prometheus ServiceMonitors CRD feature

  [inputs.kubernetesprometheus.global_tags]
    instance = "__kubernetes_mate_instance"
    host     = "__kubernetes_mate_host"

  [[inputs.kubernetesprometheus.instances]]
  # ..other
```

`global_tags` add tags to all instances, supporting only `__kubernetes_mate_instance` and `__kubernetes_mate_host` placeholders. For placeholder functionality, refer to the subsequent sections.

<!-- markdownlint-disable MD046 -->
???+ attention

    IP addresses do not need to be manually configured; the collector uses the default IP, which is:

    - `node` uses InternalIP
    - `Pod` uses Pod IP
    - `Service` uses the Address IP of corresponding Endpoints (multiple)
    - `Endpoints` uses the Address IP of corresponding targets (multiple)

    Additionally, note that ports cannot be bound to loopback addresses, as external access would be impossible.
<!-- markdownlint-enable -->

Assuming the Pod IP is `172.16.10.10`, and the metrics port for the nginx container is 9090.

The final address created by the KubernetesPrometheus collector for Prometheus collection would be `http://172.16.10.10:9090/metrics`. After parsing the data, it adds the `pod_name` and `pod_namespace` labels, with the Mearsurement name being `pod-nginx`.

If another Pod also matches the namespace and selector configuration, it will also be collected.

## Configuration Details {#input-config}

The KubernetesPrometheus collector primarily uses placeholders for configuration, retaining only the most basic and necessary settings for collection (such as port, path, etc.). Now, let's explain each configuration item individually.

Using the configuration from the previous section as an example, here are the main configuration items:

### Main Configuration {#input-config-main}

| Configuration Item | Required | Default Value | Description                                                                                                                                                                                            | Placeholder Supported |
| ------------------ | -------- | ------------- | -----------                                                                                                                                                                                           | --------------------- |
| `role`            | Yes      | None          | Specifies the type of resource to collect from, can only be one of `node`, `pod`, `service`, or `endpoints`                                                                                          | No                    |
| `namespace`       | No       | None          | Limits the namespace of this resource. It's an array, allowing multiple entries, e.g., `["kube-system", "testing"]`                                                                                  | No                    |
| `selector`        | No       | None          | Label query and filtering, more precise. It's a string supporting `'=', '==', '!='`, e.g., `key1=value1,key2=value2`. Supports Glob matching patterns. See [later](kubernetesprometheus.md#selector-example) | No                    |
| `scrape`          | No       | "true"        | Determines whether to collect. When it's an empty string or `true`, it performs collection, otherwise, it does not                                                                                  | Yes                   |
| `scheme`          | No       | "http"        | Defaults to `http`. If certificates are needed, change to `https`                                                                                                                                   | Yes                   |
| `port`            | Yes      | None          | The port of the target address, needs manual configuration                                                                                                                                            | Yes                   |
| `path`            | No       | "/metrics"    | HTTP access path, defaults to `/metrics`                                                                                                                                                              | Yes                   |
| `params`          | No       | None          | HTTP access parameters, a string, e.g., `name=nginx&package=middleware`                                                                                                                              | No                    |

### Custom Configuration {#input-config-custom}

| Configuration Item               | Required | Default Value                             | Description                                                                          |
| -------------------------------- | -------- | ----------------------------------------- | ------------------------------------------------------------------------------------ |
| `measurement`                    | No       | The first part before the first underscore of the metric field name | Configures the Mearsurement name                                                     |
| `job_as_measurement`             | No       | false                                     | Whether to use the `job` label value in the data as the Mearsurement name            |
| `tags`                           | No       | None                                      | Adds tags. Note that tag keys do not support placeholders, but tag values do. See the placeholder description below |

<!-- markdownlint-disable MD046 -->
???+ attention

    The KubernetesPrometheus collector adds Datakit's `global_tags`[:octicons-tag-24: Version-1.65.1](../datakit/changelog.md#cl-1.65.1).
<!-- markdownlint-enable -->

### Permissions and Authentication {#input-config-auth}

- `bearer_token_file` configures the token file path, typically used with `insecure_skip_verify`
- `tls_config` configures certificate-related settings, including sub-settings `insecure_skip_verify`, `ca_certs`, `cert`, and `cert_key`. Note that `ca_certs` is an array configuration.

## Placeholders Explanation {#placeholders}

Placeholders are a crucial part of the entire collection scheme. They are strings pointing to specific properties of resources.

Placeholders are mainly divided into two categories: "fixed match" and "wildcard match":

- Fixed match, similar to `__kubernetes_pod_name`, is unique and points only to the Pod Name, simple and clear.
- Wildcard match, used to configure custom resource names, represented by `%s` in the text. For example, if a Pod has a label `app=nginx` and you want to extract `nginx` as a tag, configure it as follows:

```yaml
    [inputs.kubernetesprometheus.instances.custom.tags]
      app = "__kubernetes_pod_label_app"
```

Why is this step necessary?

Because the label value is not fixed and varies depending on the Pod. In one Pod, it might be `app=nginx`, while in another, it could be `app=redis`. To collect both Pods using the same configuration, you need to differentiate them using tags, hence this configuration method.

Placeholders are commonly used in selecting `annotation` and `label`, and also in configuring ports. For example, if a Pod has a container named nginx with a port called `metrics`, and you want to collect this port, you can write it as `__kubernetes_pod_container_nginx_port_metrics_number`.

Below are the global placeholders and placeholders supported by different types of resources (`node`, `pod`, `service`, `endpoints`).

### Global Placeholders {#placeholders-global}

Global placeholders are common to all roles and are often used to specify special tags.

<!-- markdownlint-disable MD049 -->
| Name                       | Description                                                           | Usage Scope                                                                              |
| -------------------------- | --------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| __kubernetes_mate_instance | The instance of the collection target, i.e., `IP:PORT`               | Only supported in `global_tags/custom.tags`, e.g., `instance = "__kubernetes_mate_instance"` |
| __kubernetes_mate_host     | The host of the collection target, i.e., `IP`. Not added if `localhost` or loopback address | Only supported in `global_tags/custom.tags`, e.g., `host = "__kubernetes_mate_host"`         |
<!-- markdownlint-enable -->

### Node Role {#placeholders-node}

These resources use InternalIP as the collection address, corresponding JSONPath is `.status.addresses[*].address ("type" is "InternalIP")`.

<!-- markdownlint-disable MD049 -->
| Name                                    | Description                          | Corresponding JSONPath                                       |
| --------------------------------------- | ------------------------------------ | ------------------------------------------------------------ |
| __kubernetes_node_name                  | Node name                            | .metadata.name                                               |
| __kubernetes_node_label_%s              | Node label                           | .metadata.labels['%s']                                       |
| __kubernetes_node_annotation_%s         | Node annotation                      | .metadata.annotations['%s']                                  |
| __kubernetes_node_address_Hostname      | Node hostname                        | .status.addresses[*].address ("type" is "Hostname")          |
| __kubernetes_node_kubelet_endpoint_port | Node kubelet port, usually 10250     | .status.daemonEndpoints.kubeletEndpoint.Port                 |
<!-- markdownlint-enable -->

### Pod Role {#placeholders-pod}

These resources use PodIP as the collection address, corresponding JSONPath is `.status.podIP`.

<!-- markdownlint-disable MD049 -->
| Name                                         | Description                                                                                                                | Corresponding JSONPath                                                |
| -------------------------------------------- | ----------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| __kubernetes_pod_name                        | Pod name                                                                                                                   | .metadata.name                                                    |
| __kubernetes_pod_namespace                   | Pod namespace                                                                                                              | .metadata.namespace                                                |
| __kubernetes_pod_label_%s                    | Pod label, e.g., `_kubernetes_pod_label_app`                                                                                | .metadata.labels['%s']                                             |
| __kubernetes_pod_annotation_%s               | Pod annotation, e.g., `_kubernetes_pod_annotation_prometheus.io/port`                                                      | .metadata.annotations['%s']                                        |
| __kubernetes_pod_node_name                   | Node to which the Pod belongs                                                                                               | .spec.nodeName                                                     |
| __kubernetes_pod_container_%s_port_%s_number | Specified port of the specified container, e.g., `__kubernetes_pod_container_nginx_port_metrics_number` points to the `metrics` port of the `nginx` container | .spec.containers[*].ports[*].containerPort ("name" equal "%s")     |
<!-- markdownlint-enable -->

For `__kubernetes_pod_container_%s_port_%s_number` examples:

Given a Pod named nginx with two containers, nginx and logfwd, and you want to collect port 8080 of the nginx container (assuming 8080 is named `metrics` in the configuration), you can configure it as:

`__kubernetes_pod_container_nginx_port_metrics_number` (note that `nginx` and `metrics` replace `%s`)

### Service Role {#placeholders-service}

Service resources do not have an IP attribute, so they use the Address IP of corresponding Endpoints (multiple). JSONPath is `.subsets[*].addresses[*].ip`.

<!-- markdownlint-disable MD049 -->
| Name                                      | Description                                                                         | Corresponding JSONPath                                         |
| ----------------------------------------- | ----------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| __kubernetes_service_name                 | Service name                                                                        | .metadata.name                                                 |
| __kubernetes_service_namespace            | Service namespace                                                                    | .metadata.namespace                                            |
| __kubernetes_service_label_%s             | Service label                                                                       | .metadata.labels['%s']                                         |
| __kubernetes_service_annotation_%s        | Service annotation                                                                  | .metadata.annotations['%s']                                    |
| __kubernetes_service_port_%s_port         | Specified port (rarely used, mostly uses targetPort)                                | .spec.ports[*].port ("name" equal "%s")                        |
| __kubernetes_service_port_%s_targetport   | Specified targetPort                                                                | .spec.ports[*].targetPort ("name" equal "%s")                  |
| __kubernetes_service_target_kind          | Service does not have a target, this points to the `kind` field of the targetRef of corresponding endpoints | Endpoints: .subsets[*].addresses[*].targetRef.kind             |
| __kubernetes_service_target_name          | Service does not have a target, this points to the `name` field of the targetRef of corresponding endpoints | Endpoints: .subsets[*].addresses[*].targetRef.name             |
| __kubernetes_service_target_namespace     | Service does not have a target, this points to the `namespace` field of the targetRef of corresponding endpoints | Endpoints: .subsets[*].addresses[*].targetRef.namespace        |
| __kubernetes_service_target_pod_name      | Deprecated, please use `__kubernetes_service_target_name`                            | Endpoints: .subsets[*].addresses[*].targetRef.name             |
| __kubernetes_service_target_pod_namespace | Deprecated, please use `__kubernetes_service_target_namespace`                       | Endpoints: .subsets[*].addresses[*].targetRef.namespace        |
<!-- markdownlint-enable -->

### Endpoints Role {#placeholders-endpoints}

These resources use Address IP (multiple), corresponding JSONPath is `.subsets[*].addresses[*].ip`.

<!-- markdownlint-disable MD049 -->
| Name                                                | Description                                                          | Corresponding JSONPath                               |
| --------------------------------------------------- | -------------------------------------------------------------------- | --------------------------------------------------- |
| __kubernetes_endpoints_name                         | Endpoints name                                                       | .metadata.name                                      |
| __kubernetes_endpoints_namespace                    | Endpoints namespace                                                  | .metadata.namespace                                 |
| __kubernetes_endpoints_label_%s                     | Endpoints label                                                      | .metadata.labels['%s']                              |
| __kubernetes_endpoints_annotation_%s                | Endpoints annotation                                                 | .metadata.annotations['%s']                         |
| __kubernetes_endpoints_address_node_name            | Node name of the Endpoints Address                                   | .subsets[*].addresses[*].nodeName                   |
| __kubernetes_endpoints_address_target_kind          | `kind` field of targetRef                                            | .subsets[*].addresses[*].targetRef.kind             |
| __kubernetes_endpoints_address_target_name          | `name` field of targetRef                                            | .subsets[*].addresses[*].targetRef.name             |
| __kubernetes_endpoints_address_target_namespace     | `namespace` field of targetRef                                       | .subsets[*].addresses[*].targetRef.namespace        |
| __kubernetes_endpoints_address_target_pod_name      | Deprecated, please use `__kubernetes_endpoints_address_target_name`  | .subsets[*].addresses[*].targetRef.name             |
| __kubernetes_endpoints_address_target_pod_namespace | Deprecated, please use `__kubernetes_endpoints_address_target_namespace` | .subsets[*].addresses[*].targetRef.namespace        |
| __kubernetes_endpoints_port_%s_number               | Specified port name, e.g., `__kubernetes_endpoints_port_metrics_number` | .subsets[*].ports[*].port ("name" equal "%s")       |
<!-- markdownlint-enable -->

## Practical Examples {#example}

The following example creates a Service and Deployment, using KubernetesPrometheus to collect data from the corresponding Pod. Steps are as follows:

1. Create Service and Deployment

```yaml
apiVersion: v1
kind: Service
metadata:
  name: prom-svc
  namespace: testing
  labels:
    app.kubernetes.io/name: prom
spec:
  selector:
    app.kubernetes.io/name: prom
  ports:
  - name: metrics
    protocol: TCP
    port: 8080
    targetPort: 30001
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prom-server
  namespace: testing
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: prom
  replicas: 1
  template:
    metadata:
      labels:
        app.kubernetes.io/name: prom
    spec:
      containers:
      - name: prom-server
        image: pubrepo.guance.com/datakit-dev/prom-server:v2
        imagePullPolicy: IfNotPresent
        env:
        - name: ENV_PORT
          value: "30001"
        - name: ENV_NAME
          value: "promhttp"
        ports:
        - name: metrics
          containerPort: 30001
```

1. Create ConfigMap and KubernetesPrometheus configuration

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    kubernetesprometheus.conf: |-
      [inputs.kubernetesprometheus]
        [[inputs.kubernetesprometheus.instances]]
          role       = "service"
          namespaces = ["testing"]
          selector   = "app.kubernetes.io/name=prom"

          scrape     = "true"
          scheme     = "http"
          port       = "__kubernetes_service_port_metrics_targetport"
          path       = "/metrics"
          params     = ""

          [inputs.kubernetesprometheus.instances.custom]
            measurement        = "prom-svc"
            job_as_measurement = false
            [inputs.kubernetesprometheus.instances.custom.tags]
              svc_name      = "__kubernetes_service_name"
              pod_name      = "__kubernetes_service_target_name"
              pod_namespace = "__kubernetes_service_target_namespace"
```

1. Apply the `kubernetesprometheus.conf` file in the Datakit YAML

```yaml
        # ..other..
        volumeMounts:
        - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
          name: datakit-conf
          subPath: kubernetesprometheus.conf
          readOnly: true
```

1. Finally, start Datakit. You should see content like `create prom url xxxxx for testing/prom-svc` in the logs, and the `prom-svc` Mearsurement should appear on the Guance page.


---

## FAQ {#faq}

### Selector Description and Examples {#selector-example}

`selector` is a commonly used parameter in the `kubectl` command. For example, to find Pods with labels `tier=control-plane` and `component=kube-controller-manager`, you can use the following command:

```shell
$ kubectl get pod -n kube-system  --selector tier=control-plane,component=kube-controller-manager
NAMESPACE     NAME                      READY   STATUS    RESTARTS   AGE
kube-system   kube-controller-manager   1/1     Running   0          15d
```

The `--selector` parameter works similarly to the `selector` configuration item. For more usage methods of `selector`, refer to the [official documentation](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/labels/){:target="_blank"}.

Additionally, Datakit extends the functionality of `selector` to support **Glob matching patterns**. For detailed Glob syntax, refer to the [Glob pattern documentation](https://developers.tetrascience.com/docs/common-glob-pattern#glob-pattern-syntax). Here are some examples:

[:octicons-tag-24: Version-1.65.1](../datakit/changelog.md#cl-1.65.1)

- **`selector="app=middleware*"`**: Matches any value starting with `middleware`, such as `middleware-etcd` or `middleware-coredns`.
- **`selector="app=middleware-{nginx,redis}"`**: Matches `middleware-nginx` and `middleware-redis`, equivalent to `app in (middleware-nginx, middleware-redis)`.
- **`selector="app=middleware-[123]"`**: Matches `middleware-1`, `middleware-2`, and `middleware-3`.

<!-- markdownlint-disable MD046 -->
???+ attention
    The `!` exclusion operator is not supported in Glob patterns here. For example, `app=middleware-[!0123]` will cause an error during parsing. This is because `!` is a reserved character in Selector syntax (e.g., used in `app!=nginx`) and thus cannot be used in Glob patterns.
<!-- markdownlint-enable -->