# DataKit Pipeline Offload

[:octicons-tag-24: Version-1.9.2](../datakit/changelog.md#cl-1.9.2) ·
[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

The Pipeline Offload feature of DataKit can be used to reduce high latency and high host load caused by data processing.

## Configuration Method

Configuration needs to be enabled in the main configuration file `datakit.conf`. The current supported target `receiver` options are `datakit-http` and `ploffload`, allowing multiple `DataKit` addresses to be configured for load balancing.

Note:

- Currently, only **log (`Logging`) category** data processing tasks are supported for offloading;
- **Do not configure the address of the current `DataKit` in the `addresses` option**, otherwise it will form a loop, causing the data to remain within the current `DataKit`;
- Ensure that the `DataWay` configuration of the target `DataKit` matches the current `DataKit`, otherwise the data receiver will send data to its own `DataWay` address;
- If the `receiver` is set to `ploffload`, the receiving end's DataKit must have the `ploffload` collector enabled.

> Please check if the target network address is accessible from this machine; if the target listens on a loopback address, it will not be accessible.

Sample configuration:

```txt
[pipeline]

  # Offload data processing tasks to post-level data processors.
  [pipeline.offload]
    receiver = "datakit-http"
    addresses = [
      # "http://<ip>:<port>"
    ]
```

If the receiving end DataKit has the `ploffload` collector enabled, it can be configured as follows:

```txt
[pipeline]

  # Offload data processing tasks to post-level data processors.
  [pipeline.offload]
    receiver = "ploffload"
    addresses = [
      # "http://<ip>:<port>"
    ]
```

## Working Principle

When `DataKit` finds the `Pipeline` data processing script, it checks whether it is a remote script from `Guance`. If so, it forwards the data to the post-level data processor (such as `DataKit`). The load balancing method is round-robin.

![Pipeline Offload](img/pipeline-offload.drawio.png)

## Deploying Post-Level Data Processors

There are several ways to deploy data processors (DataKit) for receiving computational tasks:

- Host Deployment

A DataKit dedicated solely to data processing is not currently supported; for host deployment of DataKit, refer to the [documentation](../../datakit/datakit-install.md).

- Container Deployment

You need to set environment variables `ENV_DATAWAY` and `ENV_HTTP_LISTEN`, where the DataWay address should match the one configured with the Pipeline Offload feature of DataKit; it is recommended to map the port listened by the DataKit running inside the container to the host machine.

Sample command:

```sh
docker run --ulimit nofile=64000:64000 \
  -e ENV_DATAWAY="https://openway.guance.com?token=<tkn_>" \
  -e ENV_HTTP_LISTEN="0.0.0.0:9529" \
  -p 9590:9529 \
  -d pubrepo.guance.com/datakit/datakit:<version>
```