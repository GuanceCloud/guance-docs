# Deploying Datakit in Docker
---

This document describes how to install DataKit in Docker.

## Start {#start}

The container startup command is as follows:

> The following `<XXX-YYY-ZZZ>` content must be filled out according to the actual situation.

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
    -e HOST_ROOT="/rootfs" \
    --cpus 2 \
    --memory 1g \
    --privileged \
    --publish 19529:9529 \
    -d \
    pubrepo.guance.com/datakit/datakit:1.69.1
```

Explanation of startup parameters:

- **`--hostname`** sets the hostname of the host machine as the hostname for Datakit's operation. If multiple Datakits need to run on the current host machine, you can add appropriate suffixes like `--hostname "$(hostname)-dk1"`
- **`--workdir`** sets the working directory of the container
- **`-v`**: Various host file mounts:
    - DataKit has many configuration files that can be prepared on the host machine and mounted into the container all at once via `-v` (the path in the container is *conf.d/host-inputs-conf* directory)
    - Here, the root directory of the host is mounted into Datakit to access various information on the host (such as various files under the `/proc` directory), which facilitates data collection by default collectors.
    - Mount the *docker.sock* file into the Datakit container to facilitate data collection by the container collector. The location of this file may vary depending on the host, so it needs to be configured accordingly.
- **`-e`**: Various environment variable configurations for Datakit during runtime, these environment variables have the same functionality as when [DaemonSet deployment](datakit-daemonset-deploy.md#env-setting) occurs.
- **`--publish`**: Facilitates external systems sending Trace data to the Datakit container. Here we map the HTTP port of Datakit to 19529 externally. When setting the address for trace data, pay attention to this port setting.
- This running Datakit instance is set with a CPU limit of 2 cores and a memory limit of 1GiB.

Suppose we configure the following collectors in the */host/conf/dir* directory:

- **APM**: [DDTrace](../integrations/ddtrace.md)/[OpenTelemetry](../integrations/opentelemetry.md) collectors
- **Prometheus exporter**: In the current Docker environment, some application containers expose their own metrics (generally in the form of `http://ip:9100/metrics`). We can expose these ports and then write [*prom.conf*](../integrations/prom.md) to collect these metrics.
- **Log collection**: If certain Docker containers write logs to a specific directory on the host machine, we can write separate [log collection configurations](../integrations/logging.md#config) to collect these files. However, beforehand, we need to mount these directories from the host machine into the Datakit container using `-v`. Additionally, the default enabled `container` collector will automatically collect stdout logs from all containers.

After the container starts, you can directly execute the following command on the host machine to check the status of Datakit:

```shell
docker exec -it <container name or container ID> datakit monitor
```

You can also enter the container directly to view more information:

```shell
docker exec -it <container name or container ID> /bin/bash
```

## Container Collector Configuration {#input-container}

The container collector mentioned above is started by default. If you want to make additional configurations for the container collector, you can configure it separately. The container collector supports adjustments through both *.conf* files and ENV variables:

- Add an extra [configuration for the container collector](../integrations/container.md#config) in the */host/conf/dir* directory. At the same time, ensure to remove `container` from the `ENV_DEFAULT_ENABLED_INPUTS` list.
- In the Docker startup command, add extra environment variable configurations; see [here](../integrations/container.md#__tabbed_1_2).

## Disk Cache {#wal}

Datakit enables [WAL caching for pending data to be sent](datakit-conf.md#dataway-wal) by default. Without specifying additional storage on the host, if the Datakit container is destroyed, any unsent data will be discarded. You can mount an additional directory from the host machine to store this data, avoiding data loss when the container is rebuilt:

```shell hl_lines="4"
sudo docker run \
    --hostname "$(hostname)" \
    --workdir /usr/local/datakit \
    -v "<YOUR-HOST-DIR-FOR-WAL-CACHE>":"/usr/local/datakit/cache/dw-wal" \
    ...
```