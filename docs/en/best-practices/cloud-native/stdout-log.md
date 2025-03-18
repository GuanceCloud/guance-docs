# Best Practices for Kubernetes StdOut Log Whitelisting

---

## Environment Preparation

An existing Kubernetes environment (referred to as K8s). This practice is based on self-built Kubernetes v1.23.1, <<< custom_key.brand_name >>> Datakit version 1.2.13, and Nginx 1.17.

Datakit has been deployed, and the Datakit configuration file `container.conf` is managed via ConfigMap.

> **Note:** The configuration principles for Alibaba Cloud Container Service for Kubernetes or other cloud service providers' Kubernetes are similar.

## Prerequisites

Nginx logs in the K8s environment are output via StdOut rather than files. <<< custom_key.brand_name >>> Datakit, when deployed as a DaemonSet, collects all StdOut log outputs within K8s by default, including those from cluster internal components like CoreDNS (if logging is enabled). All logs discussed in this article are output via Stdout.

Note: StdOut is a method chosen by developers to output logs to the console, such as:

```
<appender name="console" class="ch.qos.logback.core.ConsoleAppender">
```

## Whitelist Requirements

After deploying Datakit, you can selectively collect logs from specified business Pods and K8s cluster components. Logs from newly added, unspecified business Pods will not be collected. Additionally, for multiple containers within the same Pod, only one or more of them can be selected for log collection.

This article achieves this using different log filtering methods with <<< custom_key.brand_name >>> collector Datakit, combining adding annotations to logs (including filtering out logs from other containers within the Pod) and using `container_include_log = []` in `container.conf`.

> For more detailed log processing principles, refer to <[Datakit Log Processing Overview](../../integrations/datakit-logging-how.md)>

## Implementation Methods

### Method One: Using `container_include_log = []`

Only collect logs from cluster components coredns and nginx. Use regular expressions to specify the image names in `container_include_log`.
> Refer to <[Configuring Metrics and Log Collection Based on Container Image](../../integrations/container.md)>

```toml
      [inputs.container]
        docker_endpoint = "unix:///var/run/docker.sock"
        containerd_address = "/var/run/containerd/containerd.sock"

        enable_container_metric = true
        enable_k8s_metric = true
        enable_pod_metric = true

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        container_include_log = ["image:*coredns*","image:*nginx*"]
        container_exclude_log = ["image:pubrepo.<<< custom_key.brand_main_domain >>>/datakit/logfwd*", "image:pubrepo.<<< custom_key.brand_main_domain >>>/datakit/datakit*"]

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

This method collects logs from Pods with specified image names, as shown in the following figure:

![image](../images/stdout-log/1.png)

### Method Two: Combining `container_include_log = []` and Annotation Marking

Collect logs only from cluster components coredns and nginx, while marking nginx with annotations. Even images not included in the `container_include_log` whitelist, such as busybox, can be marked via annotations for collection. This is because annotation marking has higher priority.

> For more detailed log processing principles, refer to <[Datakit Log Processing Overview](../../integrations/datakit-logging-how.md)>

Nginx's annotation marking:

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

Collect logs only from cluster components coredns and nginx, while marking nginx with annotations that specify `"only_images"` to filter logs from specific container images within the Pod, implementing a whitelist strategy internally.

#### Before Enabling Pod Internal Whitelist

As shown in the figure below, both nginx and busybox logs are collected.

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

Actually, it is not recommended to enable whitelist strategies. Whitelists can cause many issues and are difficult to debug. Unexpected effects may occur, such as developers not seeing certain logs because a specific tag was not added. To filter log sources, blacklists are safer; the worst-case scenario is that data is still collected, which can then be filtered out later. For example, in Datakit collector `container.conf`, you can use:

```bash
container_exclude_log = ["image:pubrepo.<<< custom_key.brand_main_domain >>>/datakit/logfwd*"]
```

Method one does not use annotation marking but relies on built-in filtering methods in the collector's `container.conf`, which is a more fundamental approach. However, this method is less flexible compared to method two, as annotations allow better tagging of log sources, making future problem analysis and filtering easier. Additionally, annotations are applied to business Pods, enabling finer-grained control over log collection for a batch of business images.

Method three, combined with specific business scenarios, filters out unnecessary Sidecar logs, reducing noise in log collection.