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

KubernetesPrometheus is a collector specifically designed for use within Kubernetes environments. It automatically discovers Prometheus services based on custom configurations and collects metrics, greatly simplifying the usage process.

This collector requires a certain level of familiarity with Kubernetes, such as being able to view various properties of resources like Services and Pods using the `kubectl` command.

A brief explanation of how this collector works can help better understand and utilize it. The implementation of KubernetesPrometheus mainly involves the following steps:

1. Register an event notification mechanism with the Kubernetes APIServer to promptly obtain information about the creation, update, and deletion of various resources.
2. When a resource (e.g., Pod) is created, KubernetesPrometheus receives a notification and decides whether to collect data from that Pod based on the configuration file.
3. If the Pod meets the criteria, it finds the corresponding attributes of the Pod (e.g., Port) according to the placeholders in the configuration file, constructs an access address, and accesses that address.
4. KubernetesPrometheus visits the address, parses the data, and adds tags.
5. If the Pod undergoes updates or deletions, the KubernetesPrometheus collector stops collecting data from that Pod and determines whether to start new collections based on specific conditions.

### Configuration Explanation {#input-config-added}

- Below is the most basic configuration, which has only two configuration items—selecting the target for self-discovery as Pod and specifying the target Port. This configuration achieves the collection of Prometheus data from all Pods, even if they do not export Prometheus data:

```yaml
[[inputs.kubernetesprometheus.instances]]
  role       = "pod"
  port       = "__kubernetes_pod_container_nginx_port_metrics_number"
```

- Expanding on the above configuration, instead of collecting data from all Pods, it now collects data from Pods specified by Namespace and Selector. As shown in the configuration, it now only collects data from Pods in the `middleware` namespace with the label `app=nginx`:

```yaml
[[inputs.kubernetesprometheus.instances]]
  role       = "pod"
  namespaces = ["middleware"]
  selector   = "app=nginx"

  port       = "__kubernetes_pod_container_nginx_port_metrics_number"
```

- Further expanding the configuration, some labels are added. The label values are dynamic, derived from the properties of the target Pod. Here, four labels are added:

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

- If the Prometheus service of the target Pod uses the HTTPS protocol, additional certificate configurations are required. These certificates have been pre-mounted into the Datakit container:

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

- Finally, this is a complete configuration that includes all configuration items:

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

Additionally, there is a global configuration, which is the top-level configuration primarily responsible for enabling or disabling certain features and adding tags to all instances:

```yaml
[inputs.kubernetesprometheus]
  node_local      = true   # Enable NodeLocal mode, distributing collection across nodes
  scrape_interval = "30s"  # Specify the collection interval, default is 30 seconds

  enable_discovery_of_prometheus_pod_annotations     = false  # Enable predefined Pod Annotations configuration
  enable_discovery_of_prometheus_service_annotations = false  # Enable predefined Service Annotations configuration
  enable_discovery_of_prometheus_pod_monitors        = false  # Enable Prometheus PodMonitors CRD functionality
  enable_discovery_of_prometheus_service_monitors    = false  # Enable Prometheus ServiceMonitors CRD functionality

  [inputs.kubernetesprometheus.global_tags]
    instance = "__kubernetes_mate_instance"
    host     = "__kubernetes_mate_host"
 
  [[inputs.kubernetesprometheus.instances]]
  # ..other
```

`global_tags` add tags to all instances, supporting only `__kubernetes_mate_instance` and `__kubernetes_mate_host` placeholders. Placeholder functionality is explained later.

<!-- markdownlint-disable MD046 -->
???+ attention

    There is no need to manually configure IP addresses; the collector will use the default IP addresses, specifically:

    - `node` uses InternalIP
    - `Pod` uses Pod IP
    - `Service` uses the Address IPs of the corresponding Endpoints (multiple)
    - `Endpoints` uses the Address IPs (multiple)

    Additionally, note that ports cannot be bound to loopback addresses, as external access would be impossible.
