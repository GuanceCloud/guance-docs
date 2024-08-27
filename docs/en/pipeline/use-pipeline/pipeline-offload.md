# DataKit Pipeline Offload

[:octicons-tag-24: Version-1.9.2](../datakit/changelog.md#cl-1.9.2) ·
[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

You can use DataKit's Pipeline Offload feature to reduce high latency and high host load caused by data processing.

## Configuration Method

Configuration needs to be enabled in the main `datakit.conf` configuration file. The current supported target `receiver` includes `datakit-http` and `ploffload`, and multiple `DataKit` addresses are allowed for load balancing.

**Notes**:

- Currently, only the processing tasks of **log (Logging) category** data are supported for offloading;
- **Do not fill in the current `DataKit` address in the `addresses` configuration item**, otherwise, it will form a loop, causing the data to always stay in the current `DataKit`;
- Please ensure that the target `DataKit`'s `DataWay` configuration is consistent with the current `DataKit`, otherwise, the data receiver will send to its `DataWay` address;
- If the `receiver` is configured as `ploffload`, the receiving end DataKit needs to have the `ploffload` collector enabled.

Please check whether the target network address can be accessed from this machine. If the target listens to the loopback address, it will not be accessible.

Reference configuration:

```txt
[pipeline]

  # Offload data processing tasks to post-level data processors.
  [pipeline.offload]
    receiver = "datakit-http"
    addresses = [
      # "http://<ip>:<port>"
    ]
```

If the receiving end DataKit has the `ploffload` collector enabled, it can be configured as:

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

After `DataKit` finds the `Pipeline` data processing script, it will determine whether it is a remote script from the "Observation Cloud". If so, it will forward the data to the post-level data processor for processing (such as `DataKit`). The load balancing method is round-robin.

![Pipeline Offload](img/pipeline-offload.drawio.png)

## Deploy Post-Level Data Processor

There are several ways to deploy a data processor (DataKit) for receiving computation tasks:

- Host deployment

A DataKit specifically for data processing is not currently supported; see the [documentation](../../datakit/datakit-install.md) for deploying DataKit on the host.

- Container deployment

You need to set the environment variables `ENV_DATAWAY` and `ENV_HTTP_LISTEN`, where the DataWay address should be consistent with the DataKit configured with the Pipeline Offload function; it is recommended to map the port that the DataKit running inside the container listens to, to the host machine.

Reference command:

```sh
docker run --ulimit nofile=64000:64000 \
  -e ENV_DATAWAY="https://openway.guance.com?token=<tkn_>"  \
  -e ENV_HTTP_LISTEN="0.0.0.0:9529" \
  -p 9590:9529 \
  -d pubrepo.guance.com/datakit/datakit:<version>
```

