---
title     : 'DDTrace Extension'
summary   : 'Guance extends the support of DDTrace for components'
__int_icon: 'icon/ddtrace'
tags      :
  - 'DDTRACE'
  - 'Tracing'
---

## Introduction {#intro}

This section introduces some extended features of DDTrace-Java. The main features are listed as follows:

- `JDBC SQL` desensitization function
- Support for `xxl-jobs`
- Support for `Dubbo 2/3`
- Support for `Thrift` framework
- Support for `RocketMQ`
- Customizable `Log Pattern`
- Support for Alibaba RPC framework `HSF` probe
- Support for Alibaba Cloud `RocketMQ` 5.0
- Additional parameters in Redis tracing
- Retrieval of input parameters for specific functions
- Support for `MongoDB` desensitization
- Support for Dameng domestic database
- [Support for 128-bit trace-id](ddtrace-128-trace-id.md){:target="_blank"}
- Support for `PowerJob` framework
- Support for `Apache Pulsar` message queue
- Support for adding trace ID to response headers
- Support for adding request header information `Header` to trace tags
- Support for adding request response body `Response Body` to trace tags
- Support for adding request body `Request Body` to trace tags
- HTTP 4xx related traces are set as error, enable parameter: `-Ddd.http.error.enabled=true`
- Support for `Mybatis-plus:batch` usage.
- Redis cluster support for retrieving peer_ip

## Adding Response, Request Body Information to Trace Data {#response_body}

Enable parameter: `-Ddd.trace.response.body.enabled=true` corresponding environment variable is `DD_TRACE_RESPONSE_BODY_ENABLED=true`, default value is `false`.

Enable parameter: `-Ddd.trace.request.body.enabled=true` corresponding environment variable is `DD_TRACE_REQUEST_BODY_ENABLED=true`, default value is `false`.

Since obtaining the `response body` can cause destruction to the `response`, the encoding of `response body` is adjusted to `utf-8` by default. If adjustment is needed, use `-Ddd.trace.response.body.encoding=gbk`.

The request or response body only collects JSON type data, other data types are not collected.

## Adding HTTP Header Information to Trace Data {#trace_header}

In the trace details, request and response header information will be added to the tags. By default, it is turned off. To enable it, add the parameter `-Ddd.trace.headers.enabled=true` at startup. After enabling, in the trace details, you can see the request header information in `servlet_request_header` and the response header information in `servlet_response_header`.

