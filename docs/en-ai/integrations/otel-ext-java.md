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

According to the official OTEL documentation:

```text
The agent cleans all database queries/statements before setting the `db.statement` semantic attribute. All values (strings, numbers) in the query string are replaced with a question mark (?), and the entire SQL statement is formatted (replacing newline characters with spaces, ensuring only one space remains) and so on.


Example:

- For the SQL query SELECT a FROM b WHERE password="secret", it will appear in the span as SELECT a FROM b WHERE password=?


By default, this behavior is enabled for all database instrumentation. To disable it, use the following properties:

System property: otel.instrumentation.common.db-statement-sanitizer.enabled
Environment variable: OTEL_INSTRUMENTATION_COMMON_DB_STATEMENT_SANITIZER_ENABLED

Default value: true
Description: Enables DB statement cleaning.
```

### Purpose of DB Statement Cleaning and Results {#why}

Most statements include some sensitive data, such as usernames, phone numbers, passwords, card numbers, etc. By processing these statements, we can filter out this sensitive information. Another reason is to facilitate grouping and filtering operations.

There are two ways to write SQL statements:

For example:

```java
ps = conn.prepareStatement("SELECT name,password,id FROM student WHERE name=? AND password=?");
ps.setString(1, username);   // Replace the first ?
ps.setString(2, pw);        // Replace the second ?
```

This is the JDBC approach, which is database-independent (both Oracle and MySQL are written this way).

The result is that the trace will contain two '?' placeholders in `db.statement`.

A less common alternative approach:

```java
ps = conn.prepareStatement("SELECT name,password,id FROM student WHERE name='guance' AND password='123456'");
// ps.setString(1, username);  No longer using set
// ps.setString(2, pw);
```

In this case, the agent captures the SQL statement without placeholders.

The purpose of `OTEL_INSTRUMENTATION_COMMON_DB_STATEMENT_SANITIZER_ENABLED` is described here.

The root cause is that the agent's probe is placed on the functions `prepareStatement` or `Statement`.

To fundamentally solve the obfuscation issue, probes need to be added to the `set` methods. Parameters should be cached before `execute()`, and finally, the parameters should be placed in Attributes.

### Guance Extension {#guacne-branch}

To capture the data before obfuscation and the values added via the `set` function, new probes need to be added, along with the environment variable:

```shell
-Dotel.jdbc.sql.obfuscation=true
# or for k8s
OTEL_JDBC_SQL_OBFUSCATION=true
```

Ultimately, in the trace details on Guance, it looks like this:

<!-- markdownlint-disable MD046 MD033 -->
<figure>
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/otel-sql.png" style="height: 500px" alt="Trace Details">
  <figcaption> Trace Details </figcaption>
</figure>

### Common Issues {#question}

1. Enabling `-Dotel.jdbc.sql.obfuscation=true` but not disabling DB statement obfuscation

This may result in mismatched placeholders and `origin_sql_x` counts because some parameters have already been replaced by placeholders during DB statement obfuscation.

2. Enabling `-Dotel.jdbc.sql.obfuscation=true` and disabling DB statement obfuscation

If the statement is too long or contains many newline characters, it can become messy without formatting. This also causes unnecessary traffic waste.

## More {#more}

For other questions, please visit: [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues){:target="_blank"}