# Insights into MySQL

---

> Author: Liu Rui

As the backbone of business operations, databases influence application architecture and performance. Application service performance can be improved by scaling horizontally, but database performance ultimately determines the fate of the application. MySQL, as the king of databases, is almost universally used across industries. With business growth, improper use of SQL and a large number of slow queries can severely impact application performance, making it crucial to monitor MySQL.

## MySQL Integration

[MySQL Integration Documentation](../../integrations/mysql.md)

## MySQL Monitoring

Monitoring MySQL involves four main areas:

1. Overview
2. Active User Information
3. InnoDB
4. Lock Information

### Overview

The overview section provides a comprehensive analysis of MySQL based on metrics such as connection count, QPS, TPS, abnormal connections, indexless join queries per second, schema size distribution, slow queries, lock wait times, etc.
![image.png](../images/mysql/mysql-1.png)

### Active User Information

Have you ever paid attention to MySQL connections? Let's look at an error first:

```shell
MySQL: ERROR 1040: Too many connections
```

We know that MySQL supports both long and short connections, and establishing a connection incurs significant overhead. Therefore, long connections are generally used. However, using long connections can increase memory usage because MySQL temporarily uses memory to manage connection objects during query execution, which are only released when the connection is closed. If there are too many long connections, it can lead to increased memory usage, causing the system to forcibly kill MySQL services and restart them abnormally.

For this situation with long connections, regular disconnection is necessary. This can be done by estimating whether a connection is persistent based on its memory usage. Additionally, after executing large operations, you can run `mysql_reset_connection` to reinitialize the connection resources.

A MySQL connection typically corresponds to one user request. If a request takes too long to complete, it can cause connection accumulation and quickly exhaust the database's connection pool. This means that if there are long-running SQL queries, they will continue to occupy connections without releasing them. Meanwhile, application requests keep pouring in, leading to rapid exhaustion of database connections.

In cloud-native and microservices environments, the requirements for database connections are higher, so MySQL connections can easily become a bottleneck. The `Too many connections` error can cause the CPU on the MySQL server to spike and also lead to application interruptions due to the inability to obtain more connections. Real-time monitoring can help us quickly identify database bottlenecks and even provide detailed information about each user connection, such as current and cumulative connection counts.

![image.png](../images/mysql/mysql-2.png)

Additionally, we can optimize MySQL based on current connections:

- Increase the maximum number of connections
- Implement master-slave replication with read-write separation
- Split business logic to introduce multiple database instances
- Add or enhance caching to reduce queries
- And more

### InnoDB

Enable InnoDB metrics collection by setting `innodb=true` in `mysql.conf`.

![image.png](../images/mysql/mysql-3.png)

### Lock Information

![image.png](../images/mysql/mysql-4.png)

## MySQL Slow Queries

Slow queries in production systems are a type of failure and risk. Once they occur, they can make the system unavailable, affecting business operations. When there are many slow queries, the slower the SQL executes, the more CPU or IO resources it consumes. Therefore, focusing on slow queries is key to addressing and preventing such issues.

There are currently two ways to optimize slow queries:

1. Enable **slow log** to collect slow query logs and manually execute `EXPLAIN` on slow SQL queries.
2. Use <<< custom_key.brand_name >>> to enable DBM for collecting database performance metrics. It automatically selects some high-latency SQL statements, retrieves their execution plans, and collects various performance metrics during actual execution.

## MySQL Slow Log

### Broad-Sense Slow Queries

We commonly encounter narrow-sense slow queries, i.e., queries that exceed a set time threshold, such as defaulting to 10 seconds. Besides this, other situations can also lead to slow queries and should be marked as such:

- Large result sets.
- Frequent queries without indexes.

### Enabling Slow Query Logs

The following configuration enables slow query logging in MySQL 5.7:

