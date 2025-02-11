# Redis Observability Best Practices
---

## What is Redis

Redis is a popular in-memory key/value data store. Redis is renowned for its outstanding performance and ease of getting started, finding applications across various industries:

- **Database**: Although Redis can use asynchronous disk persistence, it trades persistence for speed compared to traditional disk-based databases. Redis offers a rich set of data primitives and an extensive list of commands.

- **Mail Queue**: Redis's blocking list commands and low latency make it an excellent backend for mail proxy services.
- **In-Memory Cache**: Configurable key eviction policies, including the popular "Least Recently Used" policy and the "Least Frequently Used" policy starting from Redis 4.0, make Redis an ideal choice for cache servers. Unlike traditional caches, Redis also allows disk persistence to enhance reliability.

Redis is a free open-source product. Commercial support is available, as well as fully managed Redis-as-a-service offerings.

Redis is adopted by many high-traffic websites and applications such as Twitter, GitHub, Docker, Pinterest, Datadog, and Stack Overflow.

## Key Redis Metrics

Monitoring Redis can help you identify issues in two areas: resource problems with Redis itself and issues elsewhere in the supporting infrastructure.

In this article, we detail the most important Redis metrics in each of the following categories:

- **Performance Metrics**

- **Memory Metrics**
- **Basic Activity Metrics**
- **Persistence Metrics**
- **Error Metrics**

### Performance Metrics

Apart from a low error rate, good performance is one of the best top-level indicators of system health. As mentioned in the memory section, poor performance is often caused by memory issues.

| **Name** | **Description** | Metric Type |
| --- | --- | --- |
| latency | The average time taken by the Redis server to respond to requests | Work: Performance |
| Instantaneous_ops_per_sec | Total number of commands processed per second | Work: Throughput |
| hit rate (calculated) | keyspace_hits / (keyspace_hits + keyspace_misses) | Work: Success |

#### Alert Metric: latency
Latency measures the time between a client request and the actual server response. Tracking latency is the most direct method to detect changes in Redis performance. Due to Redis's single-threaded nature, outliers in the latency distribution can cause significant bottlenecks. A prolonged response time for one request can increase the wait time for all subsequent requests. Once latency is identified as an issue, multiple measures can be taken to diagnose and resolve performance problems.

![image.png](../images/redis.png)

#### Observability Metric: Instantaneous_ops_per_sec

Tracking throughput of processed commands is crucial for diagnosing the causes of high latency in a Redis instance. High latency can be caused by various issues, from a backlog of command queues to slow commands or overused network links. You can investigate by measuring the number of commands processed per second—if this remains almost constant, the cause is not compute-intensive commands. If one or more slow commands are causing latency issues, you will see a drop or complete halt in the number of commands processed per second. A decrease in the number of commands processed per second compared to historical norms may indicate low command volume or slow commands blocking the system. Low command volume could be normal or may indicate upstream issues.

#### Metric: hit rate

When using Redis as a cache, monitoring the cache hit rate can tell you whether the cache is being effectively utilized. A low hit rate means clients are looking for keys that no longer exist. Redis does not provide a direct hit rate metric, but it can be calculated as follows:

```
hit rate = keyspace_hits / (keyspace_hits + keyspace_misses)
```

A low cache hit rate can be caused by various factors, including data expiration and insufficient memory allocated to Redis (which can lead to key evictions). A low hit rate can increase application latency because it has to fetch data from slower backup resources.

### Memory Metrics
| **Name** | Description | Metric Type |
| --- | --- | --- |
| used_memory | Amount of memory used by Redis (in bytes) | Resource: Utilization |
| mem_fragmentation_ratio | Ratio of memory allocated by the operating system to memory requested by Redis | Resource: Saturation |
| evicted_keys | Number of keys deleted due to reaching the maximum memory limit | Resource: Saturation |
| blocked_clients | Clients blocked while waiting for BLPOP, BRPOP, or BRPOPLPUSH | Other |

