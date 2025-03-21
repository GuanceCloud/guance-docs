---
title     : 'DDTrace Extension'
summary   : '<<< custom_key.brand_name >>> extends the support of DDTrace for components'
__int_icon: 'icon/ddtrace'
tags      :
  - 'DDTRACE'
  - 'APM'
---

## Introduction {#intro}

This section mainly introduces some extended features of DDTrace-Java. Main feature list:
- JDBC SQL obfuscation
- xxl-jobs
- Dubbo 2/3
- Thrift
- RocketMQ
- log pattern
- hsf
- Support Alibaba Cloud RocketMQ 5.0
- redis trace parameters
- Get the input parameter information of a specific function
- MongoDB obfuscation
- Supported DM8 Database
- Supported Apache Pulsar MQ
- Support placing `trace_id` in the response header
- Support putting the requested header information into the span tags
- Support add HTTP `Response Body` information in the trace data
- Support add HTTP `Request Body` information in the trace data
- Use `-Ddd.http.error.enabled=true` to change the HTTP 4xx request link status to error
- Support `Mybatis-plus:batch`
- Support Redis tag:peer_ip

## Adding Response, Request Body Information in Trace Data {#response_body}

Activation parameter: `-Ddd.trace.response.body.enabled=true`, corresponding environment variable `DD_TRACE_RESPONSE_BODY_ENABLED=true`, default value is `false`.

Activation parameter: `-Ddd.trace.request.body.enabled=true`, corresponding environment variable `DD_TRACE_REQUEST_BODY_ENABLED=true`, default value is `false`.

Since obtaining the `response body` can disrupt the `response`, the default encoding adjustment for `response body` is set to `utf-8`. If you need to adjust it, use `-Ddd.trace.response.body.encoding=gbk`.

Obtaining the response body requires reading the response stream, which will consume some Java memory space. It is recommended to add blacklist processing for requests with larger response bodies (such as file download interfaces) to prevent OOM. URLs on the blacklist will no longer parse the response body content.
Blacklist configuration as follows:

- Parameter method

> -Ddd.trace.response.body.blacklist.urls="/auth,/download/file"

- Environment variable method

> DD_TRACE_RESPONSE_BODY_BLACKLIST_URLS


## Adding HTTP Header Information in Trace Data {#trace_header}

The details of the trace will place the request and response header information into tags. By default, it is turned off. To enable it, add the parameter `-Ddd.trace.headers.enabled=true` when starting, after enabling, you can see the request header information in `servlet_request_header` and the response header information in `servlet_response_header` in the trace details.

