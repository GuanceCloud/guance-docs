# DataKit Pipeline Offload

[:octicons-tag-24: Version-1.9.2](../datakit/changelog.md#cl-1.9.2) ·
[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

The Pipeline Offload feature of DataKit can be used to reduce high data latency and high HOST load caused by data processing.

## Configuration Method {#config}

It needs to be enabled in the main configuration file `datakit.conf`. See the configuration below. The currently supported target `receiver` options are `datakit-http` and `ploffload`, and multiple `DataKit` addresses can be configured to achieve load balancing.

Note:

- Currently, it only supports offloading **LOG** category data processing tasks;
- **The current `DataKit` address cannot be entered in the `addresses` configuration item**, otherwise a loop will form, causing the data to stay within the current `DataKit`;
- Ensure that the `DataWay` configuration of the target `DataKit` is consistent with the current `DataKit`, otherwise the receiving party will send data to its `DataWay` address;
- If the `receiver` is set to `ploffload`, the `ploffload` collector must be enabled on the receiving end's DataKit.

> Please check if the target network address is accessible from this machine. If the target listens on a loopback address, it will not be accessible.

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

After `DataKit` locates the `Pipeline` data processing script, it determines whether it is a remote script from ` <<<custom_key.brand_name>>> `. If so, the data will be forwarded to the post-level data processor (such as `DataKit`) for processing. The load balancing method is round-robin.

![Pipeline Offload](img/pipeline-offload.drawio.png)

## Deploy Post-Level Data Processor {#post-level-processor}

There are several ways to deploy the data processor (DataKit) used for receiving computational tasks:

- Host Deployment

Currently, there is no support for a DataKit specifically dedicated to data processing. For host deployment of DataKit, refer to the [documentation](../../datakit/datakit-install.md).

- Container Deployment

Environment variables `ENV_DATAWAY` and `ENV_HTTP_LISTEN` need to be set. The DataWay address should match the one configured in the DataKit with the Pipeline Offload function enabled. It is recommended to map the port listened by the DataKit running inside the container to the host machine.

Reference command:

```sh
docker run --ulimit nofile=64000:64000 \
  -e ENV_DATAWAY="https://openway.<<<custom_key.brand_main_domain>>>?token=<tkn_>" \
  -e ENV_HTTP_LISTEN="0.0.0.0:9529" \
  -p 9590:9529 \
  -d pubrepo.<<<custom_key.brand_main_domain>>>/datakit/datakit:<version>
```