#### Observability Metric: used_memory
Memory usage is a critical component of Redis performance. If used_memory exceeds the total available system memory, the operating system will start swapping old/unused parts of memory to disk, significantly impacting performance. Writing and reading from disk is approximately five orders of magnitude (100,000x!) slower than writing and reading from memory (memory: 0.1 µs, disk: 10 ms).

You can configure Redis to limit memory usage within a specified amount. Setting the maxmemory directive in the redis.conf file directly controls Redis's memory usage. Enabling maxmemory requires configuring an eviction policy to determine how memory is freed. Learn more about configuring the maxmemory-policy directive in the evicted_keys section.

![image.png](../images/redis-2.png)

#### Alert Metric: mem_fragmentation_ratio
The mem_fragmentation_ratio metric provides the ratio of memory used by the operating system (used_memory_rss) to memory allocated by Redis (used_memory).
```
mem_fragmentation_ratio = used_memory_rss / used_memory
```
The operating system is responsible for allocating physical memory to each process. The virtual memory manager handles the actual mapping mediated by the memory allocator.

What does this mean? If your Redis instance occupies 1GB of memory, the memory allocator first tries to find a contiguous segment to store the data. If no contiguous segment is found, the allocator must divide the process's data into multiple segments, increasing memory overhead.

Tracking fragmentation ratio is important for understanding Redis instance performance. A fragmentation ratio greater than 1 indicates fragmentation is occurring. A ratio exceeding 1.5 indicates excessive fragmentation, meaning your Redis instance consumes 150% of the physical memory it requested. A fragmentation ratio less than 1 indicates Redis needs more memory than is available on the system, leading to swapping. Swapping to disk will significantly increase latency (see used_memory). Ideally, the operating system should allocate a contiguous segment in physical memory, with a fragmentation ratio equal to or greater than 1.

If the fragmentation ratio exceeds 1.5, restarting the Redis instance allows the operating system to reclaim previously unusable memory due to fragmentation. In this case, alerting as a notification might suffice.

However, if your Redis server's fragmentation ratio is below 1, you may need to page alerts to quickly increase available memory or reduce memory usage.

Starting from Redis 4, when configured to use the bundled jemalloc copy, Redis can utilize a new active defragmentation feature. This tool can be configured to start when fragmentation reaches a certain level, copying values to contiguous memory regions and freeing up old copies, thus reducing runtime fragmentation.

#### Alert Metric: evicted_keys (Cache Only)

If you use Redis as a cache, you might configure it to automatically clear keys when the maximum memory limit is reached. If you use Redis as a database or queue, it's better to replace eviction with another strategy, so you can skip this metric.

Tracking key evictions is important because Redis processes each operation sequentially, meaning large-scale key evictions can lead to lower hit rates, resulting in longer latencies. If you use TTL, you may not want to evict keys. In this case, if this metric is consistently greater than zero, your instance's latency may increase. Most other configurations that do not use TTL will eventually run out of memory and start evicting keys. As long as your response times are acceptable, a stable eviction rate is acceptable.

You can configure the key expiration policy using the following command:

```
redis-cli CONFIG SET maxmemory-policy <policy>
```

Where `policy` is one of the following:

- **noeviction:** Return an error when the memory limit is reached and users try to add other keys

- **volatile-lru:** Evict the least recently used key from the set of keys with expiration
- **volatile-ttl:** Evict the key with the shortest remaining time-to-live from the set of keys with expiration
- **volatile-random:** Evict a random key from the set of keys with expiration
- **allkeys-lru:** Evict the least recently used key from all key sets
- **allkeys-random:** Evict a random key from all key sets
- **volatile-lfu:** Added in Redis 4, evict the least frequently used key from the set of keys with expiration
- **allkeys-lfu:** Added in Redis 4, evict the least frequently used key from all key sets

