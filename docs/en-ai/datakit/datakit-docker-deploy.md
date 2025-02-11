# Deploy Datakit in Docker
---

This document describes how to install DataKit in Docker.

## Start {#start}

The container start command is as follows:

```shell
sudo docker run \
    --hostname "$(hostname)" \
    --workdir /usr/local/datakit \
    -v "/host/conf/dir":"/usr/local/datakit/conf.d/host-inputs-conf" \
    -v "/":"/rootfs" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e ENV_DATAWAY="https://openway.guance.com?token=<YOUR-WORKSPACE-TOKEN>" \
    -e ENV_DEFAULT_ENABLED_INPUTS='cpu,disk,diskio,mem,swap,system,net,host_processes,hostobject,container,dk' \
    -e ENV_GLOBAL_HOST_TAGS="tag1=a1,tag2=a2" \
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
    pubrepo.guance.com/datakit/datakit:1.66.1
```

Explanation of the startup parameters:

- **`--hostname`** sets the hostname of the host machine as the hostname for Datakit. If you need to run multiple instances of Datakit on the same host, you can add a suffix like `--hostname "$(hostname)-dk1"`
- **`--workdir`** sets the working directory inside the container
- **`-v`**: Mounting various files from the host machine:
    - DataKit has many configuration files that can be prepared on the host machine and mounted into the container at once (the path in the container is *conf.d/host-inputs-conf* directory)
    - The root directory of the host machine is mounted into Datakit to access various information on the host (such as files under the `/proc` directory) which helps the default enabled collectors gather data
    - The *docker.sock* file is mounted into the Datakit container to facilitate data collection by the container collector. The path of this file may differ on different hosts, so it should be configured according to actual conditions
- **`-e`**: Various environment variables for Datakit runtime configuration, these environment variables serve the same purpose as when [deployed with DaemonSet](datakit-daemonset-deploy.md#env-setting)
- **`--publish`**: This allows external systems to send Trace data to the Datakit container. Here we map Datakit's HTTP port to 19529 externally. When setting up addresses for sending trace data, pay attention to this port configuration.
- This running instance of Datakit is set with a CPU limit of 2 cores and 1GiB of memory

If we configure the following collectors in the */host/conf/dir* directory:

- **APM**: Collectors such as [DDTrace](../integrations/ddtrace.md)/[OpenTelemetry](../integrations/opentelemetry.md)
- **Prometheus exporter**: In the current Docker environment, some application containers expose their own metrics (usually in the form of `http://ip:9100/metrics`). We can expose these ports and write [*prom.conf*](../integrations/prom.md) to collect these metrics
- **Log Collection**: If certain Docker containers write logs to a specific directory on the host machine, we can write a [log collection configuration](../integrations/logging.md#config) to collect these files. However, we need to mount these directories into the Datakit container using `-v`. Additionally, the default enabled `container` collector will automatically collect stdout logs from all containers

After starting the container, you can check the status of Datakit directly on the host machine with the following command:

```shell
docker exec -it <container name or ID> datakit monitor
```

You can also enter the container to view more information:

```shell
docker exec -it <container name or ID> /bin/bash
```

## Container Collector Configuration {#input-container}

The container collector starts by default. If you need to make additional configurations for the container collector, you can do so separately. The container collector supports adjustments via *.conf* files and ENV variables:

- Configure the container collector [separately in the */host/conf/dir* directory](../integrations/container.md#config), and ensure that `container` is removed from the `ENV_DEFAULT_ENABLED_INPUTS` list.
- Add extra environment variable configurations in the Docker start command, refer to [here](../integrations/container.md#__tabbed_1_2)