Minimum supported DDTrace version: [v1.25.2](ddtrace-ext-changelog.md#cl-1.25.2-guance)

## Supporting MongoDB Database Desensitization {#mongo-obfuscation}
Activate desensitization using startup parameter `-Ddd.mongo.obfuscation=true` or environment variable `DD_MONGO_OBFUSCATION=TRUE`. This allows you to see a specific command from <<< custom_key.brand_name >>>.

Currently supported desensitization types include: Int32/Int64/Boolean/Double/String. Remaining types are not currently supported as they have no reference significance.

Supported versions:

- [x] all

Minimum supported DDTrace version: [v1.12.1](ddtrace-ext-changelog.md#cl-1.12.1-guance)

## Supporting Dameng Domestic Database {#dameng-db}
Supported versions:

- [x] v8

Minimum supported DDTrace version: [v1.12.1](ddtrace-ext-changelog.md#cl-1.12.1-guance)

## Obtaining Input Parameter Information for Specific Functions {#dd-trace-methods}

Specific functions refer to business-specified functions to obtain corresponding input parameter situations. Specific functions need to be defined by specific parameters. Currently, DDTrace provides two ways to declare specific functions for tracing:

1. Through startup parameter marking `-Ddd.trace.methods`, or through introducing SDK, using `@Trace` for marking, refer to [Class or Method Injection Trace](<<< homepage >>>/best-practices/insight/ddtrace-skill-param/#trace){:target="_blank"}

After declaring via the above methods, the corresponding methods will be marked as traceable, generating corresponding Span information that includes the input parameter information (parameter name, type, value) of the function (method).

<!-- markdownlint-disable MD046 -->
???+ attention

    Since data types cannot be converted and JSON serialization requires additional dependencies and overhead, currently only `toString()` processing is done for parameter values, and secondary processing is performed on the `toString()` results, where field value length cannot exceed 1024 characters. Values exceeding this limit are discarded.
<!-- markdownlint-enable -->

## DDTrace Agent Default Remote Port {#agent-port}

DDTrace secondary development changes the default remote port from 8126 to 9529.

## Viewing Parameters in Redis Traces {#redis-command-args}

In Redis traces, the Resource will only display `redis.command` information and will not show parameter (args) information. If you want to view the parameters in each statement, you can activate this feature.

Activate this feature by adding an environment variable to the startup command:

```shell
-Ddd.redis.command.args=true
```

For k8s:

```shell
DD_REDIS_COMMAND_ARGS=TRUE
```

In the detailed view of the <<< custom_key.brand_name >>> trace, an additional Tag will appear: `redis.command.args=key val...`. Here `key val ...` corresponds to the parameters in the redis statement `jedis.set(key,val)`.

> Note: The val may involve some confidential information, so please be cautious when activating.

Supported versions:

- [x] Jedis 1.4.0 and above
- [x] Lettuce
- [x] Redisson

Minimum supported DDTrace version: [v1.3.2](ddtrace-ext-changelog.md#cl-1.3.2)

## Log Pattern Customization Support {#log-pattern}

By modifying the default log pattern, application logs and traces can be interrelated, reducing deployment costs. Currently supports the Log4j2 logging framework, Logback is not yet supported.

Adjust the default Pattern using `-Ddd.logs.pattern`, for example:

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

## SQL Desensitization {#jdbc-sql-obfuscation}

DDTrace by default converts SQL parameters to `?`, making it difficult for users to get more accurate information when troubleshooting. The new probe extracts placeholder parameters separately in Key-Value format into Trace data for user viewing.

Add the following command-line parameter in the Java startup command to activate this feature:

```shell
# Add parameter during ddtrace startup, default is false
-Ddd.jdbc.sql.obfuscation=true
```

### Example Effect {#show}

Using `setString()` as an example. The added probe location is at `java.sql.PreparedStatement/setString(key, value)`.

There are two parameters here; the first one is the placeholder parameter index (starting from 1), and the second is of string type. After calling the `setString(index, value)` method, the corresponding string value will be stored in the span.

After the SQL is executed, this map will be filled into the Span. The final data structure format is shown below:

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

  "sql.params.index_1":"Book",
  "sql.params.index_2":"Why?",
  "sql.params.index_3":"100.0",
  "sql.params.index_4":"99.0",
  "sql.params.index_5":"2022-11-10 14:08:21",
  "sql.params.index_6":"0",
  "sql.params.index_7":"16"
}
```

<!-- markdownlint-disable MD046 -->
???+ question "Why isn't it filled into `db.sql.origin`?"

    This meta information is actually intended for relevant developers to troubleshoot the actual SQL statement content. After getting the detailed placeholder parameters, replacing the `?` in `db.sql.origin` theoretically could fill in the placeholder parameter values, but string replacement (instead of precise SQL parsing) cannot accurately find the correct replacements (which might lead to incorrect replacements). Therefore, we **try to preserve the original SQL** and list the placeholder parameter details separately. Here `index_1` indicates the first placeholder parameter, and so on.
<!-- markdownlint-enable -->

Minimum supported DDTrace version: [v0.113.0](ddtrace-ext-changelog.md#cl-0.113.0-new)

## xxl-jobs Support {#xxl-jobs}

[xxl-jobs](https://github.com/xuxueli/xxl-job){:target="_blank"} is a distributed task scheduling framework developed in Java.

Supported versions:

- [x] 2.3 and above versions

## Dubbo Support {#dubbo}

Dubbo is an open-source framework from Alibaba Cloud, currently supporting Dubbo2 and Dubbo3.

Supported versions:

- [x] Dubbo2: 2.7.0+
- [x] Dubbo3: Fully supported

## RocketMQ {#rocketmq}

RocketMQ is an open-source message queue framework contributed by Alibaba Cloud to the Apache Foundation. Note: Alibaba Cloud RocketMQ 5.0 and the Apache Foundation's are two different libraries.

Referencing libraries differs: `apache rocketmq artifactId: rocketmq-client`, while Alibaba Cloud RocketMQ 5.0 has `artifactId: rocketmq-client-java`

Version support: Currently supports 4.8.0 and above versions. Alibaba Cloud RocketMQ service supports 5.0 and above.

## Thrift Support {#thrift}

Thrift belongs to the Apache project. Some customers use thrift RPC for communication in their projects, so we provide support.

Supported versions:

- [x] 0.9.3 and above versions

## Batch Injection of DDTrace-Java Agent {#java-attach}

The native DDTrace-Java batch injection method has certain defects, not supporting dynamic parameter injection (for example, `-Ddd.agent=xxx, -Ddd.agent.port=yyy` etc.).

The extended DDTrace-Java adds the dynamic parameter injection function. For specific usage, refer to [here](ddtrace-attach.md){:target="_blank"}