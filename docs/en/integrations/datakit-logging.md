---
skip: 'not-searchable-on-index-page'
title: 'DataKit Log Collection Overview'
---

Log data provides a flexible and varied way of combining information for overall observability. For this reason, compared to Metrics and Tracing, there are more collection and processing schemes for logs to adapt to different environments, architectures, and technology stacks.

In general, DataKit has the following log collection methods:

- [Obtaining logs from disk files](logging.md)
- Collecting container stdout logs
- Remotely pushing logs to DataKit
- [Sidecar form of log collection](logfwd.md)

All these various collection methods may have some variations depending on specific environments, but in general, they are combinations of these few methods. Below, we will introduce them one by one.

## Obtaining Logs from Disk Files {#raw-disk-file}

This is the most primitive method of log processing. Whether it's for developers or traditional log collection solutions, logs usually start by being directly written to disk files. Logs written to disk files have the following characteristics:

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-from-disk.png){ width="300" }
  <figcaption>Extracting logs from disk files</figcaption>
</figure>

- Sequential writing: Most log frameworks can ensure that logs in disk files maintain time sequence.
- Automatic slicing: Since disk log files are physically incremental, to avoid filling up the disk with logs, most log frameworks automatically cut logs, or achieve log cutting through some external resident scripts.

Based on the above features, it's easy to think that DataKit only needs to continuously monitor changes in these files (i.e., collect the latest updates). Once logs are written, DataKit can collect them, and its deployment is very simple; you just need to fill in the file paths (or wildcard paths) to be collected in the conf of the log collector.

> Here, it is recommended to use wildcard paths (even configure paths that do not currently exist but will appear in the future), rather than hardcoding the log path, because application logs may not immediately appear (for example, error logs for some applications only appear when an error occurs).

One thing to note about disk file collection is that it **only collects log files updated since DataKit was started**, if the configured log files (since DataKit was started) have not been updated, their **historical data will not be collected**.

Because of this characteristic, if the log file continues to update and DataKit stops in between, **logs during this downtime period will not be collected**, and later we may implement some strategies to alleviate this issue.

## Container Stdout Logs {#container-stdout}

This collection method mainly targets [stdout logs in container environments](container.md). These logs require applications running in containers (or Kubernetes Pods) to output logs to stdout. These stdout logs actually get written to disk on the Node, and DataKit can find the corresponding log files via the container ID, then collect them as ordinary disk files.

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-stdout.png){ width="300" }
  <figcaption>Collecting container stdout logs</figcaption>
</figure>

In DataKit's existing stdout collection scheme (mainly targeting k8s environments), log collection has the following features:

- Since applications deployed in container environments all need to build corresponding container images, DataKit can selectively collect logs for certain applications based on image names.

    - By selecting partial image names in the ConfigMap's container.conf (or their wildcards) to pinpoint collect stdout logs.
    - Stain marking: [Modify Pod annotations through Annotations](container-log.md#logging-with-annotation-or-label), DataKit can recognize these special Pods and thus collect their stdout logs.

This is also a drawback of this strategy, which requires applications to output logs to stdout. In general application development, logs aren't often written directly to stdout (but mainstream log frameworks generally support outputting to stdout), requiring developers to adjust log configurations. However, with the increasing popularity of containerized deployment schemes, this is still a viable log collection method.

## Remote Push Logs to DataKit {#push}

For remote log pushing, it mainly involves

- Developers directly [sending application logs to the specified service on DataKit](logging_socket.md), such as [Java's log4j](logging_socket.md#java) and [Python's native `SocketHandler`](logging_socket.md#python) both support sending logs to remote services.

- [Third-party platform log integration](logstreaming.md)

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-remote.png){ width="300" }
  <figcaption>Third-party log integration</figcaption>
</figure>

The feature of this form is that logs are sent directly to DataKit without intermediate disk writing. For this type of log collection, the following points should be noted:

- For TCP-based log pushing, if the log type (`source/service`) varies, multiple TCP ports need to be opened on DataKit.

> If you want DataKit to open only one (or a few) TCP ports, then subsequent [Pipeline](../pipeline/use-pipeline/index.md) processing is required to identify the characteristics of the fields split out and mark the `service` using the function [`set_tag()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-set-tag) (currently unable to modify the `source` field of logs, and this feature is only supported in versions [1.2.8 and above](../datakit/changelog.md#cl-1.2.8)).

- For HTTP-based log pushing, developers need to [mark characteristics in the HTTP request parameters](logstreaming.md#args) to facilitate subsequent processing by DataKit.

## Sidecar Form Log Collection {#logfwd-sidecar}

This method of collection is essentially a combination of disk log collection and remote log pushing. Specifically, it involves adding a Sidecar application ([logfwd](logfwd.md)) that is paired with DataKit in the user's Pod, and its collection method is as follows:

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-logging-sidecar.png){ width="300" }
  <figcaption>Sidecar form log collection</figcaption>
</figure>

- Obtain logs via logfwd using disk files.
- Then logfwd remotely pushes (via WebSocket) the logs to DataKit.

This method can currently only be used in k8s environments and has the following features:

- Compared to pure remote log pushing, it can automatically append some k8s Pod attribute fields, such as Pod name and k8s namespace information.
- Developers do not need to modify log configurations and can still output logs to disk. Even in k8s environments, external storage does not need to be attached, and logfwd can directly fetch logs from pod internal storage and push them out (but automatic log cutting must be done to avoid filling up pod storage).

## Log Processing {#logging-process}

After the above logs are collected, they all support subsequent Pipeline parsing, but the configuration forms differ slightly:

- Disk log collection: Directly configured in logging.conf, where the Pipeline name is specified.
- Container stdout log collection: **Pipeline cannot be configured in container.conf**, because here it targets all container log collections, making it difficult to handle all logs with a universal Pipeline. Therefore, Pipeline configuration for related Pods must be specified via Annotation [in the container-log section](container-log.md#logging-with-annotation-or-label).
- Remote log collection: For TCP/UDP transmission methods, Pipeline configuration can also be specified in logging.conf. For HTTP transmission methods, developers need to [configure Pipeline via HTTP request parameters](logstreaming.md#args).
- Sidecar log collection: In [logfwd's configuration](logfwd.md#config), configure the host Pod's Pipeline. Essentially, this is similar to container stdout, both involving targeted marking for Pods.

## Common Additional Options for Log Collection {#other-options-common}

Regardless of the collection method used, all log collections, besides the aforementioned Pipeline parsing, support the following collection configurations:

- Multi-line parsing: Most logs are single-line logs, but some logs are multi-line, such as stack trace logs, some special application logs (e.g., MySQL slow logs).
- Encoding: The final logs need to be stored in UTF8 format. Some Windows logs may require encoding/decoding handling.

## Summary {#summary}

The above provides an overall introduction to DataKit's current log collection solutions. Generally speaking, these current solutions basically cover mainstream log data scenarios. As software technology continues to iterate, new forms of log data will continue to emerge, and at that time, DataKit will also make corresponding adjustments to adapt to new scenarios.