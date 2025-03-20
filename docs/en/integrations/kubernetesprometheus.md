---
title     : 'Kubernetes Prometheus Discovery'
summary   : 'Supports discovering and collecting exposed Prometheus Metrics in Kubernetes'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
__int_icon: 'icon/kubernetes'
---

[:octicons-tag-24: Version-1.34.0](../datakit/changelog.md#cl-1.34.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

## Overview {#overview}

KubernetesPrometheus is a collector that can only be applied in Kubernetes environments. It automatically discovers Prometheus services based on custom configurations and collects data, greatly simplifying the usage process.

This collector requires a certain level of familiarity with Kubernetes, such as being able to use the kubectl command to view various attributes of resources like Services and Pods.

A brief description of how this collector works will help you better understand and use it. The implementation of KubernetesPrometheus mainly involves the following steps:

1. Register an event notification mechanism with the Kubernetes APIServer to promptly know about the creation, updates, and deletions of various resources.
1. When a resource (e.g., Pod) is created, KubernetesPrometheus receives a notification and decides whether to collect data from that Pod based on the configuration file.
1. If the Pod meets the criteria, it finds the corresponding properties of the Pod (e.g., Port) according to the placeholders in the configuration file and builds an access address.
1. KubernetesPrometheus accesses this address, parses the data, and adds tags.
1. If the Pod undergoes updates or deletion, the KubernetesPrometheus collector stops collecting data from that Pod and determines whether to start a new collection based on specific circumstances.


### Configuration Description {#input-config-added}

- Below is the most basic configuration; it has only two configuration items—selecting self-discovery targets as Pods and specifying the target Port. It implements Prometheus data collection for all Pods, even if they do not export Prometheus data:

```yaml
[[inputs.kubernetesprometheus.instances]]
  role       = "pod"
  port       = "__kubernetes_pod_container_nginx_port_metrics_number"
```

- Expand on the above configuration by no longer collecting data from all Pods but instead targeting a specific type of Pod using Namespace and Selector. As shown in the configuration, now only Pods in the Namespace `middleware` with the Label `app=nginx` are collected:

```yaml
[[inputs.kubernetesprometheus.instances]]
  role       = "pod"
  namespaces = ["middleware"]
  selector   = "app=nginx"

  port       = "__kubernetes_pod_container_nginx_port_metrics_number"
```

- Further expand the configuration by adding some tags. Tag values are dynamic and taken based on the properties of the target Pod. Here, four tags are added:

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

- If the Prometheus service of the target Pod uses the https protocol, additional certificate authentication needs to be configured, and these certificates have been mounted into the Datakit container beforehand:

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

There is also a class of global configurations, which are top-level configurations primarily responsible for enabling or disabling certain features and adding tags to all instances:

```yaml
[inputs.kubernetesprometheus]
  node_local      = true   # Enable NodeLocal mode, distributing collection across nodes
  scrape_interval = "30s"  # Specify collection interval, default is 30 seconds

  enable_discovery_of_prometheus_pod_annotations     = false  # Enable predefined Pod Annotations configuration
  enable_discovery_of_prometheus_service_annotations = false  # Enable predefined Service Annotations configuration
  enable_discovery_of_prometheus_pod_monitors        = false  # Enable Prometheus PodMonitors CRD function
  enable_discovery_of_prometheus_service_monitors    = false  # Enable Prometheus ServiceMonitors CRD function

  [inputs.kubernetesprometheus.global_tags]
    instance = "__kubernetes_mate_instance"
    host     = "__kubernetes_mate_host"
 
  [[inputs.kubernetesprometheus.instances]]
  # ..other
```

`global_tags` adds tags to all instances, supporting only `__kubernetes_mate_instance` and `__kubernetes_mate_host` placeholders. For placeholder functionality, please refer to the subsequent sections.

<!-- markdownlint-disable MD046 -->
???+ attention

    There is no need to manually configure IP addresses; the collector will use the default IP address, specifically:

    - `node` uses InternalIP
    - `Pod` uses Pod IP
    - `Service` uses the Address IP of corresponding Endpoints (multiple)
    - `Endpoints` uses the corresponding Address IP (multiple)

    Additionally, note that ports cannot be bound to loopback addresses, otherwise external access will not be possible.
<!-- markdownlint-enable -->

Assume this Pod IP is `172.16.10.10`, and the metrics port for the nginx container is 9090.

The final KubernetesPrometheus collector will create a target address `http://172.16.10.10:9090/metrics` for Prometheus collection, parse the data, and add the tags `pod_name` and `pod_namespace`. The Measurement name is `pod-nginx`.

If another Pod also matches the namespace and selector configuration, it will also be collected.

## Detailed Configuration {#input-config}

The KubernetesPrometheus collector mainly uses placeholders for configuration, retaining only the most basic necessary configurations for collection (such as port, path, etc.). Now we will explain each configuration item individually.

Using the configuration from the previous section as an example:

### Main Configuration {#input-config-main}

| Configuration Item | Required? | Default Value | Description                                                                                                                                                                                            | Placeholder Supported? |
| ----------- | ----------- | -----      | -----------                                                                                                                                                                                     | -----          |
| `role`      | Yes         | None       | Specifies the type of resource to collect, can only be one of `node`, `pod`, `service`, or `endpoints`                                                                                                                     | No             |
| `namespace` | No          | None       | Limits the namespace of this resource, it's an array and multiple entries can be specified, e.g., `["kube-system", "testing"]`                                                                                                           | No             |
| `selector`  | No          | None       | Labels query and filtering, its scope is smaller and more precise. It is a string that supports `'=', '==', '!='`, e.g., `key1=value1,key2=value2`, and it also supports Glob matching patterns. See [here](kubernetesprometheus.md#selector-example) | No             |
| `scrape`    | No          | "true"     | Determines whether to collect data. When it is an empty string or `true`, collection will occur, otherwise it won't.                                                                                                                            | Yes            |
| `scheme`    | No          | "http"     | Default value is `http`, if collection requires certificates, change it to `https`                                                                                                                                           | Yes            |
| `port`      | Yes         | None       | Target address port, manual configuration required                                                                                                                                                                    | Yes            |
| `path`      | No          | "/metrics" | HTTP access path, default value is `/metrics`                                                                                                                                                              | Yes            |
| `params`    | No          | None       | HTTP access parameters, it is a string, e.g., `name=nginx&package=middleware`                                                                                                                               | No             |

### Adding HTTP Headers {#input-config-http-headers}

Supports configuring multiple Key/Value pairs to add them in HTTP requests. Example:

```yaml
  [inputs.kubernetesprometheus.instances]
    # other..
    [inputs.kubernetesprometheus.instances.http_headers]
      "Authorization" = "Bearer XXXXX"
      "X-testing-key" = "value"
```

### Customized Configuration {#input-config-custom}

| Configuration Item               | Required?    | Default Value                             | Description                                                                          |
| -----------          | ----------- | -----                              | -----------                                                                   |
| `measurement`        | No          | First part of the metric field name after splitting at the first underscore | Configures the Measurement name                                                                |
| `job_as_measurement` | No          | false                              | Whether to use the `job` tag value in the data as the Measurement name                                   |
| `tags`               | No          | None                                 | Adds tags, note that tag keys do not support placeholders, but tag values do, see the placeholder description below |

<!-- markdownlint-disable MD046 -->
???+ attention

    The KubernetesPrometheus collector adds Datakit's `global_tags`[:octicons-tag-24: Version-1.65.1](../datakit/changelog.md#cl-1.65.1).
<!-- markdownlint-enable -->

### Permissions and Authentication {#input-config-auth}

- `bearer_token_file` configures the token file path, usually used together with `insecure_skip_verify`
- `tls_config` configures certificate-related settings, sub-items include `insecure_skip_verify`, `ca_certs`, `cert`, `cert_key`, note that `ca_certs` is an array configuration

## Placeholders Explanation {#placeholders}

Placeholders are a very important part of the entire collection scheme. They themselves are strings pointing to a particular attribute of a resource.

Placeholders mainly fall into two categories: "fixed match" and "wildcard match":

- Fixed match, similar to `__kubernetes_pod_name`, it is unique and points solely to the Pod Name, simple and clear
- Wildcard match, used to configure some custom resource names, `%s` is used as a substitute in the text. For example, if Pod has a Label `app=nginx`, and you want to extract `nginx` as a tag, you would configure it like this:

```yaml
    [inputs.kubernetesprometheus.instances.custom.tags]
      app = "__kubernetes_pod_label_app"
```

Why is this step necessary?

Because the value of this label is not fixed and varies depending on the Pod. In this Pod, it might be `app=nginx`, in another Pod it could be `app=redis`. If you want to use the same configuration to collect data from both Pods, it is necessary to distinguish between their labels, hence this configuration method.

Placeholders are mainly used in selecting `annotations` and `labels`, and also when configuring ports. For example, if a Pod has a container named nginx, and that container has a port called `metrics`, and you want to collect data from this port, you can write it as `__kubernetes_pod_container_nginx_port_metrics_number`.

Below are the global placeholders and placeholders supported by various resources (`node`, `pod`, `service`, `endpoints`).

### Global Placeholders {#placeholders-global}

Global placeholders are common to all Roles and are mostly used to specify special tags.

<!-- markdownlint-disable MD049 -->
| Name                       | Description                                                           | Usage Scope                                                                              |
| -----------                | -----------                                                           | -----                                                                                 |
| __kubernetes_mate_instance | Instance of the collection target, i.e., `IP:PORT`                                     | Only supported in global_tags/custom.tags usage, e.g., `instance = "__kubernetes_mate_instance"` |
| __kubernetes_mate_host     | Host of the collection target, i.e., `IP`. If the value is `localhost` or a loopback address, it will not be added | Only supported in global_tags/custom.tags usage, e.g., `host = "__kubernetes_mate_host"`         |
<!-- markdownlint-enable -->

### Node Role {#placeholders-node}

The collection address for this type of resource is InternalIP, corresponding JSONPath is `.status.addresses[*].address ("type" is "InternalIP")`.

<!-- markdownlint-disable MD049 -->
| Name                                    | Description                          | Corresponding JSONPath                                       |
| -----------                             | -----------                          | -----                                                 |
| __kubernetes_node_name                  | Node name                            | .metadata.name                                        |
| __kubernetes_node_label_%s              | Node labels                            | .metadata.labels['%s']                                |
| __kubernetes_node_annotation_%s         | Node annotations                            | .metadata.annotations['%s']                           |
| __kubernetes_node_address_Hostname      | Node hostname                          | .status.addresses[*].address ("type" is "Hostname")   |
| __kubernetes_node_kubelet_endpoint_port | Node kubelet port, generally 10250 | .status.daemonEndpoints.kubeletEndpoint.Port          |
<!-- markdownlint-enable -->

### Pod Role {#placeholders-pod}

The collection address for this type of resource is PodIP, corresponding JSONPath is `.status.podIP`.

<!-- markdownlint-disable MD049 -->
| Name                                         | Description                                                                                                                | Corresponding JSONPath                                                |
| -----------                                  | -----------                                                                                                                | -----                                                          |
| __kubernetes_pod_name                        | Pod name                                                                                                                   | .metadata.name                                                 |
| __kubernetes_pod_namespace                   | Pod namespace                                                                                                               | .metadata.namespace                                            |
| __kubernetes_pod_label_%s                    | Pod labels, e.g., `_kubernetes_pod_label_app`                                                                                 | .metadata.labels['%s']                                         |
| __kubernetes_pod_annotation_%s               | Pod annotations, e.g., `_kubernetes_pod_annotation_prometheus.io/port`                                                             | .metadata.annotations['%s']                                    |
| __kubernetes_pod_node_name                   | Pod's Node                                                                                                            | .spec.nodeName                                                 |
| __kubernetes_pod_container_%s_port_%s_number | Specific container's specific port, e.g., `__kubernetes_pod_container_nginx_port_metrics_number` points to `nginx` container's `metrics` port | .spec.containers[*].ports[*].containerPort ("name" equal "%s") |
<!-- markdownlint-enable -->

For __kubernetes_pod_container_%s_port_%s_number example:

Consider a Pod named nginx, which has two containers, nginx and logfwd. You want to collect data from port 8080 of the nginx container (assuming the port 8080 is named metrics in the configuration). You can configure it as follows:

`__kubernetes_pod_container_nginx_port_metrics_number` (note that nginx and metrics replace %s)

### Service Role {#placeholders-service}

Service resources do not have an IP attribute, so the corresponding Endpoints Address IP property (multiple exist) is used, JSONPath is Endpoints `.subsets[*].addresses[*].ip`.

<!-- markdownlint-disable MD049 -->
| Name                                      | Description                                                                         | Corresponding JSONPath                                         |
| -----------                               | -----------                                                                         | -----                                                   |
| __kubernetes_service_name                 | Service name                                                                        | .metadata.name                                          |
| __kubernetes_service_namespace            | Service namespace                                                                    | .metadata.namespace                                     |
| __kubernetes_service_label_%s             | Service labels                                                                        | .metadata.labels['%s']                                  |
| __kubernetes_service_annotation_%s        | Service annotations                                                                        | .metadata.annotations['%s']                             |
| __kubernetes_service_port_%s_port         | Specific port (rarely used, mostly targetPort is used)                                | .spec.ports[*].port ("name" equal "%s")                 |
| __kubernetes_service_port_%s_targetport   | Specific targetPort                                                                     | .spec.ports[*].targetPort ("name" equal "%s")           |
| __kubernetes_service_target_kind          | Service does not have target, this points to the targetRef of corresponding endpoints, taking its `kind` field      | Endpoints: .subsets[*].addresses[*].targetRef.kind      |
| __kubernetes_service_target_name          | Service does not have target, this points to the targetRef of corresponding endpoints, taking its `name` field      | Endpoints: .subsets[*].addresses[*].targetRef.name      |
| __kubernetes_service_target_namespace     | Service does not have target, this points to the targetRef of corresponding endpoints, taking its `namespace` field | Endpoints: .subsets[*].addresses[*].targetRef.namespace |
| __kubernetes_service_target_pod_name      | Deprecated, use `__kubernetes_service_target_name`                               | Endpoints: .subsets[*].addresses[*].targetRef.name      |
| __kubernetes_service_target_pod_namespace | Deprecated, use `__kubernetes_service_target_namespace`                          | Endpoints: .subsets[*].addresses[*].targetRef.namespace |
<!-- markdownlint-enable -->

### Endpoints Role {#placeholders-endpoints}

The collection address for this type of resource is Address IP (multiple exist), corresponding JSONPath is `.subsets[*].addresses[*].ip`.

<!-- markdownlint-disable MD049 -->
| Name                                                | Description                                                          | Corresponding JSONPath                               |
| -----------                                         | -----------                                                          | -----                                         |
| __kubernetes_endpoints_name                         | Endpoints name                                                       | .metadata.name                                |
| __kubernetes_endpoints_namespace                    | Endpoints namespace                                                   | .metadata.namespace                           |
| __kubernetes_endpoints_label_%s                     | Endpoints labels                                                       | .metadata.labels['%s']                        |
| __kubernetes_endpoints_annotation_%s                | Endpoints annotations                                                       | .metadata.annotations['%s']                   |
| __kubernetes_endpoints_address_node_name            | Endpoints Address Node name                                       | .subsets[*].addresses[*].nodeName             |
| __kubernetes_endpoints_address_target_kind          | targetRef `kind` field                                             | .subsets[*].addresses[*].targetRef.kind       |
| __kubernetes_endpoints_address_target_name          | targetRef `name` field                                             | .subsets[*].addresses[*].targetRef.name       |
| __kubernetes_endpoints_address_target_namespace     | targetRef `namespace` field                                        | .subsets[*].addresses[*].targetRef.namespace  |
| __kubernetes_endpoints_address_target_pod_name      | Deprecated, use `__kubernetes_endpoints_address_target_name`      | .subsets[*].addresses[*].targetRef.name       |
| __kubernetes_endpoints_address_target_pod_namespace | Deprecated, use `__kubernetes_endpoints_address_target_namespace` | .subsets[*].addresses[*].targetRef.namespace  |
| __kubernetes_endpoints_port_%s_number               | Specific port name, e.g., `__kubernetes_endpoints_port_metrics_number`    | .subsets[*].ports[*].port ("name" equal "%s") |
<!-- markdownlint-enable -->

## Practical Examples {#example}

The following examples will create a Service and Deployment, and use KubernetesPrometheus to collect data from the corresponding Pod. Steps are as follows:

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
        image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit-dev/prom-server:v2
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

1. Apply the `kubernetesprometheus.conf` file in the Datakit yaml

``` yaml
        # ..other..
        volumeMounts:
        - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
          name: datakit-conf
          subPath: kubernetesprometheus.conf
          readOnly: true
```

1. Finally, start Datakit and in the logs you will see content like `create prom url xxxxx for testing/prom-svc`, and on the <<< custom_key.brand_name >>> page, you will see the `prom-svc` Measurement.


---

## FAQ {#faq}

### Selector Description and Examples {#selector-example}

`selector` is a commonly used parameter in the `kubectl` command. For example, to find Pods whose Labels contain `tier=control-plane` and `component=kube-controller-manager`, you can use the following command:

```shell
$ kubectl get pod -n kube-system  --selector tier=control-plane,component=kube-controller-manager
NAMESPACE     NAME                      READY   STATUS    RESTARTS   AGE
kube-system   kube-controller-manager   1/1     Running   0          15d
```

The `--selector` parameter functions similarly to the `selector` configuration item. For more usage methods of `selector`, please refer to the [official documentation](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/labels/){:target="_blank"}.

Additionally, Datakit has extended the functionality of `selector` to support **Glob matching patterns**. For detailed Glob syntax, please refer to the [Glob Pattern Documentation](https://developers.tetrascience.com/docs/common-glob-pattern#glob-pattern-syntax). Below are some examples:

[:octicons-tag-24: Version-1.65.1](../datakit/changelog.md#cl-1.65.1)

- **`selector="app=middleware*"`**: Matches any value starting with `middleware`, such as `middleware-etcd` or `middleware-coredns`.
- **`selector="app=middleware-{nginx,redis}"`**: Matches `middleware-nginx` and `middleware-redis`, equivalent to `app in (middleware-nginx, middleware-redis)`.
- **`selector="app=middleware-[123]"`**: Matches any of `middleware-1`, `middleware-2`, and `middleware-3`.

<!-- markdownlint-disable MD046 -->
???+ attention
    The `!` exclusion symbol is not supported in this Glob pattern. For example, `app=middleware-[!0123]` will cause an error during parsing. This is because in Selector syntax, `!` is a critical character (such as used in `app!=nginx`) and therefore cannot be used in Glob patterns.
<!-- markdownlint-enable -->

### Bearer Token Authentication {#http-bearer-token}

In general, using Bearer Token authentication has two prerequisites: enabling `https` and setting `insecure_skip_verify` to `true`.

There are two ways to configure Bearer Token:

- If the Token is a string, you can manually fill it in the `http_headers`, for example:

```yaml
    [inputs.kubernetesprometheus.instances.http_headers]
      "Authorization" = "Bearer XXXXX"
```

- If the Token is stored in a file, specify the file path in `bearer_token_file` as shown in the example. The KubernetesPrometheus collector will automatically read the file contents and add it to the `Authorization` Header. Note that if `Authorization` is manually configured in `http_headers`, `bearer_token_file` will be ineffective.

```yaml
    [inputs.kubernetesprometheus.instances.auth]
      bearer_token_file = "/var/run/secrets/kubernetes.io/serviceaccount/token"
```