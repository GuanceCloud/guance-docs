# Datakit KubernetesPrometheus Collector Documentation

[:octicons-tag-24: Version-1.34.0](changelog.md#cl-1.34.0)
[:octicons-beaker-24: Experimental](index.md#experimental)

## Overview {#overview}

KubernetesPrometheus is a collector designed specifically for Kubernetes applications. It automatically discovers Prometheus services based on custom configurations and greatly simplifies the usage process.

This collector requires a certain level of familiarity with Kubernetes, such as the ability to inspect attributes of resources like Services and Pods using `kubectl` commands.

A brief description of how this collector operates helps in better understanding and utilizing it. KubernetesPrometheus is implemented in the following steps:

1. Registers event notification mechanisms with the Kubernetes API server to promptly receive notifications about the creation, updating, and deletion of various resources.
2. Upon the creation of a resource (e.g., Pod), KubernetesPrometheus receives a notification and decides whether to collect data from that Pod based on configuration files.
3. If the Pod meets the criteria, it identifies the corresponding attributes of the Pod (e.g., Port) using placeholders in the configuration file and constructs an access URL.
4. KubernetesPrometheus accesses this URL, parses the data, and adds tags.
5. If the Pod undergoes updates or is deleted, the KubernetesPrometheus collector stops collecting data from the Pod and decides whether to initiate new collection based on specific conditions.

Below is a basic configuration example that implements Prometheus data collection for such Pods and adds tags:

```yaml
[[inputs.kubernetesprometheus.instances]]
  role       = "pod"
  namespaces = ["middleware"]
  selector   = "app=nginx"

  scrape     = "true"
  scheme     = "http"
  port       = "__kubernetes_pod_container_nginx_port_metrics_number"
  path       = "/metrics"
  params     = ""
  interval   = "30s"

  [inputs.kubernetesprometheus.instances.custom]
    measurement        = "pod-nginx"
    job_as_measurement = false
    [inputs.kubernetesprometheus.instances.custom.tags]
      pod_name         = "__kubernetes_pod_name"
      pod_namespace    = "__kubernetes_pod_namespace"

  [inputs.kubernetesprometheus.instances.auth]
    bearer_token_file      = "/var/run/secrets/kubernetes.io/serviceaccount/token"
    [inputs.kubernetesprometheus.instances.auth.tls_config]
      insecure_skip_verify = true
      ca_certs = []
      cert     = ""
      cert_key = ""
```

```markdown
<!-- markdownlint-disable MD046 -->
???+ attention

  There is no need to manually configure the IP address; the collector will use default IPs as follows:

  - `node` uses InternalIP
  - `Pod` uses Pod IP
  - `Service` uses the IP addresses of corresponding Endpoints (multiple)
  - `Endpoints` uses the corresponding Address IPs (multiple)

  Additionally, ensure that ports are not bound to the loopback address to allow external access.
<!-- markdownlint-enable -->

Assuming the Pod IP is `172.16.10.10` and the metrics port for the nginx container is 9090.

The KubernetesPrometheus collector will ultimately create a target address `http://172.16.10.10:9090/metrics` for Prometheus scraping. After parsing the data, it will add labels `pod_name` and `pod_namespace`, with the metric set named `pod-nginx`.

If another Pod exists that also matches the namespace and selector configurations, it will also be collected.
```

## Configuration Details {#input-config}

The KubernetesPrometheus collector primarily uses placeholders for configuration, retaining only essential settings necessary for data collection (e.g., port, path). Below is an explanation of each configuration item.

Using the configuration example provided:

### Main Configuration {#input-config-main}

| Configuration Item | Required | Default Value | Description                                                                                                                    | Placeholder Supported |
| ------------------ | -------- | ------------- | -----------------------------------------------------------------------------------------------------------                    | --------------------- |
| `role`             | Yes      | None          | Specifies the type of resource to collect, which can only be `node`, `pod`, `service`, or `endpoints`.                         | No                    |
| `namespace`        | No       | None          | Limits the namespace of the resource. It's an array and supports multiple entries, e.g., `["kube-system", "testing"]`.         | No                    |
| `selector`         | No       | None          | Labels for querying and filtering, allowing for precise selection. Format: `'=', '==', '!='`, e.g., `key1=value1,key2=value2`. | No                    |
| `scrape`           | No       | "true"        | Determines whether to perform scraping. Set to empty string or `true` for scraping, otherwise no scraping.                     | Yes                   |
| `scheme`           | No       | "http"        | Default is `http`. Use `https` if scraping requires certificates.                                                              | Yes                   |
| `port`             | Yes      | None          | Port of the target address, requires manual configuration.                                                                     | Yes                   |
| `path`             | No       | "/metrics"    | HTTP access path, default is `/metrics`.                                                                                       | Yes                   |
| `params`           | No       | None          | HTTP access parameters as a string, e.g., `name=nginx&package=middleware`.                                                     | No                    |
| `interval`         | No       | 30s           | Collection interval, supports formats like `"30s", "2m", "2d"`.                                                                | No                    |

> `selector` is commonly used in `kubectl` commands. For example, to find Pods with labels `tier=control-plane` and `component=kube-controller-manager`, use:
    `$ kubectl get pod --selector tier=control-plane,component=kube-controller-manager`
    The `--selector` parameter functions similarly to the `selector` configuration item. For more details, refer to the [official documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/){:target="_blank"}.

### Custom Configuration {#input-config-custom}

| Configuration Item     | Required | Default Value                                      | Description                                                                                            |
| ---------------------- | -------- | ----------------------------------                 | ---------------------------------------------------------------------------                            |
| `measurement`          | No       | Split by the first underscore in metric field name | Configures the name of the metric set.                                                                 |
| `job_as_measurement`   | No       | false                                              | Whether to use the `job` label value from data as the metric set name.                                 |
| `tags`                 | No       | None                                               | Adds tags; note that keys do not support placeholders, values support placeholders as described later. |

<!-- markdownlint-disable MD046 -->
???+ attention

  KubernetesPrometheus collector does not add any default tags, including `election_tags` and `host_tags` from Datakit, as well as `cluster_name_k8s`.

  All tags need to be added manually.
<!-- markdownlint-enable -->

### Permissions and Authentication {#input-config-auth}

- `bearer_token_file`: Configures the path to the token file, typically used together with `insecure_skip_verify`.
- `tls_config`: Configures certificate-related settings. Sub-configuration items include `insecure_skip_verify`, `ca_certs`, `cert`, and `cert_key`. Note that `ca_certs` is configured as an array.

## Placeholder Explanation {#placeholders}

Placeholders are a crucial part of the entire collection scheme. They are strings that point to specific properties of resources.

There are two main types of placeholders: "Match" and "Regex":

- Match, such as `__kubernetes_pod_name`, uniquely points to the Pod Name, providing straightforward clarity.
- Regex is used to configure custom resource names. In the following text, `%s` is used as a placeholder. For example, if a Pod has a label `app=nginx` and you need to extract `nginx` as a tag, configure it as follows:

```yaml
    [inputs.kubernetesprometheus.instances.custom.tags]
      app = "__kubernetes_pod_label_app"
```

Why is this step necessary?

This step is necessary because the value of this label is not fixed and can vary depending on the Pod. For example, one Pod might have `app=nginx`, while another Pod might have `app=redis`. If you want to use the same configuration to collect data from both Pods, you need to differentiate them based on their labels. This configuration method allows you to achieve that.

Placeholders are primarily used for selecting `annotations` and `labels`, and are also used for configuring ports. For example, if a Pod has a container named nginx with a port named `metrics`, you can specify it as `__kubernetes_pod_container_nginx_port_metrics_number` when collecting data from that port.

Below are the placeholders supported by various resources (`node`, `pod`, `service`, `endpoints`).

### Node Role {#placeholders-node}

The collection address for these resources is the InternalIP, corresponding to JSONPath `.status.addresses[*].address ("type" is "InternalIP")`.

<!-- markdownlint-disable MD049 -->
| Name                                    | Description                        | Corresponding JSONPath                              |
| -----------                             | -----------                        | -----                                               |
| __kubernetes_node_name                  | Node name                          | .metadata.name                                      |
| __kubernetes_node_label_%s              | Node label                         | .metadata.labels['%s']                              |
| __kubernetes_node_annotation_%s         | Node annotation                    | .metadata.annotations['%s']                         |
| __kubernetes_node_address_Hostname      | Node hostname                      | .status.addresses[*].address ("type" is "Hostname") |
| __kubernetes_node_kubelet_endpoint_port | Node's kubelet port, usually 10250 | .status.daemonEndpoints.kubeletEndpoint.Port        |
<!-- markdownlint-enable -->

### Pod Role {#placeholders-pod}

The collection address for these resources is the PodIP, corresponding to JSONPath `.status.podIP`.

<!-- markdownlint-disable MD049 -->
| Name                                         | Description                                                                                                                                                      | Corresponding JSONPath                                         |
| -----------                                  | -----------                                                                                                                                                      | -----                                                          |
| __kubernetes_pod_name                        | Pod name                                                                                                                                                         | .metadata.name                                                 |
| __kubernetes_pod_namespace                   | Pod namespace                                                                                                                                                    | .metadata.namespace                                            |
| __kubernetes_pod_label_%s                    | Pod label, for example, `_kubernetes_pod_label_app`                                                                                                              | .metadata.labels['%s']                                         |
| __kubernetes_pod_annotation_%s               | Pod annotation, for example, `_kubernetes_pod_annotation_prometheus.io/port`                                                                                     | .metadata.annotations['%s']                                    |
| __kubernetes_pod_node_name                   | Node where the Pod is located                                                                                                                                    | .spec.nodeName                                                 |
| __kubernetes_pod_container_%s_port_%s_number | Specific port of a specific container, for example, `__kubernetes_pod_container_nginx_port_metrics_number` refers to the `metrics` port of the `nginx` container | .spec.containers[*].ports[*].containerPort ("name" equal "%s") |
<!-- markdownlint-enable -->

For example, for `__kubernetes_pod_container_%s_port_%s_number`:

Suppose there is a Pod named nginx with 2 containers, nginx and logfwd. If you want to collect data from port 8080 of the nginx container (assuming the port is named `metrics` in the configuration), you can configure it as:

`__kubernetes_pod_container_nginx_port_metrics_number` (note how `nginx` and `metrics` replace `%s`).

### Service Role {#placeholders-service}

Since Service resources do not have an IP property, the corresponding Endpoints Address IP property is used (which can have multiple values), with the JSONPath being `.subsets[*].addresses[*].ip`.

<!-- markdownlint-disable MD049 -->
| Name                                      | Description                                                                                                                                                                | Corresponding JSONPath                                                    |
| -----------                               | -----------                                                                                                                                                                | -----                                                                     |
| __kubernetes_service_name                 | Service name                                                                                                                                                               | .metadata.name                                                            |
| __kubernetes_service_namespace            | Service namespace                                                                                                                                                          | .metadata.namespace                                                       |
| __kubernetes_service_label_%s             | Service label                                                                                                                                                              | .metadata.labels['%s']                                                    |
| __kubernetes_service_annotation_%s        | Service annotation                                                                                                                                                         | .metadata.annotations['%s']                                               |
| __kubernetes_service_port_%s_port         | Specific port (rarely used, as targetPort is mostly used in most scenarios)                                                                                                | .spec.ports[*].port ("name" equal "%s")                                   |
| __kubernetes_service_port_%s_targetport   | Specific targetPort                                                                                                                                                        | .spec.ports[*].targetPort ("name" equal "%s")                             |
| __kubernetes_service_target_pod_name      | Services do not have a direct target; this refers to the `targetRef` of corresponding Endpoints. If it's of type Pod, it takes its `name` field, otherwise it's empty      | Endpoints: .subsets[*].addresses[*].targetRef.name ("kind" is "Pod")      |
| __kubernetes_service_target_pod_namespace | Services do not have a direct target; this refers to the `targetRef` of corresponding Endpoints. If it's of type Pod, it takes its `namespace` field, otherwise it's empty | Endpoints: .subsets[*].addresses[*].targetRef.namespace ("kind" is "Pod") |
<!-- markdownlint-enable -->

### Endpoints Role {#placeholders-endpoints}

The collection address for these types of resources is the Address IP (which can have multiple values), with the corresponding JSONPath being `.subsets[*].addresses[*].ip`.

<!-- markdownlint-disable MD049 -->
| Name                                                | Description                                                                    | Corresponding JSONPath                                         |
| -----------                                         | -----------                                                                    | -----                                                          |
| __kubernetes_endpoints_name                         | Endpoints name                                                                 | .metadata.name                                                 |
| __kubernetes_endpoints_namespace                    | Endpoints namespace                                                            | .metadata.namespace                                            |
| __kubernetes_endpoints_label_%s                     | Endpoints label                                                                | .metadata.labels['%s']                                         |
| __kubernetes_endpoints_annotation_%s                | Endpoints annotation                                                           | .metadata.annotations['%s']                                    |
| __kubernetes_endpoints_address_node_name            | Node name of Endpoints Address                                                 | .subsets[*].addresses[*].nodeName                              |
| __kubernetes_endpoints_address_target_pod_name      | If `targetRef` is of type Pod, it takes its `name` field, otherwise empty      | .subsets[*].addresses[*].targetRef.name ("kind" is "Pod")      |
| __kubernetes_endpoints_address_target_pod_namespace | If `targetRef` is of type Pod, it takes its `namespace` field, otherwise empty | .subsets[*].addresses[*].targetRef.namespace ("kind" is "Pod") |
| __kubernetes_endpoints_port_%s_number               | Specifies the port name, e.g., `__kubernetes_endpoints_port_metrics_number`    | .subsets[*].ports[*].port ("name" equal "%s")                  |
<!-- markdownlint-enable -->

## Example {#example}

The following example will create a Service and Deployment, using KubernetesPrometheus to collect metrics from the corresponding Pods. The steps are as follows:

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

1. Create ConfigMap and KubernetesPrometheus Configuration

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
          interval   = "15s"

          [inputs.kubernetesprometheus.instances.custom]
            measurement        = "prom-svc"
            job_as_measurement = false
            [inputs.kubernetesprometheus.instances.custom.tags]
              svc_name      = "__kubernetes_service_name"
              pod_name      = "__kubernetes_service_target_pod_name"
              pod_namespace = "__kubernetes_service_target_pod_namespace"
```

1. Apply the `kubernetesprometheus.conf` file in `datakit.yaml`.

``` yaml
        # ..other..
        volumeMounts:
        - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
          name: datakit-conf
          subPath: kubernetesprometheus.conf
          readOnly: true
```

1. Finally, start `Datakit`. In the logs, you should see the message `create prom url xxxxx for testing/prom-svc`, and you should be able to observe the `prom-svc` metrics set on the Guance page.

## FAQ {#faq}