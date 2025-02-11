---
skip: 'not-searchable-on-index-page'
title: 'DataKit Log Collection Overview'
---

Log data provides a flexible and versatile information combination method for overall observability. For this reason, compared to Metrics and Tracing, log collection and processing methods are more diverse, adapting to different environments, architectures, and technology stacks.

In general, DataKit has the following log collection methods:

- [Obtaining logs from disk files](logging.md)
- Collecting container stdout logs
- Remotely pushing logs to DataKit
- [Sidecar-based log collection](logfwd.md)

Each of these collection methods can have variations depending on the specific environment, but they generally involve combinations of these methods. The following sections introduce each method in detail.

## Obtaining Logs from Disk Files {#raw-disk-file}

This is the most primitive log processing method. Whether for developers or traditional log collection solutions, logs initially are usually written directly to disk files. Logs written to disk files have the following characteristics:

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-from-disk.png){ width="300" }
  <figcaption>Extracting logs from disk files</figcaption>
</figure>

- Sequential writing: Most logging frameworks ensure that logs in disk files maintain time sequence.
- Automatic slicing: Since disk log files are physically incremental, to prevent logs from filling up the disk, logging frameworks generally automatically slice logs or use external scripts to achieve log slicing.

Based on these features, DataKit only needs to continuously monitor changes to these files (i.e., collect the latest updates). Once logs are written, DataKit can collect them. Its deployment is also simple; it only requires specifying the file paths (or wildcard paths) to be collected in the collector's configuration file.

> It is recommended to use wildcard paths (even for files that do not currently exist but may appear in the future) instead of hardcoding log paths, as application logs may not immediately appear (for example, some applications' error logs only appear when an error occurs).

Disk file collection has one important note: it **only collects logs updated after DataKit starts**. If the configured log files have not been updated since DataKit started, **historical data will not be collected**.

Due to this characteristic, if log files are continuously updated and DataKit stops in between, **logs during this downtime will not be collected**. Future strategies might be implemented to mitigate this issue.

## Container Stdout Logs {#container-stdout}

This collection method primarily targets [stdout logs in container environments](container.md). These logs require applications running in containers (or Kubernetes Pods) to output logs to stdout. These stdout logs are ultimately written to disk on the Node, and DataKit can find the corresponding log files using the container ID and collect them as ordinary disk files.

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-stdout.png){ width="300" }
  <figcaption>Collecting container stdout logs</figcaption>
</figure>

In DataKit's existing stdout collection solution (mainly for k8s environments), log collection has the following characteristics:

- Applications deployed in container environments need to build corresponding container images. For DataKit, it can selectively collect logs from certain applications based on image names.

    - By selecting partial image names (or wildcards) in the ConfigMap's container.conf, [specific stdout logs can be collected](container-log.md#logging-with-image-config).
    - Labeling: [Modifying Pod annotations or labels via Annotations](container-log.md#logging-with-annotation-or-label) allows DataKit to identify these special Pods and collect their stdout logs.

One drawback of this strategy is that it requires applications to output logs to stdout. In general application development, logs are not typically written directly to stdout (but mainstream logging frameworks generally support stdout output). However, with the increasing popularity of containerized deployment solutions, this method remains a viable log collection approach.

## Remote Push Logs to DataKit {#push}

For remote log pushing, it mainly involves:

- Developers directly [pushing application logs to a specified DataKit service](logging_socket.md), such as [Java's log4j](logging_socket.md#java) and [Python's native `SocketHandler`](logging_socket.md#python), which support sending logs to remote services.

- [Third-party platform log integration](logstreaming.md)

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-remote.png){ width="300" }
  <figcaption>Third-party log integration</figcaption>
</figure>

The key feature of this method is that logs are sent directly to DataKit without needing to land on disk. Points to note for this type of log collection include:

- For TCP-based log pushing, if the log types (`source/service`) vary, multiple TCP ports need to be opened on DataKit.

> If you want DataKit to open only one (or a few) TCP ports, subsequent [Pipeline](../pipeline/use-pipeline/index.md) processing should handle field splitting, identifying characteristics, and using the [`set_tag()` function](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-set-tag) to tag the `service` (currently unable to modify the `source` field of logs, and this feature is supported only in versions [1.2.8 and above](../datakit/changelog.md#cl-1.2.8)).

- For HTTP-based log pushing, developers need to mark characteristics in [HTTP request parameters](logstreaming.md#args) to facilitate subsequent DataKit processing.

## Sidecar-Based Log Collection {#logfwd-sidecar}

This collection method combines disk log collection and remote log pushing. Specifically, it involves adding a companion (i.e., [logfwd](logfwd.md)) Sidecar application to the user's Pod, with the following collection process:

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-sidecar.png){ width="300" }
  <figcaption>Sidecar-based log collection</figcaption>
</figure>

- logfwd first obtains logs from disk files.
- Then logfwd remotely pushes (via WebSocket) the logs to DataKit.

This method is currently only usable in k8s environments and has the following characteristics:

- Compared to pure remote log pushing, it can automatically append some k8s attributes of the Pod, such as Pod name and k8s namespace information.
- Developers do not need to modify log configurations and can still output logs to disk. In k8s environments, even without external storage, logfwd can fetch logs directly from the pod's own storage (but automatic log slicing settings must be done to prevent filling the pod's storage).

## Log Processing {#logging-process}

After collecting logs, all logs support subsequent Pipeline processing, but the configuration forms differ slightly:

- Disk log collection: Directly configure in logging.conf, specifying the Pipeline name.
- Container stdout log collection: **Pipeline cannot be configured in container.conf**, as it targets all container logs, making it difficult to use a universal Pipeline for all logs. Therefore, Pipeline configuration must be specified via Annotation for related Pods [in the annotation or label](container-log.md#logging-with-annotation-or-label).
- Remote log collection: For TCP/UDP transmission, Pipeline configuration can be specified in logging.conf. For HTTP transmission, developers need to configure the Pipeline in [HTTP request parameters](logstreaming.md#args).
- Sidecar log collection: Configure the host Pod's Pipeline in [logfwd's configuration](logfwd.md#config), essentially similar to container stdout, both targeting Pod-specific markings.

## Common Additional Options for Log Collection {#other-options-common}

Regardless of the collection method used, all log collections support the following configurations in addition to the mentioned Pipeline processing:

- Multi-line splitting: Most logs are single-line, but some logs are multi-line, such as stack trace logs or special application logs (e.g., MySQL slow logs).
- Encoding: Final logs need to be converted to UTF8 storage. For some Windows logs, encoding and decoding processing may be required.

## Summary {#summary}

The above overview introduces the current log collection methods of DataKit. Generally speaking, these methods cover most mainstream log data scenarios. As software technology continues to evolve, new log data formats will emerge, and DataKit will adapt accordingly to meet new requirements.