Note: For performance reasons, Redis does not sample the entire key space when using LRU, TTL, or Redis 4 (from LFU onward). Instead, Redis samples a random subset of the key space and applies the eviction policy to that subset. Generally, newer (> = 3) versions of Redis adopt an LRU sampling strategy closer to true LRU. The LFU strategy can be adjusted by setting how much time must pass before items have their access level reduced. For more details, refer to Redis documentation.
#### Observability Metric: blocked_clients
Redis provides many blocking commands for list operations. BLPOP, BRPOP, and BRPOPLPUSH are blocking variants of the commands LPOP, RPOP, and RPOPLPUSH, respectively. When the source list is non-empty, the commands execute as expected. However, when the source list is empty, the blocking commands wait until the source is populated or a timeout occurs.

An increasing number of blocked clients waiting for data can be a sign of problems. Latency or other issues may prevent the source list from being populated. While blocked clients themselves do not cause alerts, if you see this metric consistently non-zero, investigation is warranted.
### Basic Activity Metrics
Note: This section includes metrics using the terms “master” and “slave.” Except when referencing specific metric names, this article replaces them with “primary” and “replica.”

| **Name** | **Description** | Metric Type |
| --- | --- | --- |
| connected_clients | Number of clients connected to Redis | Resource: Utilization |
| connected_slaves | Number of replicas connected to the current primary instance | Other |
| master_last_io_seconds_ago | Time since the last interaction between replica and primary instance (in seconds) | Other |
| keyspace | Total number of keys in the database | Resource: Utilization |

#### Alert Metric: connected_clients
Since access to Redis is typically mediated by applications (users usually do not directly access the database), in most cases, the number of connected clients has reasonable upper and lower bounds. If the number falls outside the normal range, it may indicate an issue. If it is too low, upstream connections may be lost; if it is too high, a large number of concurrent client connections may overwhelm the server's ability to handle requests.

In any case, the maximum number of client connections is always a limited resource—whether constrained by the operating system, Redis configuration, or network limits. Monitoring client connections helps ensure sufficient available resources for new clients or session management.
#### Alert Metric: connected_slaves
If your database is read-heavy, you might be using Redis's built-in replication feature. In this case, monitoring the number of connected replicas is critical. If the number of connected replicas unexpectedly changes, it may indicate issues with the host or replica instances.

![image.png](../images/redis-3.png)

Note: In the above image, the Redis primary database shows it has two connected replicas, and each first child node reports having two connected replicas. Since secondary replicas do not connect directly to the Redis primary replica, they are not included in the count of replicas connected to the primary.

#### Alert Metric: master_last_io_seconds_ago

Using Redis's replication feature, replica instances regularly check in with their primary instance. Long periods without communication may indicate issues with the primary Redis server, replica server, or both. You risk the replica providing outdated data that may have changed since the last sync. Minimizing interruptions in primary-replica communication is crucial. When a replica reconnects after an interruption, it sends a SYNC command to attempt partial synchronization of commands missed during the interruption. If this fails, the replica requests a full SYNC, which causes the primary replica to immediately begin saving the database to disk in the background while buffering all new commands that modify the dataset. After the background save completes, the data is sent to the client along with buffered commands. Each time a replica executes a SYNC, it causes a significant delay in the primary instance.

#### Important Metric: keyspace

Tracking the number of keys in the database is generally a good idea. As an in-memory data store, the larger the keyspace, the more physical memory Redis needs to ensure optimal performance. Redis will continue adding keys until it reaches the maximum memory limit, at which point it starts evicting keys at the same rate as new keys are added.

If you use Redis as a cache and observe keyspace saturation (as shown in the above image) along with lower hit rates, your clients may be requesting old or evicted data. Tracking the number of keyspace_misses over time will help identify the cause.

