---
title     : 'DDTrace Extension'
summary   : 'Guance extends DDTrace support for components'
__int_icon: 'icon/ddtrace'
tags      :
  - 'DDTRACE'
  - 'Trace Analysis'
---

## Introduction {#intro}

This section mainly introduces some extended features of DDTrace-Java. The main feature list includes:

- `JDBC SQL` obfuscation
- `xxl-jobs` support
- `Dubbo 2/3` support
- `Thrift` framework support
- `RocketMQ` support
- `Log Pattern` customization
- Alibaba RPC framework `HSF` probe support
- Alibaba Cloud `RocketMQ` 5.0 support
- Additional parameters for Redis tracing
- Retrieval of specific function input parameters
- Support for `MongoDB` obfuscation
- Support for domestic Dameng database
- [Support for 128-bit trace-id](ddtrace-128-trace-id.md){:target="_blank"}
- Support for `PowerJob` framework
- Support for `Apache Pulsar` message queue
- Support for adding trace ID to response headers
- Support for adding request header information `Header` to trace tags
- Support for adding request body `Response Body` to trace tags
- Support for adding request body `Request Body` to trace tags
- HTTP 4xx related traces are set as error, enable parameter: `-Ddd.http.error.enabled=true`
- Support for `Mybatis-plus:batch` usage.
- Redis cluster support for obtaining peer_ip

## Adding Response and Request Body Information to Trace Data {#response_body}

Enable parameter: `-Ddd.trace.response.body.enabled=true` corresponding environment variable is `DD_TRACE_RESPONSE_BODY_ENABLED=true`, default value is `false`.

Enable parameter: `-Ddd.trace.request.body.enabled=true` corresponding environment variable is `DD_TRACE_REQUEST_BODY_ENABLED=true`, default value is `false`.

Since retrieving `response body` can disrupt the `response`, the default encoding for `response body` is `utf-8`. If adjustment is needed, use `-Ddd.trace.response.body.encoding=gbk`.

Retrieving the response body requires reading the response stream, which consumes Java memory space. It is recommended to add URLs with large response bodies (such as file download interfaces) to a blacklist to prevent OOM. URLs on the blacklist will not parse the response body content.
Blacklist configuration:

- Parameter method

> -Ddd.trace.response.body.blacklist.urls="/auth,/download/file"

- Environment variable method

> DD_TRACE_RESPONSE_BODY_BLACKLIST_URLS


## Adding HTTP Header Information to Trace Data {#trace_header}

The trace details will include request and response header information in the tags. By default, this feature is disabled. To enable it, add the startup parameter `-Ddd.trace.headers.enabled=true`. After enabling, you can see the request header information in `servlet_request_header` and response header information in `servlet_response_header` in the trace details.

