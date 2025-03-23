# DataKit Pipeline Offload

[:octicons-tag-24: Version-1.9.2](../datakit/changelog.md#cl-1.9.2) ·
[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

You can use the Pipeline Offload feature of DataKit to reduce high latency caused by data processing and high host load.

## Configuration Method {#config}

You need to enable this in the main configuration file `datakit.conf`. The configuration is shown below. Currently supported target `receiver` options are `datakit-http` and `ploffload`, and you can configure multiple `DataKit` addresses for load balancing.

Note:

- Currently only supports offloading **LOGS (Logging)** category data processing tasks;
- **Do not include the address of the current `DataKit` in the `addresses` configuration**, otherwise it will create a loop, causing the data to remain within the current `DataKit`;
- Ensure that the `DataWay` configuration of the target `DataKit` matches the current `DataKit`, otherwise the data receiver will send to its `DataWay` address;
- If the `receiver` is set to `ploffload`, the receiving end's DataKit must have the `ploffload` collector enabled.

> Please check if the target network address is accessible from this machine; if the target listens on a loopback address, it will be inaccessible.

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

`DataKit` checks if the `Pipeline` data processing script is a remote script from `Guance`. If so, it forwards the data to the downstream data processor (e.g., `DataKit`). The load balancing method is round-robin.

![Pipeline Offload](img/pipeline-offload.drawio.png)

## Deploying Downstream Data Processors {#post-level-processor}

There are several ways to deploy the data processor (DataKit) for receiving computational tasks:

- Host Deployment

Currently does not support a DataKit exclusively for data processing; for host deployment of DataKit, refer to the [documentation](../../datakit/datakit-install.md).

- Container Deployment

You need to set environment variables `ENV_DATAWAY` and `ENV_HTTP_LISTEN`, where the DataWay address needs to match the DataKit with the Pipeline Offload feature enabled. It is recommended to map the port listened by the DataKit running inside the container to the host machine.

Reference command:

```sh
docker run --ulimit nofile=64000:64000 \
  -e ENV_DATAWAY="https://openway.<<< custom_key.brand_main_domain >>>?token=<tkn_>" \
  -e ENV_HTTP_LISTEN="0.0.0.0:9529" \
  -p 9590:9529 \
  -d pubrepo.guance.com/datakit/datakit:<version>
```