```toml
#### Slow Query Log ####
slow_query_log = 1 ## Enable slow query log
slow_query_log_file = /var/log/mysql/slow.log ## Slow query log file name
long_query_time = 2 ## Record queries taking longer than 2 seconds
# min_examined_row_limit = 100 ## Only record queries examining more than 100 rows
# log-queries-not-using-indexes ## Log queries not using indexes
log_throttle_queries_not_using_indexes = 5 ## Limit logging of non-indexed queries to 5 per minute
log-slow-admin-statements = table ## Log administrative commands like ALTER TABLE
log_output = file ## Log format: FILE | TABLE | NONE (default is FILE; TABLE is not recommended)
log_timestamps = 'system' ## Use system time for timestamps
```

Here, the top 100 slow queries are recorded. To view more slow queries, check the log viewer for additional log information.

![image.png](../images/mysql/mysql-5.png)

## MySQL DBM

Database performance metrics primarily come from MySQL’s built-in `performance_schema`, which provides a way to retrieve server internal execution details at runtime. Through this database, DataKit can collect historical query statistics, execution plans, and other related performance metrics. The collected data is saved as logs with sources `mysql_dbm_metric`, `mysql_dbm_sample`, and `mysql_dbm_activity`.

Enabling DBM allows direct collection of database performance metrics. For collector configuration, refer to [MySQL](/datakit/mysql/#performance-schema).

```toml
[[inputs.mysql]]

# Enable database performance metrics collection
dbm = true

...

# Monitoring metric configuration
[inputs.mysql.dbm_metric]
  enabled = true

# Monitoring sampling configuration
[inputs.mysql.dbm_sample]
  enabled = true

# Waiting event collection
[inputs.mysql.dbm_activity]
  enabled = true   
...

```

### `mysql_dbm_metric` View

By enabling `dbm`, you can analyze current database performance metrics directly in the view: maximum slow query duration, maximum slow insert duration, number of slow query executions, most frequently executed SQL statement, longest lock time, etc.

![image.png](../images/mysql/mysql-6.png)

In the view **[SQL Execution Time TOP 20]**, the top 20 slow SQL queries are displayed based on execution time in descending order. You can adjust parameters to display your desired TOP N.

![image.png](../images/mysql/mysql-7.png)

### `mysql_dbm_activity` View

Building the `mysql_dbm_activity` view allows you to observe the current number of executing SQL statements, event type distribution (e.g., CPU events or User sleep events), event status distribution (e.g., Sending data, Creating sort index), event command type distribution (e.g., Query or Sleep), and event list.

#### Event Type Distribution

Refers to the types of events processing SQL:

- CPU
- User sleep

![image.png](../images/mysql/mysql-8.png)

#### Event Status Distribution

Shows the distribution of statuses for currently processing SQL events, including:

- init: Initial execution
- Sending data: Sending data
- Creating sort index: Creating sort index
- freeing items: Releasing items
- converting HEAP to MyISAM: Converting heap to MyISAM
- query end: Query completed
- Opening tables: Opening tables
- statistics: Statistics

![image.png](../images/mysql/mysql-9.png)

#### Event Command Type Distribution

Shows the distribution of command types for currently processing SQL events, including:

- query: Query, analyzed together with event status
- sleep: Sleeping, not yet scheduled
- daemon: Running as a daemon

![image.png](../images/mysql/mysql-10.png)

#### Event List

Top 100 events, showing the last 100 event records, including event ID (`processlist_id`), user (`processlist_user`), host (`DB Host`), SQL statement (`SQL`), initiating host (`process Host`), event type, event status, and execution time.

![image.png](../images/mysql/mysql-11.png)

#### Schema-Based Process Event Trends

Viewing the event trends for specific schemas helps analyze the pressure on those schemas.

![image.png](../images/mysql/mysql-12.png)

## View Templates
[MySQL Monitoring View]

[MySQL Activity]

[MySQL DBM Metric]

[MySQL Slow Queries]