Additionally, if you use Redis as a database or queue, volatile keys may not be advisable. As the keyspace grows, you may need to consider adding memory within the box or splitting the dataset across hosts. Adding more memory is a simple and effective solution. When the required resources exceed what a single box can provide, partitioning or sharding can combine the resources of multiple machines. With a partitioning plan, Redis can store more keys without evicting or swapping. However, applying a partitioning plan is more challenging than swapping in a few memory sticks.

### Persistence Metrics

| **Name** | **Description** | Metric Type |
| --- | --- | --- |
| rdb_last_save_time | Unix timestamp of the last save to disk | Other |
| rdb_changes_since_last_save | Number of changes made to the database since the last dump | Other |

Enabling persistence may be necessary, especially when using Redis's replication feature. Since replicas blindly replicate any changes made to the primary instance, if you restart the primary instance (without persistence), all connected replicas will replicate its now-empty dataset.<br />If you use Redis as a cache or in a use case where data loss is less critical, persistence may not be necessary.

#### Important Monitoring Metrics: rdb_last_save_time and rdb_changes_since_last_save

Generally, it's best to be aware of dataset volatility. A long interval between writes to disk during a server failure can result in data loss. Any changes made to the dataset between the last save time and the failure time will be lost.<br />Monitoring `rdb_changes_since_last_save` gives you deeper insight into dataset volatility. If your dataset hasn't changed much during the interval, a long interval between writes isn't problematic. Tracking both metrics provides a good understanding of how much data you would lose if a failure occurred at a given time.

### Error Metrics

Note: This section includes metrics using the terms “master” and “slave.” Except when referencing specific metric names, this article replaces them with “primary” and “replica.”<br />Redis error metrics can alert you to abnormal conditions. The following metrics track common errors:

| **Name** | **Description** | Metric Type |
| --- | --- | --- |
| rejected_connections | Number of connections rejected due to reaching the maxclient limit | Resource: Saturation |
| keyspace_misses | Number of failed key lookups | Resource: Errors / Other |
| master_link_down_since_seconds | Time since the link between the primary and replica servers was disconnected (in seconds) | Resource: Errors |

#### Alert Metric: rejected_connections
Redis can handle many active connections, with 10,000 client connections available by default. The maximum number of connections can be set to another value by changing the maxclient directive in the redis.conf file. If your Redis instance is currently at its maximum connection limit, any new connection attempts will be disconnected.

![image.png](../images/redis-4.png)

Note that your system may not support the number of connections you request via the maxclient directive. Redis checks with the kernel to determine the number of available file descriptors. If the number of available file descriptors is less than `maxclient + 32` (Redis reserves 32 file descriptors for its own use), the `maxclient` directive is ignored, and the available number of file descriptors is used.

#### Alert Metric: keyspace_misses
Each time Redis looks up a key, there are only two possible outcomes: the key exists, or it does not. Looking up a non-existent key increments the keyspace_misses counter. A consistently non-zero value for this metric indicates clients are attempting to look up non-existent keys in the database. If Redis is not used as a cache, `keyspace_misses` should be zero or close to zero. Note that any blocking operations called on empty keys (BLPOP, BRPOP, and BRPOPLPUSH) will increment `keyspace_misses`.
#### Alert Metric: master_link_down_since_seconds
This metric is only available when the connection between the primary node and its replicas is lost. Ideally, this value should never exceed zero—the primary and replica databases should maintain continuous communication to ensure the replica database does not provide outdated data. Larger intervals between connections should be addressed. Remember, after reconnection, your primary Redis instance will need to invest resources to update the data on the replica, which can cause increased latency.
## Conclusion
In this article, we've covered some of the most useful metrics you can monitor to keep tabs on your Redis server. If you're just starting with Redis, monitoring the metrics listed below will give you a good overview of your database infrastructure's health and performance:

- **Number of commands processed per second**

- **Latency**
- **Memory fragmentation ratio**
- **Evictions**
- **Rejected clients**

Ultimately, you'll recognize other metrics particularly relevant to your own infrastructure and use case. Of course, what you monitor will depend on the tools you have and the available metrics.