Minimum supported DDTrace version: [v1.25.2](ddtrace-ext-changelog.md#cl-1.25.2-guance)

## MongoDB Database Desensitization Support {#mongo-obfuscation}
Use startup parameter `-Ddd.mongo.obfuscation=true` or environment variable `DD_MONGO_OBFUSCATION=TRUE` to enable desensitization. This allows a specific command to be seen from Guance.

Currently supported desensitization types include: Int32/Int64/Boolean/Double/String. Other types do not have significant reference value, so they are currently unsupported.

Supported versions:

- [x] all

Minimum supported DDTrace version: [v1.12.1](ddtrace-ext-changelog.md#cl-1.12.1-guance)

## Support for Dameng Domestic Database {#dameng-db}
Supported versions:

- [x] v8

Minimum supported DDTrace version: [v1.12.1](ddtrace-ext-changelog.md#cl-1.12.1-guance)

## Retrieving Input Parameters for Specific Functions {#dd-trace-methods}

Specific functions refer to business-defined functions to retrieve corresponding input parameters. Specific functions need to be defined and declared using specific parameters. Currently, DDTrace provides two ways to declare specific functions for tracing:

1. Using startup parameter `-Ddd.trace.methods` or by introducing SDK with `@Trace` annotation, refer to [Class or Method Injection Trace](https://docs.guance.com/best-practices/insight/ddtrace-skill-param/#trace){:target="_blank"}

After declaring in this manner, the corresponding methods will be marked as traces, generating Span information that includes function (method) input parameters (parameter names, types, values).

<!-- markdownlint-disable MD046 -->
???+ attention

    Since data type conversion and JSON serialization require additional dependencies and overhead, currently only `toString()` processing is done for parameter values, and `toString()` results are processed again. Field value lengths cannot exceed 1024 characters, and any excess part is discarded.
<!-- markdownlint-enable -->

## Default Remote Port for DDTrace Agent {#agent-port}

DDTrace secondary development changes the default remote port from 8126 to 9529.

## Viewing Parameters in Redis Traces {#redis-command-args}

In Redis traces, the Resource only shows `redis.command` information and does not display parameter (args) information. To view parameters in each statement, this feature can be enabled.

To enable this feature, add an environment variable to the startup command:

```shell
-Ddd.redis.command.args=true
```

For k8s:

```shell
DD_REDIS_COMMAND_ARGS=TRUE
```

In the trace details on Guance, a Tag `redis.command.args=key val...` will be added, where `key val ...` corresponds to the parameters in the Redis statement like `jedis.set(key,val)`.

> Note: `val` may involve sensitive information, please use cautiously.

Supported versions:

- [x] Jedis 1.4.0 and above
- [x] Lettuce
- [x] Redisson

Minimum supported DDTrace version: [v1.3.2](ddtrace-ext-changelog.md#cl-1.3.2)

## Log Pattern Customization Support {#log-pattern}

By modifying the default log pattern, application logs and traces can be correlated, reducing deployment costs. Currently supports the Log4j2 logging framework, but not Logback.

Use `-Ddd.logs.pattern` to adjust the default Pattern, for example:

``` not-set
-Ddd.logs.pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger - %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n"`
```

Supported versions:

- [x] log4j2

Minimum supported DDTrace version: [v1.3.0](ddtrace-ext-changelog.md#cl-1.3.0)

## HSF {#hsf}

[HSF](https://help.aliyun.com/document_detail/100087.html){:target="_blank"} is a widely used distributed RPC service framework within Alibaba.

Supported versions:

- [x] 2.2.8.2--2019-06-stable

Minimum supported DDTrace version: [v1.3.0](ddtrace-ext-changelog.md#cl-1.3.0)

## SQL Desensitization {#jdbc-sql-obfuscation}

DDTrace defaults to converting SQL parameters into `?`, which prevents users from obtaining more accurate information when troubleshooting. The new probe extracts placeholder parameters separately as Key-Value pairs in Trace data, making it easier for users to view.

Add the following command-line parameter in the Java startup command to enable this feature:

```shell
# Add parameter during ddtrace startup, default is false
-Ddd.jdbc.sql.obfuscation=true
```

### Effect Example {#show}

Taking `setString()` as an example. The new probe position is at `java.sql.PreparedStatement/setString(key, value)`.

There are two parameters here; the first is the placeholder parameter index (starting from 1), and the second is of string type. After calling the `setString(index, value)` method, the corresponding string value is stored in the span.

After the SQL is executed, this map is populated into the Span. The final data structure format is as follows:

```json hl_lines="17 26 27 28 29 30 31 32"
"meta": {
  "component":
  "java-jdbc-prepared_statement",

  "db.instance":"tmalldemodb",
  "db.operation":"INSERT",

  "db.sql.origin":"INSERT product
      (product_id,
       product_name,
       product_title,
       product_price,
       product_sale_price,
       product_create_date,
       product_isEnabled,
       product_category_id)
      VALUES(null, ?, ?, ?, ?, ?, ?, ?)",

  "db.type":"mysql",
  "db.user":"root",
  "env":"test",
  "peer.hostname":"49.232.153.84",
  "span.kind":"client",
  "thread.name": "http-nio-8080-exec-6",

  "sql.params.index_1":"图书",
  "sql.params.index_2":"十万个为什么",
  "sql.params.index_3":"100.0",
  "sql.params.index_4":"99.0",
  "sql.params.index_5":"2022-11-10 14:08:21",
  "sql.params.index_6":"0",
  "sql.params.index_7":"16"
}
```

<!-- markdownlint-disable MD046 -->
???+ question "Why aren't the placeholders filled into `db.sql.origin`?"

    The meta information is intended for developers to troubleshoot SQL statements. After getting the actual placeholder parameter details, replacing `?` in `db.sql.origin` theoretically fills in the placeholder values. However, string replacement (rather than precise SQL parsing) cannot accurately find the correct replacements (which could lead to incorrect replacements). Therefore, **the original SQL is retained**, and placeholder details are listed separately. Here, `index_1` indicates the first placeholder parameter, and so on.
<!-- markdownlint-enable -->

Minimum supported DDTrace version: [v0.113.0](ddtrace-ext-changelog.md#cl-0.113.0-new)

## xxl-jobs Support {#xxl-jobs}

[xxl-jobs](https://github.com/xuxueli/xxl-job){:target="_blank"} is a distributed task scheduling framework developed in Java.

Supported versions:

- [x] Version 2.3 and above

## Dubbo Support {#dubbo}

Dubbo is an open-source framework from Alibaba Cloud, supporting both Dubbo2 and Dubbo3.

Supported versions:

- [x] Dubbo2: 2.7.0+
- [x] Dubbo3: Full support

## RocketMQ {#rocketmq}

RocketMQ is an open-source message queue framework contributed by Alibaba Cloud to the Apache Foundation. Note: Alibaba Cloud RocketMQ 5.0 is different from the Apache Foundation's library.

Library references differ: `apache rocketmq artifactId: rocketmq-client`, while Alibaba Cloud RocketMQ 5.0 has `artifactId: rocketmq-client-java`

Version support: Currently supports version 4.8.0 and above. Alibaba Cloud RocketMQ service supports version 5.0 and above.

## Thrift Support {#thrift}

Thrift is an Apache project. Some customers use thrift RPC for communication in their projects, so we have provided support.

Supported versions:

- [x] Version 0.9.3 and above

## Batch Injection of DDTrace-Java Agent {#java-attach}

The native batch injection method of DDTrace-Java has certain limitations and does not support dynamic parameter injection (e.g., `-Ddd.agent=xxx, -Ddd.agent.port=yyy`).

The extended DDTrace-Java adds dynamic parameter injection functionality. For specific usage, refer to [here](ddtrace-attach.md){:target="_blank"}