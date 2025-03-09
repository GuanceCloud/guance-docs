# DataKit Pipeline Offload

[:octicons-tag-24: Version-1.9.2](../datakit/changelog.md#cl-1.9.2) ·
[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

You can use the Pipeline Offload feature of DataKit to reduce high latency and high host load caused by data processing.

## Configuration Method {#config}

Configuration needs to be enabled in the main configuration file `datakit.conf`. The configuration is shown below. Currently supported target `receiver` options are `datakit-http` and `ploffload`, allowing multiple `DataKit` addresses to be configured for load balancing.

Note:

- Currently, only **log (`Logging`) category** data processing tasks are supported;
- **Do not enter the address of the current `DataKit` in the `addresses` configuration item**, otherwise a loop will be formed, causing the data to remain within the current `DataKit`;
- Ensure that the `DataWay` configuration of the target `DataKit` matches the current `DataKit`, otherwise the data receiver will send data to its `DataWay` address;
- If the `receiver` is configured as `ploffload`, the receiving end's DataKit must have the `ploffload` collector enabled.

> Please check if the target network address can be accessed from this machine; if the target listens on a loopback address, it cannot be accessed.

Example configuration:

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

## Working Principle {#principle}

When `DataKit` finds a `Pipeline` data processing script, it determines whether the script is a remote script from `Guance`. If so, it forwards the data to a post-level data processor (such as `DataKit`). The load balancing method used is round-robin.

![Pipeline Offload](img/pipeline-offload.drawio.png)

## Deploying Post-Level Data Processors {#post-level-processor}

There are several ways to deploy a data processor (DataKit) for receiving computational tasks:

- Host Deployment

Currently, there is no dedicated DataKit for data processing; for host deployment of DataKit, see [documentation](../../datakit/datakit-install.md).

- Container Deployment

You need to set environment variables `ENV_DATAWAY` and `ENV_HTTP_LISTEN`, where the DataWay address should match the one configured for the DataKit with the Pipeline Offload feature. It is recommended to map the port that the DataKit running inside the container listens on to the host machine.

Example command:

```sh
docker run --ulimit nofile=64000:64000 \
  -e ENV_DATAWAY="https://openway.guance.com?token=<tkn_>" \
  -e ENV_HTTP_LISTEN="0.0.0.0:9529" \
  -p 9590:9529 \
  -d pubrepo.guance.com/datakit/datakit:<version>
```