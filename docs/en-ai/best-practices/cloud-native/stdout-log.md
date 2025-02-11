# Best Practices for Kubernetes StdOut Log Whitelisting

---

## Environment Preparation

An existing Kubernetes environment (referred to as K8s) is required. This practice is based on a self-built Kubernetes v1.23.1, Guance Datakit version 1.2.13, and Nginx 1.17.

Datakit has been deployed, and the Datakit configuration file `container.conf` is managed via ConfigMap.

> **Note:** The configuration principles for Alibaba Cloud Container Service for Kubernetes or other cloud providers' Kubernetes services are similar.

## Prerequisites

Nginx logs in the K8s environment are output via StdOut rather than files. After deploying Datakit as a DaemonSet, it defaults to collecting all StdOut log outputs within K8s, including those from cluster components such as CoreDNS (if logging is enabled). All logs mentioned in this article are output via Stdout.

Note: StdOut is the output method chosen by developers when writing code to select the console for log output, such as:

```
<appender name="console" class="ch.qos.logback.core.ConsoleAppender">
```

## Whitelist Requirements

After deploying Datakit, you can collect logs from specified business Pods and K8s cluster components. Logs from newly added, unspecified business Pods will not be collected. Additionally, for multiple containers within the same Pod, you can choose to collect logs from one or more containers.

This article achieves this using different log filtering methods with Guance's Datakit collector, combining annotations (including filtering logs from other containers within the Pod) and the `container_include_log = []` setting in `container.conf`.

> For more detailed log processing principles, refer to [Datakit Log Processing Overview](../../integrations/datakit-logging-how.md).

## Implementation Methods

### Method One: Using `container_include_log = []`

Collect logs only from cluster components CoreDNS and Nginx. Use regular expressions in `container_include_log` to specify image names.
> Refer to [Configure Metrics and Logs Collection Based on Container Image](../../integrations/container.md) for specifics.

```toml
      [inputs.container]
        docker_endpoint = "unix:///var/run/docker.sock"
        containerd_address = "/var/run/containerd/containerd.sock"

        enable_container_metric = true
        enable_k8s_metric = true
        enable_pod_metric = true

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        container_include_log = ["image:*coredns*","image:*nginx*"]
        container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*", "image:pubrepo.jiagouyun.com/datakit/datakit*"]

        exclude_pause_container = true

        ## Removes ANSI escape codes from text strings
        logging_remove_ansi_escape_codes = false

        kubernetes_url = "https://kubernetes.default:443"

        ## Authorization level:
        ##   bearer_token -> bearer_token_string -> TLS
        ## Use bearer token for authorization. ('bearer_token' takes priority)
        ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
        ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
        bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
        # bearer_token_string = "<your-token-string>"

        [inputs.container.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
```

#### Implementation Effect

This collects logs from Pods with specified image names, as shown in the following figure:

![image](../images/stdout-log/1.png)

### Method Two: Combining `container_include_log = []` and Annotation Marking

Collect logs only from cluster components CoreDNS and Nginx while marking Nginx with annotations. Even images not included in `container_include_log`, such as BusyBox, can be collected through annotation marking due to its higher priority.

> For more detailed log processing principles, refer to [Datakit Log Processing Overview](../../integrations/datakit-logging-how.md).

Annotation marking for Nginx:

```bash
      labels:
         app: nginx-pod
      annotations:
        datakit/logs: |
          [
            {
              "disable": false,
              "source": "nginx-source",
              "service": "nginx-source",
              "pipeline": "",
              "multiline_match": ""
            }
          ]
    spec:
```

```toml
[inputs.container]
  docker_endpoint = "unix:///var/run/docker.sock"
  containerd_address = "/var/run/containerd/containerd.sock"

  ## Containers metrics to include and exclude, default not collect. Globs accepted.
  container_include_metric = []
  container_exclude_metric = ["image:*"]

  ## Containers logs to include and exclude, default collect all containers. Globs accepted.
  container_include_log = ["image:*coredns*","image:*nginx*"]
  container_exclude_log = []

  exclude_pause_container = true

  ## Removes ANSI escape codes from text strings
  logging_remove_ansi_escape_codes = false
  ## Maximum length of logging, default 32766 bytes.
  max_logging_length = 32766

  kubernetes_url = "https://kubernetes.default:443"

  ## Authorization level:
  ##   bearer_token -> bearer_token_string -> TLS
  ## Use bearer token for authorization. ('bearer_token' takes priority)
  ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
  ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
  bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
  # bearer_token_string = "<your-token-string>"

  [inputs.container.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

#### Implementation Effect

![image](../images/stdout-log/2.png)

### Method Three: Filtering Logs from Specific Containers within a Pod

Collect logs only from cluster components CoreDNS and Nginx while marking Nginx with annotations that specify the `"only_images"` field to filter logs from specific container images within the Pod.

#### Before Enabling Pod Internal Whitelist

As shown in the figure below, both Nginx and BusyBox logs are collected.

![image](../images/stdout-log/3.png)

#### Enabling Pod Internal Whitelist

```bash
      labels:
         app: nginx-pod
      annotations:
        datakit/logs: |
          [
            {
              "disable": false,
              "source": "nginx-source",
              "service": "nginx-source",
              "pipeline": "",
              "only_images": ["image:*nginx*"],
              "multiline_match": ""
            }
          ]
    spec:
```

#### Implementation Effect

Only Nginx logs within the Pod are retained.<br />

![image](../images/stdout-log/4.png)

## Summary

It is generally not recommended to use whitelist strategies as they can cause many issues and are difficult to debug. Unexpected effects can occur, such as developers not seeing certain logs because a specific tag was not added. To filter log sources, blacklisting is safer; in the worst case, data is still collected. For example, blacklisting in Datakit's `container.conf`:

```bash
container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*"]
```

Method one does not use annotations but relies on built-in filtering in the `container.conf` file, which is a more low-level approach. However, this method is less flexible compared to method two, where annotations provide better tagging for log sources, making future analysis and filtering easier. Annotations can also be applied to business Pods, allowing for finer-grained control over log collection for a batch of business images.

Method three combines specific business scenarios to filter out unnecessary Sidecar logs, reducing noise in log collection.