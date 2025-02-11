# How to Collect Container Objects
---

## Introduction

Guance supports collecting object data, metrics data, and log data. After enabling container data reception service in DataKit, you can quickly view and analyze the health status of containers, CPU and memory resources, as well as network traffic usage through "Infrastructure" - "Container" - "Containers". You can also view collected container metrics data in "Metrics", build a container metrics visualization dashboard in "Scenarios", and create container monitors in "Monitoring". Alerts can be set up to get immediate notifications of any anomalies in container metrics.

## Prerequisites

- Install Docker v17.04 or higher ([Docker official link](https://www.docker.com/get-started))
- Install DataKit ([DataKit installation documentation](../datakit/datakit-install.md))
- Supported operating systems: `Linux`

## Methods/Steps

### Step 1: Enable Container Collector

1. Navigate to the `conf.d/container` directory under the DataKit installation directory.
2. Copy `container.conf.sample` and rename it to `container.conf`.
3. Open `container.conf`, ensure the input is enabled. Example configuration:

```toml
[inputs.container]
  docker_endpoint = "unix:///var/run/docker.sock"
  containerd_address = "/var/run/containerd/containerd.sock"

  enable_container_metric = false
  enable_k8s_metric = false
  enable_pod_metric = false

  ## Containers logs to include and exclude, default collect all containers. Globs accepted.
  container_include_log = []
  container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*", "image:pubrepo.jiagouyun.com/datakit/datakit*"]

  exclude_pause_container = true

  ## Removes ANSI escape codes from text strings
  logging_remove_ansi_escape_codes = false

  kubernetes_url = "https://kubernetes.default:443"

  ## Authorization level:
  ##   bearer_token -> bearer_token_string -> TLS
  ## Use bearer token for authorization. ('bearer_token' takes priority)
  ## Linux at:   /run/secrets/kubernetes.io/serviceaccount/token
  ## Windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
  bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
  # bearer_token_string = "<your-token-string>"

  [inputs.container.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

4. After completing the configuration, use the command `datakit --restart` to restart DataKit. The object data collection interval is 5 minutes, so you can view the container object data in the Guance workspace 5 minutes after enabling the container collector.

![](img/3.yaml_6.png)

### Step 2: Enable Metrics Collection for Containers

The DataKit container collection service does not enable metrics collection by default. To enable metrics collection, set `enable_metric` to `true` in `container.conf` and restart DataKit. You can customize the collection of metrics for `container`, `k8s`, and `pod` according to your needs.

```toml
[inputs.container]
  docker_endpoint = "unix:///var/run/docker.sock"
  containerd_address = "/var/run/containerd/containerd.sock"

  enable_container_metric = true
  enable_k8s_metric = true
  enable_pod_metric = true
  
......
```

After collecting metrics data, you can choose built-in views in the Guance scenario dashboard to create a container visualization dashboard with one click.

![](img/4.container_1.png)

## Additional Information

For more detailed configurations and explanations regarding container object collection, refer to the [Container](../integrations/container.md) documentation.