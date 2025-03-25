# How to Collect Container Objects
---

## Introduction

<<< custom_key.brand_name >>> supports collecting object data, metrics data, and log data. After enabling the container data acceptance service in DataKit, you can quickly view and analyze the health status of containers, CPU, memory resources, and network traffic usage through "Infrastructure" - "Container" - "CONTAINERS". You can also view the collected container metrics data in "Metrics", build a container metrics visualization dashboard in "Use Cases", and create container monitors in "Monitoring" to receive alerts for any anomalies in container metrics.

## Prerequisites

- Docker v17.04 or higher installed ([Docker Official Link](https://www.docker.com/get-started))
- DataKit installed ([DataKit Installation Documentation](../datakit/datakit-install.md))
- Operating system support: `linux` only

## Methods/Steps

### Step 1: Enable the Container Collector

1. Navigate to the `conf.d/container` directory under the DataKit installation directory.
2. Copy `container.conf.sample` and rename it to `container.conf`.
3. Open `container.conf` and confirm that input is enabled. An example is as follows:

```toml
[inputs.container]
  docker_endpoint = "unix:///var/run/docker.sock"
  containerd_address = "/var/run/containerd/containerd.sock"

  enable_container_metric = false
  enable_k8s_metric = false
  enable_pod_metric = false

  ## Containers logs to include and exclude, default collect all containers. Globs accepted.
  container_include_log = []
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

4. After completing the configuration, use the command `datakit --restart` to restart DataKit for the changes to take effect. The object data collection interval is 5 minutes, meaning that 5 minutes after enabling container collection, you can view the container object data in the <<< custom_key.brand_name >>> workspace.

![](img/3.yaml_6.png)

### Step 2: Enable Metrics Collection for Containers

The DataKit container collection service does not enable metrics collection by default. To enable metrics collection, set `enable_metric` to `true` in `container.conf` and restart DataKit. You can customize the metrics collection for `container`, `k8s`, and `pod` based on your needs.

```
[inputs.container]
  docker_endpoint = "unix:///var/run/docker.sock"
  containerd_address = "/var/run/containerd/containerd.sock"

  enable_container_metric = true
  enable_k8s_metric = true
  enable_pod_metric = true
  
......
```

After collecting metrics data, you can select built-in views in the <<< custom_key.brand_name >>> scenario dashboard to create a container visualization dashboard with one click.

![](img/4.container_1.png)

## Others

For more detailed configurations and explanations regarding container object collection, refer to the documentation [Containers](../integrations/container.md).