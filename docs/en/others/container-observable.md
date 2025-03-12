# How to Collect Container Objects
---

## Introduction

<<< custom_key.brand_name >>> supports collecting object data, metrics data, and log data. After enabling the container data reception service in DataKit, you can quickly view and analyze the health status of containers, CPU, memory resources, and network traffic usage through "Infrastructure" - "Containers" - "Containers". You can also view collected container metrics data in "Metrics", build container metrics visualization dashboards in "Scenarios", and create container monitors in "Monitoring" to get notified of any anomalies in container metrics immediately.

## Prerequisites

- Install Docker v17.04 or higher ([Docker official link](https://www.docker.com/get-started))
- Install DataKit ([DataKit installation documentation](../datakit/datakit-install.md))
- Supported operating systems: `Linux`

## Method/Steps

### Step 1: Enable Container Collector

1. Navigate to the `conf.d/container` directory under the DataKit installation directory.
2. Copy `container.conf.sample` and rename it to `container.conf`.
3. Open `container.conf` and ensure that input is enabled. Example configuration:

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
  ## Linux path: /run/secrets/kubernetes.io/serviceaccount/token
  ## Windows path: C:\var\run\secrets\kubernetes.io\serviceaccount\token
  bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
  # bearer_token_string = "<your-token-string>"

  [inputs.container.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

4. After completing the configuration, use the command `datakit --restart` to restart DataKit for the changes to take effect. The object data collection interval is 5 minutes, so you can view the collected container object data in the <<< custom_key.brand_name >>> workspace 5 minutes after enabling container collection.

![](img/3.yaml_6.png)

### Step 2: Enable Container Metrics Collection

The DataKit container collection service does not enable metrics collection by default. If you need to enable metrics collection, set `enable_metric` to `true` in `container.conf` and restart DataKit. You can customize which metrics to collect (`container`, `k8s`, `pod`) based on your needs.

```toml
[inputs.container]
  docker_endpoint = "unix:///var/run/docker.sock"
  containerd_address = "/var/run/containerd/containerd.sock"

  enable_container_metric = true
  enable_k8s_metric = true
  enable_pod_metric = true
  
......
```

After enabling metrics collection, you can choose built-in views in <<< custom_key.brand_name >>> scenario dashboards to create container visualization dashboards with one click.

![](img/4.container_1.png)

## Additional Information

For more detailed configurations and explanations regarding container object collection, refer to the [Container](../integrations/container.md) documentation.