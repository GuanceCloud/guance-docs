# Insights into MySQL

---

> Author: Liu Rui

Databases serve as the backbone of business operations, influencing application architecture and performance. Application service performance can be improved through horizontal scaling, but database performance ultimately determines the fate of the application. MySQL, as the king of databases, is widely used across various industries. As business grows, improper use of SQL and numerous slow queries can severely impact application performance. Therefore, monitoring it becomes crucial.

## MySQL Integration

[MySQL Integration Documentation](../../integrations/mysql.md)

## MySQL Monitoring

Monitoring MySQL involves a comprehensive view of related metrics from four main aspects:

1. Summary
2. Active User Information
3. InnoDB
4. Lock Information

### Summary

The summary section provides an overview of MySQL based on dimensions such as connection count, QPS, TPS, abnormal connections, index-less join queries per second, schema size distribution, slow queries, and lock wait times.
![image.png](../images/mysql/mysql-1.png)

### Active User Information

Have you ever paid attention to MySQL connections? Let's start with an error:

```shell
MySQL: ERROR 1040: Too many connections
```

We know that MySQL supports both long and short connections. Establishing a connection incurs significant overhead, so long connections are generally used. However, using long connections can increase memory usage because MySQL temporarily uses memory to manage connection objects during query execution, which are only released when the connection is closed. If too many long connections accumulate, it can lead to increased memory usage, causing the system to forcibly kill MySQL and result in service restarts.

For long connections, periodic disconnection is necessary. You can estimate whether a connection is persistent by checking the memory usage. Additionally, executing `mysql_reset_connection` after large operations can reinitialize and release connection resources.

A typical MySQL connection corresponds to a user request. If a request takes too long to complete, it can cause connection accumulation and rapidly deplete the database's available connections. Long-running SQL queries will hold connections without releasing them, while new application requests keep pouring in, quickly exhausting the available connections.

In cloud-native and microservices environments, the requirements for database connections are higher, making MySQL connections a potential bottleneck. "Too many connections" can lead to high CPU usage on the MySQL server and disrupt business operations due to insufficient connections. Real-time monitoring helps identify database bottlenecks quickly, even down to individual user connection details, such as current and cumulative connection counts.

![image.png](../images/mysql/mysql-2.png)

Additionally, we can optimize MySQL connections based on current usage:

- Increase the maximum number of connections
- Implement master-slave replication for read-write separation
- Split services and introduce multiple database instances
- Add caching to reduce queries
- And more

### InnoDB

Enable InnoDB metrics collection by setting `innodb=true` in the `mysql.conf`.

![image.png](../images/mysql/mysql-3.png)

### Lock Information

![image.png](../images/mysql/mysql-4.png)

## MySQL Slow Queries

Slow queries in production systems represent a risk and potential failure point. Once they occur, they can make the system unavailable, impacting business operations. The more slow queries there are, the more CPU and IO resources they consume. Therefore, addressing and avoiding slow queries is critical.

There are two ways to optimize slow queries:

1. Enable **slow log** to collect slow query logs and manually analyze slow queries using `EXPLAIN`.
2. Use Guance to enable dbm for collecting database performance metrics. It automatically selects some high-execution-time SQL statements, retrieves their execution plans, and collects various performance metrics during actual execution.

## MySQL Slow Log

### Broad Slow Queries

We often encounter narrow-scope slow queries, where queries exceeding a set time (e.g., over 10 seconds) are marked as slow. Besides this, other scenarios can also lead to slow queries:

- Large result sets returned.
- Frequent queries without indexes.

### Enabling Slow Query Logs

Below is the configuration for enabling slow query logs in MySQL 5.7:

```toml
#### Slow Query Log ####
slow_query_log = 1 ## Enable slow query log
slow_query_log_file = /var/log/mysql/slow.log ## Slow query log file name
long_query_time = 2 ## Record queries taking longer than 2 seconds
# min_examined_row_limit = 100 ## Only record queries examining more than 100 rows
#log-queries-not-using-indexes ## Record queries not using indexes
log_throttle_queries_not_using_indexes = 5 ## Limit recording non-indexed queries to 5 per minute
log-slow-admin-statements = table ## Record administrative operations like ALTER TABLE
log_output = file ## Log output format FILE|TABLE|NONE, default is file. TABLE is not recommended
log_timestamps = 'system' ## Use system time for log timestamps
```

Here, the top 100 slow queries are recorded. For more details, check the log viewer for additional log information.

![image.png](../images/mysql/mysql-5.png)

## MySQL DBM

Database performance metrics primarily come from MySQL's built-in `performance_schema`, which provides a way to monitor server internal execution at runtime. DataKit can collect historical query statistics, execution plans, and other performance metrics from this database. The collected data is saved as logs with sources `mysql_dbm_metric`, `mysql_dbm_sample`, and `mysql_dbm_activity`.

Enabling dbm allows direct collection of database performance metrics. Configuration reference: [MySQL](/datakit/mysql/#performance-schema)

```toml
[[inputs.mysql]]

# Enable database performance metrics collection
dbm = true

...

# Monitoring metrics configuration
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

By enabling `dbm`, you can visualize and analyze current database performance metrics directly in the view, including maximum slow query time, maximum slow insert time, slow query execution count, most frequently executed SQL, and longest lock time.

![image.png](../images/mysql/mysql-6.png)

In the view **[SQL Execution Time TOP 20],** slow queries are ranked by execution time, showing the top 20. You can adjust parameters to display your desired TOP N.

![image.png](../images/mysql/mysql-7.png)

### `mysql_dbm_activity` View

Building the `mysql_dbm_activity` view allows you to observe the number of currently executing SQL statements, event type distribution (CPU or User sleep), event status distribution (e.g., Sending data, Creating sort index), event command type distribution (e.g., Query, Sleep), and the event list.

#### Event Type Distribution

This refers to the types of events processing SQL:

- CPU
- User sleep

![image.png](../images/mysql/mysql-8.png)

#### Event Status Distribution

This shows the distribution of current SQL processing statuses:

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

This shows the distribution of current SQL processing command types:

- query: Query, analyzed together with event status
- sleep: Idle, not yet scheduled
- daemon: Running as a daemon

![image.png](../images/mysql/mysql-10.png)

#### Event List

The top 100 events, including event ID (processlist_id), processlist_user (user associated with the event), DB Host (event host), SQL (executed statement), process Host (originating host), event type, event status, and execution time.

![image.png](../images/mysql/mysql-11.png)

#### Schema-Based Process Event Trends

Viewing event trends for specific schemas helps analyze the pressure on those schemas.

![image.png](../images/mysql/mysql-12.png)

## View Templates
[MySQL Monitoring View]

[MySQL Activity]

[MySQL DBM Metric]

[MySQL Slow Queries]