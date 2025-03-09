---
skip: 'not-searchable-on-index-page'
title: 'DataKit Log Collection Overview'
---

Log data provides a flexible and versatile way to combine information for overall observability. Because of this, compared to Metrics and Tracing, log collection and processing methods are more diverse to adapt to different environments, architectures, and technology stacks.

In general, DataKit supports the following log collection methods:

- [Obtaining logs from disk files](logging.md)
- Collecting container stdout logs
- Remotely pushing logs to DataKit
- [Sidecar-based log collection](logfwd.md)

These various collection methods may have some variations depending on the specific environment, but they generally involve combinations of these few approaches. Below, we will introduce each method in detail.

## Obtaining Logs from Disk Files {#raw-disk-file}

This is the most primitive method of log processing. For developers and traditional log collection solutions, logs are usually initially written directly to disk files. Logs written to disk files have the following characteristics:

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-from-disk.png){ width="300" }
  <figcaption>Extracting logs from disk files</figcaption>
</figure>

- Sequential writing: Most log frameworks ensure that logs in disk files maintain time sequence.
- Automatic slicing: Since disk log files are physically incremental, to prevent logs from filling up the disk, log frameworks typically automatically slice logs or use external scripts to achieve log slicing.

Based on these features, it's easy to see that DataKit only needs to continuously monitor changes in these files (i.e., collect the latest updates). Once logs are written, DataKit can collect them. Its deployment is also simple; you just need to specify the file paths (or wildcard paths) to be collected in the DataKit configuration.

> It is recommended to use wildcard paths (even configure paths that do not exist now but may appear in the future) instead of hardcoding log paths because application logs may not immediately appear (for example, error logs of some applications only appear when an error occurs).

One important point about disk file collection is that it **only collects logs that have been updated since DataKit started**. If the configured log files have not been updated since DataKit started, **historical data will not be collected**.

Due to this characteristic, if log files are continuously updated and DataKit stops in between, **logs during this downtime will not be collected**. Future strategies may address this issue.

## Container Stdout Logs {#container-stdout}

This collection method primarily targets [stdout logs in container environments](container.md). These logs require applications running in containers (or Kubernetes Pods) to output logs to stdout. These stdout logs actually end up on disk on the Node, and DataKit can find the corresponding log files using the container ID and collect them as regular disk files.

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-stdout.png){ width="300" }
  <figcaption>Collecting container stdout logs</figcaption>
</figure>

In the current stdout collection scheme of DataKit (mainly for k8s environments), log collection has the following characteristics:

- Applications deployed in container environments need to build corresponding container images. For DataKit, it can selectively collect logs from certain applications based on image names.

    - By selecting specific image names (or wildcards) in the ConfigMap's container.conf, [targeted collection of stdout logs can be achieved](container-log.md#logging-with-image-config).
    - Annotation marking: [Modifying Pod annotations via Annotations](container-log.md#logging-with-annotation-or-label), DataKit can recognize these special Pods and collect their stdout logs.

A drawback of this strategy is that it requires applications to output logs to stdout. In typical application development, logs are not usually written directly to stdout (although mainstream logging frameworks generally support stdout output). Developers need to adjust log configurations. However, with the increasing popularity of containerized deployment solutions, this method remains a viable log collection approach.

## Remote Push Logs to DataKit {#push}

For remote log pushing, it mainly involves:

- Developers directly [pushing application logs to a specified DataKit service](logging_socket.md), such as [Java's log4j](logging_socket.md#java) and [Python's native `SocketHandler`](logging_socket.md#python) both support sending logs to remote services.

- [Third-party platform log integration](logstreaming.md)

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-remote.png){ width="300" }
  <figcaption>Third-party log integration</figcaption>
</figure>

The key feature of this method is that logs are sent directly to DataKit without being written to disk. Points to note for this type of log collection include:

- For TCP-based log pushing, if the log types (`source/service`) vary, multiple TCP ports need to be opened on DataKit.

> If you want DataKit to open only one (or a few) TCP ports, subsequent [Pipeline](../pipeline/use-pipeline/index.md) processing is required to identify the characteristics of parsed fields and mark them with [`set_tag()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-set-tag) to identify the `service` (currently unable to modify the `source` field, and this feature is supported only in versions [1.2.8 and above](../datakit/changelog.md#cl-1.2.8)).

- For HTTP-based log pushing, developers need to [mark characteristics in HTTP request parameters](logstreaming.md#args) to facilitate subsequent processing by DataKit.

## Sidecar-Based Log Collection {#logfwd-sidecar}

This method combines disk log collection and remote log pushing. Specifically, a Sidecar application ([logfwd](logfwd.md)) is added to the user's Pod, which collects logs as follows:

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-sidecar.png){ width="300" }
  <figcaption>Sidecar-based log collection</figcaption>
</figure>

- Collect logs from disk files using logfwd
- Then logfwd remotely pushes (via WebSocket) the logs to DataKit

This method is currently only usable in k8s environments and has the following characteristics:

- Compared to pure remote log pushing, it can automatically append some k8s attributes of the Pod, such as Pod name and k8s namespace information.
- Developers do not need to change log configurations and can still output logs to disk. In k8s environments, even external storage is not needed; logfwd can directly fetch logs from pod storage (but automatic log slicing must be set up to avoid filling up pod storage).

## Log Processing {#logging-process}

After logs are collected, they all support subsequent Pipeline parsing, but the configuration methods differ slightly:

- Disk log collection: Directly configured in logging.conf, specifying the Pipeline name.
- Container stdout log collection: **Cannot configure Pipeline in container.conf**, as this handles logs from all containers, making it difficult to use a generic Pipeline for all logs. Therefore, it must be configured via Annotations, [specifying the Pipeline configuration for related Pods](container-log.md#logging-with-annotation-or-label).
- Remote log collection: For TCP/UDP transmission, Pipeline configuration can be specified in logging.conf. For HTTP transmission, developers need to [configure Pipeline in HTTP request parameters](logstreaming.md#args).
- Sidecar log collection: Configure the Pipeline for the host Pod in [logfwd configuration](logfwd.md#config), which is essentially similar to container stdout, involving targeted marking of Pods.

## General Additional Options for Log Collection {#other-options-common}

All log collection methods, regardless of the specific collection method used, support the following collection configurations in addition to the Pipeline parsing mentioned above:

- Multi-line parsing: Most logs are single-line, but some logs are multi-line, such as stack trace logs and special application logs (e.g., MySQL slow logs).
- Encoding: Final logs need to be converted to UTF8 storage. For some Windows logs, encoding and decoding processing may be necessary.

## Summary {#summary}

The above provides an overview of DataKit's current log collection methods. Overall, these methods cover most mainstream log data scenarios. As software technology continues to evolve, new forms of log data will emerge, and DataKit will make corresponding adjustments to adapt to new scenarios.