<!-- markdownlint-enable -->

Assuming this Pod IP is `172.16.10.10`, and the nginx container's metrics port is 9090.

The final KubernetesPrometheus collector will create a target address `http://172.16.10.10:9090/metrics` for Prometheus collection, parse the data, and add the tags `pod_name` and `pod_namespace`. The measurement name is `pod-nginx`.

If another Pod also matches the namespace and selector configuration, it will also be collected.

## Detailed Configuration {#input-config}

The KubernetesPrometheus collector mainly uses placeholders for configuration, retaining only the essential configurations necessary for collection (such as port, path, etc.). Now, let's explain each configuration item individually.

Using the previous configuration as an example, the following sections describe the meaning of each configuration item.

### Main Configuration {#input-config-main}

| Configuration Item | Required | Default Value | Description                                                                                                                                                                                            | Placeholder Support |
| ----------- | ----------- | -----      | -----------                                                                                                                                                                                     | -----          |
| `role`      | Yes         | None       | Specifies the type of resource to collect, can only be one of `node`, `pod`, `service`, or `endpoints`                                                                                                                     | No             |
| `namespace` | No          | None       | Limits the namespace to which this resource belongs. It is an array and can contain multiple entries, e.g., `["kube-system", "testing"]`                                                                                                           | No             |
| `selector`  | No          | None       | Label query and filtering, with a smaller and more precise scope. It is a string that supports `'=', '==', '!='`, e.g., `key1=value1,key2=value2`. It also supports Glob matching patterns. See [later section](kubernetesprometheus.md#selector-example) | No             |
| `scrape`    | No          | "true"     | Determines whether to collect. When it is an empty string or `true`, it performs collection; otherwise, it does not collect                                                                                                                            | Yes            |
| `scheme`    | No          | "http"     | Default value is `http`. If certification is required, change it to `https`                                                                                                                                           | Yes            |
| `port`      | Yes         | None       | Target address port, needs manual configuration                                                                                                                                                                    | Yes            |
| `path`      | No          | "/metrics" | HTTP access path, default value is `/metrics`                                                                                                                                                              | Yes            |
| `params`    | No          | None       | HTTP access parameters, a string, e.g., `name=nginx&package=middleware`                                                                                                                               | No             |

### Adding HTTP Headers {#input-config-http-headers}

Supports configuring multiple Key/Value pairs to add them to HTTP requests. For example:

```yaml
  [inputs.kubernetesprometheus.instances]
    # other..
    [inputs.kubernetesprometheus.instances.http_headers]
      "Authorization" = "Bearer XXXXX"
      "X-testing-key" = "value"
```

### Custom Configuration {#input-config-custom}

| Configuration Item               | Required    | Default Value                             | Description                                                                          |
| -----------                      | ----------- | -----                                     | -----------                                                                   |
| `measurement`                    | No          | First part before the first underscore in the metric field name | Configures the measurement name                                                                |
| `job_as_measurement`             | No          | false                                     | Whether to use the `job` label value from the data as the measurement name                                   |
| `tags`                           | No          | None                                      | Adds tags, note that tag keys do not support placeholders, but values do, see the placeholder description below |

<!-- markdownlint-disable MD046 -->
???+ attention

    The KubernetesPrometheus collector adds Datakit’s `global_tags`[:octicons-tag-24: Version-1.65.1](../datakit/changelog.md#cl-1.65.1).
<!-- markdownlint-enable -->

### Permissions and Authentication {#input-config-auth}

- `bearer_token_file` configures the token file path, typically used with `insecure_skip_verify`
- `tls_config` configures certificate-related settings, with sub-items including `insecure_skip_verify`, `ca_certs`, `cert`, and `cert_key`. Note that `ca_certs` is an array configuration.

## Placeholders Explanation {#placeholders}

Placeholders are a crucial part of the entire collection scheme. They are strings pointing to a property of a resource.

There are two main types of placeholders: "fixed match" and "wildcard match":

- Fixed match, similar to `__kubernetes_pod_name`, it uniquely points to the Pod Name, simple and clear.
- Wildcard match, used to configure custom resource names, represented by `%s` in the text. For example, if a Pod has a label `app=nginx` and you need to extract `nginx` as a tag, configure it as follows:

```yaml
    [inputs.kubernetesprometheus.instances.custom.tags]
      app = "__kubernetes_pod_label_app"
```

Why is this step necessary?

Because the label value is not fixed and varies depending on the Pod. In one Pod it might be `app=nginx`, and in another Pod it could be `app=redis`. To use the same configuration to collect both Pods, it is necessary to distinguish between their labels using this configuration method.

Placeholders are primarily used in selecting `annotation` and `label`, and also in configuring ports. For example, if a Pod has a container named nginx with a port called `metrics`, to collect this port, you can write it as `__kubernetes_pod_container_nginx_port_metrics_number`.

Below are the global placeholders and placeholders supported by different resource types (`node`, `pod`, `service`, `endpoints`).

### Global Placeholders {#placeholders-global}

Global placeholders apply to all roles and are mostly used to specify special tags.

<!-- markdownlint-disable MD049 -->
| Name                       | Description                                                           | Usage Scope                                                                              |
| -----------                | -----------                                                           | -----                                                                                 |
| __kubernetes_mate_instance | Instance of the collection target, i.e., `IP:PORT`                                     | Only supported in `global_tags/custom.tags`, e.g., `instance = "__kubernetes_mate_instance"` |
| __kubernetes_mate_host     | Host of the collection target, i.e., `IP`. If the value is `localhost` or a loopback address, it will not be added | Only supported in `global_tags/custom.tags`, e.g., `host = "__kubernetes_mate_host"`         |
<!-- markdownlint-enable -->

### Node Role {#placeholders-node}

These resources use the InternalIP for the collection address, corresponding JSONPath is `.status.addresses[*].address ("type" is "InternalIP")`.

<!-- markdownlint-disable MD049 -->
| Name                                    | Description                          | Corresponding JSONPath                                       |
| -----------                             | -----------                          | -----                                                 |
| __kubernetes_node_name                  | Node name                            | .metadata.name                                        |
| __kubernetes_node_label_%s              | Node label                            | .metadata.labels['%s']                                |
| __kubernetes_node_annotation_%s         | Node annotation                            | .metadata.annotations['%s']                           |
| __kubernetes_node_address_Hostname      | Node hostname                          | .status.addresses[*].address ("type" is "Hostname")   |
| __kubernetes_node_kubelet_endpoint_port | Node's kubelet port, usually 10250 | .status.daemonEndpoints.kubeletEndpoint.Port          |
<!-- markdownlint-enable -->

### Pod Role {#placeholders-pod}

These resources use PodIP for the collection address, corresponding JSONPath is `.status.podIP`.

<!-- markdownlint-disable MD049 -->
| Name                                         | Description                                                                                                                | Corresponding JSONPath                                                |
| -----------                                  | -----------                                                                                                                | -----                                                          |
| __kubernetes_pod_name                        | Pod name                                                                                                                   | .metadata.name                                                 |
| __kubernetes_pod_namespace                   | Pod namespace                                                                                                               | .metadata.namespace                                            |
| __kubernetes_pod_label_%s                    | Pod label, e.g., `_kubernetes_pod_label_app`                                                                                 | .metadata.labels['%s']                                         |
| __kubernetes_pod_annotation_%s               | Pod annotation, e.g., `_kubernetes_pod_annotation_prometheus.io/port`                                                             | .metadata.annotations['%s']                                    |
| __kubernetes_pod_node_name                   | Node to which the Pod belongs                                                                                                            | .spec.nodeName                                                 |
| __kubernetes_pod_container_%s_port_%s_number | Specified port of a specified container, e.g., `__kubernetes_pod_container_nginx_port_metrics_number` points to the `metrics` port of the `nginx` container | .spec.containers[*].ports[*].containerPort ("name" equal "%s") |
<!-- markdownlint-enable -->

For `__kubernetes_pod_container_%s_port_%s_number` example:

Consider a Pod named nginx with two containers, nginx and logfwd. To collect data from the nginx container's port 8080 (assuming 8080 is named `metrics` in the configuration), you can configure it as:

`__kubernetes_pod_container_nginx_port_metrics_number` (replace %s with nginx and metrics)

### Service Role {#placeholders-service}

Service resources do not have an IP attribute, so they use the Address IP of the corresponding Endpoints (which may be multiple). The JSONPath is `.subsets[*].addresses[*].ip` of Endpoints.

<!-- markdownlint-disable MD049 -->
| Name                                      | Description                                                                         | Corresponding JSONPath                                         |
| -----------                               | -----------                                                                         | -----                                                   |
| __kubernetes_service_name                 | Service name                                                                        | .metadata.name                                          |
| __kubernetes_service_namespace            | Service namespace                                                                    | .metadata.namespace                                     |
| __kubernetes_service_label_%s             | Service label                                                                        | .metadata.labels['%s']                                  |
| __kubernetes_service_annotation_%s        | Service annotation                                                                        | .metadata.annotations['%s']                             |
| __kubernetes_service_port_%s_port         | Specified port (rarely used, mostly use targetPort)                                | .spec.ports[*].port ("name" equal "%s")                 |
| __kubernetes_service_port_%s_targetport   | Specified targetPort                                                                     | .spec.ports[*].targetPort ("name" equal "%s")           |
| __kubernetes_service_target_kind          | Service does not have a target, this refers to the `kind` field of the corresponding endpoints' targetRef      | Endpoints: .subsets[*].addresses[*].targetRef.kind      |
| __kubernetes_service_target_name          | Service does not have a target, this refers to the `name` field of the corresponding endpoints' targetRef      | Endpoints: .subsets[*].addresses[*].targetRef.name      |
| __kubernetes_service_target_namespace     | Service does not have a target, this refers to the `namespace` field of the corresponding endpoints' targetRef | Endpoints: .subsets[*].addresses[*].targetRef.namespace |
| __kubernetes_service_target_pod_name      | Deprecated, please use `__kubernetes_service_target_name`                               | Endpoints: .subsets[*].addresses[*].targetRef.name      |
| __kubernetes_service_target_pod_namespace | Deprecated, please use `__kubernetes_service_target_namespace`                          | Endpoints: .subsets[*].addresses[*].targetRef.namespace |
<!-- markdownlint-enable -->

### Endpoints Role {#placeholders-endpoints}

These resources use Address IP (multiple) for the collection address, corresponding JSONPath is `.subsets[*].addresses[*].ip`.

<!-- markdownlint-disable MD049 -->
| Name                                                | Description                                                          | Corresponding JSONPath                               |
| -----------                                         | -----------                                                          | -----                                         |
| __kubernetes_endpoints_name                         | Endpoints name                                                       | .metadata.name                                |
| __kubernetes_endpoints_namespace                    | Endpoints namespace                                                   | .metadata.namespace                           |
| __kubernetes_endpoints_label_%s                     | Endpoints label                                                       | .metadata.labels['%s']                        |
| __kubernetes_endpoints_annotation_%s                | Endpoints annotation                                                       | .metadata.annotations['%s']                   |
| __kubernetes_endpoints_address_node_name            | Node name of the Endpoints Address                                       | .subsets[*].addresses[*].nodeName             |
| __kubernetes_endpoints_address_target_kind          | `kind` field of the targetRef                                             | .subsets[*].addresses[*].targetRef.kind       |
| __kubernetes_endpoints_address_target_name          | `name` field of the targetRef                                             | .subsets[*].addresses[*].targetRef.name       |
| __kubernetes_endpoints_address_target_namespace     | `namespace` field of the targetRef                                        | .subsets[*].addresses[*].targetRef.namespace  |
| __kubernetes_endpoints_address_target_pod_name      | Deprecated, please use `__kubernetes_endpoints_address_target_name`      | .subsets[*].addresses[*].targetRef.name       |
| __kubernetes_endpoints_address_target_pod_namespace | Deprecated, please use `__kubernetes_endpoints_address_target_namespace` | .subsets[*].addresses[*].targetRef.namespace  |
| __kubernetes_endpoints_port_%s_number               | Specified port name, e.g., `__kubernetes_endpoints_port_metrics_number`    | .subsets[*].ports[*].port ("name" equal "%s") |
<!-- markdownlint-enable -->

## Practical Example {#example}

The following example creates a Service and Deployment and uses KubernetesPrometheus to collect data from the corresponding Pod. Steps are as follows:

<!-- markdownlint-disable MD029 -->

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

2. Create ConfigMap and KubernetesPrometheus configuration

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

3. Apply the `kubernetesprometheus.conf` file in the Datakit YAML

```yaml
        # ..other..
        volumeMounts:
        - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
          name: datakit-conf
          subPath: kubernetesprometheus.conf
          readOnly: true
```

4. Finally, start Datakit. You should see `create prom url xxxxx for testing/prom-svc` in the logs and view the `prom-svc` measurement on the Guance page.


---

## FAQ {#faq}

### Selector Description and Examples {#selector-example}

`selector` is a commonly used parameter in the `kubectl` command. For example, to find Pods whose labels (Labels) include `tier=control-plane` and `component=kube-controller-manager`, you can use the following command:

```shell
$ kubectl get pod -n kube-system  --selector tier=control-plane,component=kube-controller-manager
NAMESPACE     NAME                      READY   STATUS    RESTARTS   AGE
kube-system   kube-controller-manager   1/1     Running   0          15d
```

The `--selector` parameter functions similarly to the `selector` configuration item. For more usage methods of `selector`, refer to the [official documentation](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/labels/){:target="_blank"}.

Additionally, Datakit extends the functionality of `selector` to support **Glob matching patterns**. For detailed Glob syntax, refer to the [Glob pattern documentation](https://developers.tetrascience.com/docs/common-glob-pattern#glob-pattern-syntax). Below are some examples:

[:octicons-tag-24: Version-1.65.1](../datakit/changelog.md#cl-1.65.1)

- **`selector="app=middleware*"`**: Matches any value starting with `middleware`, such as `middleware-etcd` or `middleware-coredns`.
- **`selector="app=middleware-{nginx,redis}"`**: Matches `middleware-nginx` and `middleware-redis`, equivalent to `app in (middleware-nginx, middleware-redis)`.
- **`selector="app=middleware-[123]"`**: Matches `middleware-1`, `middleware-2`, and `middleware-3`.

<!-- markdownlint-disable MD046 -->
???+ attention
    The `!` exclusion character is not supported in Glob patterns here. For example, `app=middleware-[!0123]` will cause a parsing error. This is because in Selector syntax, `!` is a critical character (e.g., used in `app!=nginx`) and thus cannot be used in Glob patterns.
<!-- markdownlint-enable -->

### Bearer Token Authentication {#http-bearer-token}

In most cases, using Bearer Token authentication requires two prerequisites: enabling `https` and setting `insecure_skip_verify` to `true`.

Bearer Token configuration has two methods:

- If the Token is a string, it can be manually entered in `http_headers`, for example:

```yaml
    [inputs.kubernetesprometheus.instances.http_headers]
      "Authorization" = "Bearer XXXXX"
```

- If the Token is stored in a file, specify the file path in `bearer_token_file`. The KubernetesPrometheus collector will automatically read the file content and add it to the `Authorization` header. Note that if `http_headers` contains `Authorization`, `bearer_token_file` will be ignored.

```yaml
    [inputs.kubernetesprometheus.instances.auth]
      bearer_token_file = "/var/run/secrets/kubernetes.io/serviceaccount/token"
```
