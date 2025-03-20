# OTEL SQL Sanitization
---

> *Author: Song Longqi*

SQL sanitization is also narrowly defined as DB statement cleaning.

According to the official OTEL statement:

```text
The agent cleans all database queries/statements before setting the `db.statement` semantic attribute. All values (strings, numbers) in the query string are replaced with a question mark (?), and the entire SQL statement is formatted (replacing newline characters with spaces, leaving only one space) among other operations.


Example:

- SQL query SELECT a from b where password="secret" will appear in the span as SELECT a from b where password=?

By default, this behavior is enabled for all database detections. Use the following attributes to disable it:

System property: otel.instrumentation.common.db-statement-sanitizer.enabled
Environment variable: OTEL_INSTRUMENTATION_COMMON_DB_STATEMENT_SANITIZER_ENABLED

Default value: true
Explanation: Enables DB statement cleaning.
```

## DB Statement Cleaning and Results {#why}

Most statements include some sensitive data such as usernames, phone numbers, passwords, card numbers, etc. Sensitive data processing can filter out these pieces of information. Another reason is that it facilitates grouping and filtering operations.

There are two ways to write SQL statements:

For example:

```java
ps = conn.prepareStatement("SELECT name,password,id FROM student where name=? and password=?");
ps.setString(1, username);   // set replaces the first ?
ps.setString(2, pw);        // replaces the second ?
```

This is the JDBC writing method, which is database-agnostic (both Oracle and MySQL are written this way).

The result is that the chain captures two '?' in `db.statement`.

A less common alternative writing method:

```java
    ps = conn.prepareStatement("SELECT name,password,id FROM student where name='guance' and password='123456'");
   // ps.setString(1,username);  no longer using set
   // ps.setString(2,pw);
```

In this case, the agent captures the SQL statement without placeholders.

The purpose of `OTEL_INSTRUMENTATION_COMMON_DB_STATEMENT_SANITIZER_ENABLED` is explained here.

The reason is that the agent's probe is on the function `prepareStatement` or `Statement`.


To fundamentally solve the sanitization issue, probes need to be added on `set`. Parameters should be cached before `execute()`, and ultimately, the parameters should be placed into Attributes.

## Guance Secondary Development {#guacne-branch}

To obtain the data before cleaning and the values subsequently added via the `set` function, new instrumentation needs to be performed, along with adding environment variables:

```shell
-Dotel.jdbc.sql.obfuscation=true
# or in k8s 
OTEL_JDBC_SQL_OBFUSCATION=true
```

Ultimately, the trace details in Guance will look like this:

<!-- markdownlint-disable MD046 MD033 -->
<figure >
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/otel-sql.png" style="height: 500px" alt="Trace Details">
  <figcaption> Trace Details </figcaption>
</figure>


## Common Issues {#question}

1. Enabling `-Dotel.jdbc.sql.obfuscation=true` but not disabling DB statement cleaning

    ```text
        Placeholders may not match the number of `origin_sql_x`. This is because some parameters have already been replaced by placeholders during DB statement cleaning.
    ```

2. Enabling `-Dotel.jdbc.sql.obfuscation=true` and disabling DB statement cleaning

 ```text
     If the statement is too long or has many newline characters, and no formatting is applied, the statement will be messy. It will also cause unnecessary traffic waste.
 ```

## More {#more}

For other questions, please visit: [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues){:target="_blank"}