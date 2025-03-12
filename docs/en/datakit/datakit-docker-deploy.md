# Deploy Datakit in Docker
---

This document describes how to install DataKit in Docker.

## Start {#start}

The container startup command is as follows:

> The following `<XXX-YYY-ZZZ>` content needs to be filled in according to the actual situation.

```shell
sudo docker run \
    --hostname "$(hostname)" \
    --workdir /usr/local/datakit \
    -v "<YOUR-HOST-DIR-FOR-CONF>":"/usr/local/datakit/conf.d/host-inputs-conf" \
    -v "/":"/rootfs" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e ENV_DATAWAY="https://openway.guance.com?token=<YOUR-WORKSPACE-TOKEN>" \
    -e ENV_DEFAULT_ENABLED_INPUTS='cpu,disk,diskio,mem,swap,system,net,host_processes,hostobject,container,dk' \
    -e ENV_GLOBAL_HOST_TAGS="<TAG1=A1,TAG2=A2>" \
    -e ENV_HTTP_LISTEN="0.0.0.0:9529" \
    -e HOST_PROC="/rootfs/proc" \
    -e HOST_SYS="/rootfs/sys" \
    -e HOST_ETC="/rootfs/etc" \
    -e HOST_VAR="/rootfs/var" \
    -e HOST_RUN="/rootfs/run" \
    -e HOST_DEV="/rootfs/dev" \
    -e HOST_ROOT="/rootfs/root" \
    --cpus 2 \
    --memory 1g \
    --privileged \
    --publish 19529:9529 \
    -d \
    pubrepo.guance.com/datakit/datakit:1.68.1
```

Explanation of startup parameters:

- **`--hostname`** sets the hostname of the host machine as the hostname for Datakit. If multiple Datakits need to run on the same host, you can add appropriate suffixes like `--hostname "$(hostname)-dk1"`
- **`--workdir`** sets the working directory inside the container
- **`-v`**: Mount various host files:
    - DataKit has many configuration files that can be prepared on the host machine and mounted into the container using `-v` (the path in the container is the *conf.d/host-inputs-conf* directory)
    - This mounts the root directory of the host into Datakit to access various information on the host (such as files under the `/proc` directory) for data collection by default enabled collectors
    - Mounts the *docker.sock* file into the Datakit container to facilitate data collection by the container collector. The directory of this file may differ across hosts and should be configured accordingly
- **`-e`**: Various environment variables for Datakit runtime configuration, these environment variables serve the same purpose as when [deployed via DaemonSet](datakit-daemonset-deploy.md#env-setting)
- **`--publish`**: Facilitates sending Trace and other data to the Datakit container from outside. Here, we map the HTTP port of Datakit to port 19529 externally. When setting up addresses for trace data, pay attention to this port configuration.
- Here, the running Datakit is set with a CPU limit of 2 cores and 1GiB of memory

If we configure the following collectors in the */host/conf/dir* directory:

- **APM**: [DDTrace](../integrations/ddtrace.md)/[OpenTelemetry](../integrations/opentelemetry.md) collectors
- **Prometheus exporter**: In the current Docker environment, some application containers expose their own metrics (usually in the form of `http://ip:9100/metrics`). We can expose these ports and write [*prom.conf*](../integrations/prom.md) to collect these metrics
- **Log collection**: If some Docker containers write logs to a specific directory on the host, we can write [log collection configurations](../integrations/logging.md#config) to collect these files. However, we need to mount these directories from the host into the Datakit container using `-v`. Additionally, the default enabled `container` collector automatically collects stdout logs from all containers

After starting the container, you can check the status of Datakit directly on the host by executing the following command:

```shell
docker exec -it <container name or container ID> datakit monitor
```

You can also enter the container to view more information:

```shell
docker exec -it <container name or container ID> /bin/bash
```

## Container Collector Configuration {#input-container}

The container collector is started by default. If additional configuration is needed for the container collector, it can be configured separately. The container collector supports adjusting its behavior via *.conf* files and ENV variables:

- Configure the container collector separately in the */host/conf/dir* directory [here](../integrations/container.md#config), and make sure to remove `container` from the `ENV_DEFAULT_ENABLED_INPUTS` list.
- Add additional environment variable configurations in the Docker startup command; refer to [this section](../integrations/container.md#__tabbed_1_2)

## Disk Cache {#wal}

Datakit defaults to enabling [WAL to cache unsent data](datakit-conf.md#dataway-wal). Without specifying additional host storage, these unsent data will be discarded when the Datakit container is destroyed. We can mount an additional directory from the host to save this data, preventing data loss when the container is rebuilt:

```shell hl_lines="4"
sudo docker run \
    --hostname "$(hostname)" \
    --workdir /usr/local/datakit \
    -v "<YOUR-HOST-DIR-FOR-WAL-CACHE>":"/usr/local/datakit/cache/dw-wal" \
    ...
```
