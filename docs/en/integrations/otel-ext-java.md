---
title      : 'OpenTelemetry Extension'
summary    : 'Guance has made additional extensions to the OpenTelemetry plugin'
__int_icon : 'icon/opentelemetry'
tags       :
  - 'OTEL'
  - 'Tracing'
---

> *Author: Longqi Song*

## SQL Obfuscation {#sql-obfuscation}

SQL obfuscation is also narrowly referred to as DB statement cleaning.

According to the official OTEL definition:

```text
The agent cleans all database queries/statements before setting the `db.statement` semantic attribute. All values (strings, numbers) in the query string are replaced with a question mark (?), and the entire SQL statement is formatted (replacing newline characters with spaces, leaving only one space).

Example:

- For the SQL query SELECT a from b where password="secret", it will appear as SELECT a from b where password=?

By default, this behavior is enabled for all database detections. To disable it, use the following properties:

System property: otel.instrumentation.common.db-statement-sanitizer.enabled
Environment variable: OTEL_INSTRUMENTATION_COMMON_DB_STATEMENT_SANITIZER_ENABLED

Default value: true
Description: Enables DB statement cleaning.
```

### Why DB Statement Cleaning Is Necessary {#why}

Most statements include some sensitive data such as usernames, phone numbers, passwords, card numbers, etc. By sanitizing these statements, we can filter out this sensitive data. Another reason is that it facilitates grouping and filtering operations.

There are two ways to write SQL statements:

For example:

```java
ps = conn.prepareStatement("SELECT name,password,id FROM student where name=? and password=?");
ps.setString(1, username);   // Replace the first ?
ps.setString(2, pw);        // Replace the second ?
```

This is the JDBC way of writing, which is database-independent (both Oracle and MySQL are written this way).

The result is that the trace will capture the `db.statement` with two '?' placeholders.

Another less common way:

```java
ps = conn.prepareStatement("SELECT name,password,id FROM student where name='guance' and password='123456'");
// ps.setString(1, username);  No longer using set
// ps.setString(2, pw);
```

In this case, the agent captures the SQL statement without placeholders.

The purpose of `OTEL_INSTRUMENTATION_COMMON_DB_STATEMENT_SANITIZER_ENABLED` is to control this behavior.

The root cause is that the agent's probe is placed on the `prepareStatement` or `Statement` functions.

To fundamentally solve the obfuscation issue, probes need to be added to the `set` methods. Parameters should be cached before `execute()`, and finally, the parameters should be placed into Attributes.

### Guance Extension {#guance-branch}

To obtain the data before obfuscation and the values added via the `set` function, new probes need to be added, along with the environment variable:

```shell
-Dotel.jdbc.sql.obfuscation=true
# or in Kubernetes
OTEL_JDBC_SQL_OBFUSCATION=true
```

Ultimately, the trace details in Guance will look like this:

<!-- markdownlint-disable MD046 MD033 -->
<figure>
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/otel-sql.png" style="height: 500px" alt="Trace Details">
  <figcaption> Trace Details </figcaption>
</figure>

### Common Issues {#question}

1. Enabling `-Dotel.jdbc.sql.obfuscation=true` but not disabling DB statement obfuscation

You may encounter mismatches between placeholders and `origin_sql_x` counts because some parameters have already been replaced by placeholders during DB statement obfuscation.

1. Enabling `-Dotel.jdbc.sql.obfuscation=true` and disabling DB statement obfuscation

If the statement is too long or contains many newline characters, and no formatting is applied, the statement can become messy. This also wastes unnecessary network traffic.

## More {#more}

For other questions, please visit: [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues){:target="_blank"}
