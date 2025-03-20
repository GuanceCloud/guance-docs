---
title      : 'OpenTelemetry Extensions'
summary    : '<<< custom_key.brand_name >>> has made additional extensions to the OpenTelemetry plugin'
__int_icon : 'icon/opentelemetry'
tags       :
  - 'OTEL'
  - 'APM'
---

> *Author: Song Longqi*

## SQL Obfuscation {#sql-obfuscation}

SQL Obfuscation is also narrowly defined as DB statement cleaning.

According to the official OTEL statement:

```text
The agent cleans all database queries/statements before setting the `db.statement` semantic attribute. All values (strings, numbers) in the query string are replaced with a question mark (?), and the entire SQL is formatted (newlines are replaced with spaces, leaving only one space) etc.


Example:

- SQL Query SELECT a from b where password="secret" will appear in the span as SELECT a from b where password=?


By default, this behavior is enabled for all database detections. Use the following attributes to disable it:

System property: otel.instrumentation.common.db-statement-sanitizer.enabled
Environment variable: OTEL_INSTRUMENTATION_COMMON_DB_STATEMENT_SANITIZER_ENABLED

Default value: true
Description: Enables DB statement cleaning.
```

### DB Statement Cleaning and Results {#why}

Most statements include some sensitive data such as usernames, phone numbers, passwords, card numbers, etc. Sensitive processing can filter out these data. Another reason is to facilitate grouping and filtering operations.

There are two ways to write SQL statements:

For example:

```java
ps = conn.prepareStatement("SELECT name,password,id FROM student where name=? and password=?");
ps.setString(1,username);   // set replaces the first ?
ps.setString(2,pw);        // replace the second ?
```

This is the JDBC way of writing, library-agnostic (both Oracle and MySQL are written this way).

The result is that what is captured in the trace is the `db.statement` with two '?'.

A less common way of writing:

```java
    ps = conn.prepareStatement("SELECT name,password,id FROM student where name='guance' and password='123456'");
   // ps.setString(1,username); No longer using set
   // ps.setString(2,pw);
```

In this case, the agent captures the SQL statement without placeholders.

The purpose of `OTEL_INSTRUMENTATION_COMMON_DB_STATEMENT_SANITIZER_ENABLED` mentioned above is related to this.

The reason is that the agent's probe is on the function `prepareStatement` or `Statement`.


To fundamentally solve the obfuscation issue, probes need to be added on `set`. Parameters should be cached before `execute()`, and ultimately placed in Attributes.

### <<< custom_key.brand_name >>> Extensions {#guacne-branch}

To obtain the data before obfuscation and the values subsequently added via the `set` function, new instrumentation needs to be performed, and an environment variable must be added:

```shell
-Dotel.jdbc.sql.obfuscation=true
# or for k8s 
OTEL_JDBC_SQL_OBFUSCATION=true
```

Ultimately, in the trace details on <<< custom_key.brand_name >>>, it looks like this:

<!-- markdownlint-disable MD046 MD033 -->
<figure >
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/otel-sql.png" style="height: 500px" alt="Trace Details">
  <figcaption> Trace Details </figcaption>
</figure>

### Common Issues {#question}

1. Enabling `-Dotel.jdbc.sql.obfuscation=true` but not turning off DB statement obfuscation

This may result in a mismatch between placeholders and `origin_sql_x` quantities because some parameters have already been replaced by placeholders during DB statement obfuscation.

1. Enabling `-Dotel.jdbc.sql.obfuscation=true` and turning off DB statement obfuscation

If the statement is too long or contains many newline characters, and no formatting is performed, the statement will be very messy. It will also waste unnecessary traffic.

## More {#more}

For other questions, please go to: [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues){:target="_blank"}