Minimum supported DDTrace version: [v1.25.2](ddtrace-ext-changelog.md#cl-1.25.2-guance)

## MongoDB Database Obfuscation Support {#mongo-obfuscation}
Use startup parameter `-Ddd.mongo.obfuscation=true` or environment variable `DD_MONGO_OBFUSCATION=TRUE` to enable obfuscation. This allows viewing specific commands from Guance.

Currently supported obfuscation types: Int32/Int64/Boolean/Double/String. Other types are not meaningful and are not supported.

Supported versions:

- [x] all

Minimum supported DDTrace version: [v1.12.1](ddtrace-ext-changelog.md#cl-1.12.1-guance)

## Domestic Dameng Database Support {#dameng-db}
Supported versions:

- [x] v8

Minimum supported DDTrace version: [v1.12.1](ddtrace-ext-changelog.md#cl-1.12.1-guance)

## Retrieving Specific Function Input Parameters {#dd-trace-methods}

Specific functions refer to business-defined functions to retrieve corresponding input parameters. These functions need to be defined through specific parameters. Currently, DDTrace provides two ways to declare specific functions for tracing:

1. Using startup parameter `-Ddd.trace.methods` or by introducing SDK using `@Trace` annotation, refer to [Class or Method Injection Trace](<<< homepage >>>/best-practices/insight/ddtrace-skill-param/#trace){:target="_blank"}

After declaring via the above methods, the corresponding methods will be marked for tracing, generating corresponding Span information that includes function (method) input parameters (parameter name, type, value).

<!-- markdownlint-disable MD046 -->
???+ attention

    Since data type conversion and JSON serialization require additional dependencies and overhead, only `toString()` processing is currently performed on parameter values, and the result of `toString()` is further processed. Field value lengths cannot exceed 1024 characters, and any excess part is discarded.
<!-- markdownlint-enable -->

## Default Remote Port for DDTrace Agent {#agent-port}

DDTrace secondary development changes the default remote port from 8126 to 9529.

## Viewing Parameters in Redis Traces {#redis-command-args}

In Redis traces, the Resource only shows `redis.command` information and does not display parameter (args) information. To view parameters in each statement, enable this feature.

To enable this feature, add the following environment variable to the startup command:

```shell
-Ddd.redis.command.args=true
```

For k8s:

```shell
DD_REDIS_COMMAND_ARGS=TRUE
```

In the detailed trace information on Guance, an additional Tag will be added: `redis.command.args=key val...`. Here, `key val ...` corresponds to the parameters in the Redis command `jedis.set(key,val)`.

> Note: `val` may contain sensitive information, so be cautious when enabling this feature.

Supported versions:

- [x] Jedis 1.4.0 and above
- [x] Lettuce
- [x] Redisson

Minimum supported DDTrace version: [v1.3.2](ddtrace-ext-changelog.md#cl-1.3.2)

## Customizable Log Pattern {#log-pattern}

By modifying the default log pattern, application logs can be correlated with trace data, reducing deployment costs. Currently supports the Log4j2 logging framework, but not Logback.

Adjust the default Pattern using `-Ddd.logs.pattern`:

``` not-set
-Ddd.logs.pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger - %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n"`
```

Supported versions:

- [x] log4j2

Minimum supported DDTrace version: [v1.3.0](ddtrace-ext-changelog.md#cl-1.3.0)

## HSF {#hsf}

[HSF](https://help.aliyun.com/document_detail/100087.html){:target="_blank"} is a widely used distributed RPC service framework at Alibaba.

Supported versions:

- [x] 2.2.8.2--2019-06-stable

Minimum supported DDTrace version: [v1.3.0](ddtrace-ext-changelog.md#cl-1.3.0)

## SQL Obfuscation {#jdbc-sql-obfuscation}

DDTrace defaults to converting SQL parameters to `?`, making it difficult for users to get accurate information when troubleshooting. The new probe extracts placeholder parameters separately into Trace data as Key-Value pairs, making it easier for users to view.

To enable this feature, add the following command-line parameter to the Java startup command:

```shell
# Add parameter during ddtrace startup, default is false
-Ddd.jdbc.sql.obfuscation=true
```

### Effect Example {#show}

Using `setString()` as an example. The new probe position is at `java.sql.PreparedStatement/setString(key, value)`.

There are two parameters here; the first is the placeholder parameter index (starting from 1), and the second is a string type. After calling the `setString(index, value)` method, the corresponding string value is stored in the span.

After executing the SQL, this map is filled into the Span. The final data structure format is as follows:

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
???+ question "Why are they not filled into `db.sql.origin`?"

    This meta information is intended for developers to debug the actual SQL statements. After getting the placeholder parameter details, replacing `?` in `db.sql.origin` theoretically fills in the placeholder parameter values. However, string replacement (rather than precise SQL parsing) may lead to incorrect replacements, so **the original SQL is retained**, and placeholder parameter details are listed separately. Here, `index_1` indicates the first placeholder parameter, and so on.
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

RocketMQ is an open-source message queue framework contributed by Alibaba Cloud to the Apache Foundation. Note: Alibaba Cloud RocketMQ 5.0 and Apache Foundation's RocketMQ are two different libraries.

When referencing libraries, there are differences: `apache rocketmq artifactId: rocketmq-client`, while Alibaba Cloud RocketMQ 5.0 has `artifactId: rocketmq-client-java`.

Version support: Currently supports version 4.8.0 and above. Alibaba Cloud RocketMQ service supports version 5.0 and above.

## Thrift Support {#thrift}

Thrift is an Apache project. Some customers use thrift RPC for communication in their projects, so we have provided support.

Supported versions:

- [x] Version 0.9.3 and above

## Batch Injection of DDTrace-Java Agent {#java-attach}

The native DDTrace-Java batch injection method has certain limitations, such as not supporting dynamic parameter injection (e.g., `-Ddd.agent=xxx, -Ddd.agent.port=yyy`).

The extended DDTrace-Java adds dynamic parameter injection functionality. For specific usage, refer to [here](ddtrace-attach.md){:target="_blank"}
