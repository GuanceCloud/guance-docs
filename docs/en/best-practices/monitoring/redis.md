# Redis Observability Best Practices
---

## What is Redis

Redis is a popular in-memory key/value data store. Known for its exceptional performance and ease of getting started, Redis has found uses across various industries, including:

- **Database**: Although asynchronous disk persistence is available, Redis can trade durability for speed compared to traditional disk-based databases. Redis offers a rich set of data primitives and an extensive list of commands.

- **Mail Queue**: Redis's blocking list commands and low latency make it an excellent backend for mail proxy services.
- **In-Memory Cache**: Configurable key eviction policies, including the popular "Least Recently Used" policy and the "Least Frequently Used" policy starting from Redis 4.0, make Redis an outstanding choice for a caching server. Unlike traditional caches, Redis also allows disk persistence for increased reliability.

Redis is a free open-source product. Commercial support and fully managed Redis-as-a-service are also available.

Redis is adopted by many high-traffic websites and applications, such as Twitter, GitHub, Docker, Pinterest, Datadog, and Stack Overflow.

## Key Redis Metrics

Monitoring Redis can help you identify issues in two areas: resource problems within Redis itself and issues elsewhere in the supporting infrastructure.

In this article, we detail the most important Redis metrics in each of the following categories:

- **Performance Metrics**

- **Memory Metrics**
- **Basic Activity Metrics**
- **Persistence Metrics**
- **Error Metrics**

### Performance Metrics

Apart from low error rates, good performance is one of the best top-level indicators of system health. As mentioned in the memory section, poor performance is often caused by memory issues.

| **Name** | **Description** | Metric Type |
| --- | --- | --- |
| latency | Average time taken by the Redis server to respond to requests | Work: Performance |
| Instantaneous_ops_per_sec | Total number of commands processed per second | Work: Throughput |
| hit rate (calculated) | keyspace_hits / (keyspace_hits + keyspace_misses) | Work: Success |

#### Alert Metric: latency
Latency measures the time between client requests and actual server responses. Tracking latency is the most direct method to detect changes in Redis performance. Due to Redis's single-threaded nature, outliers in the latency distribution can cause severe bottlenecks. A long response time for one request increases the wait time for all subsequent requests. Once latency is identified as an issue, multiple steps can be taken to diagnose and resolve performance problems.

![image.png](../images/redis.png)

#### Observation Metric: Instantaneous_ops_per_sec

Tracking the throughput of processed commands is crucial for diagnosing the cause of high latency in a Redis instance. High latency can be caused by various issues, from a backlog of command queues to slow commands or overused network links. You can investigate by measuring the number of commands processed per second—if this remains almost constant, the cause is not compute-intensive commands. If one or more slow commands cause latency issues, you will see a drop or complete stop in commands per second. A decrease in commands processed per second compared to historical norms may indicate low command volume or slow commands blocking the system. Low command volume could be normal or suggest upstream issues.

#### Metric: hit rate

When using Redis as a cache, monitoring the cache hit rate can tell you whether the cache is being used effectively. A low hit rate means clients are looking for keys that no longer exist. Redis does not provide a direct hit rate metric, but it can be calculated as follows:

```
hit rate = keyspace_hits / (keyspace_hits + keyspace_misses)
```

A low cache hit rate can be caused by various factors, including data expiration and insufficient memory allocated to Redis (which may lead to key evictions). A low hit rate can increase application latency because they must fetch data from slower backup resources.

### Memory Metrics
| **Name** | Description | Metric Type |
| --- | --- | --- |
| used_memory | Amount of memory used by Redis (in bytes) | Resource: Utilization |
| mem_fragmentation_ratio | Ratio of memory allocated by the OS to memory requested by Redis | Resource: Saturation |
| evicted_keys | Number of keys removed due to reaching the maximum memory limit | Resource: Saturation |
| blocked_clients | Clients blocked while waiting for BLPOP, BRPOP, or BRPOPLPUSH | Other |

#### Observation Metric: used_memory
Memory usage is a critical component of Redis performance. If `used_memory` exceeds the total available system memory, the operating system will start swapping old/unused parts of memory to disk, which significantly affects performance. Writing each swapped part to disk is five orders of magnitude slower (100,000x!) than writing to memory (memory: 0.1 µs, disk: 10 ms).

You can configure Redis to limit its memory usage within a specified amount. Setting the `maxmemory` directive in the `redis.conf` file directly controls Redis's memory usage. Enabling `maxmemory` requires configuring an eviction policy to determine how memory is released. Learn more about configuring the `maxmemory-policy` directive in the `evicted_keys` section.

![image.png](../images/redis-2.png)

#### Alert Metric: mem_fragmentation_ratio
The `mem_fragmentation_ratio` metric provides the ratio of memory used by the OS (`used_memory_rss`) to memory allocated by Redis (`used_memory`).
```
mem_fragmentation_ratio = used_memory_rss / used_memory
```
The OS handles physical memory allocation for each process. The virtual memory manager manages the actual mapping mediated by the memory allocator.

What does this mean? If your Redis instance occupies 1GB of memory, the memory allocator first tries to find a contiguous segment to store the data. If no contiguous segment is found, the allocator must divide the process data into multiple segments, increasing memory overhead.

Tracking fragmentation is important for understanding Redis instance performance. A fragmentation ratio greater than 1 indicates fragmentation is occurring. A ratio exceeding 1.5 indicates excessive fragmentation, meaning your Redis instance consumes 150% of its requested physical memory. A fragmentation ratio less than 1 tells you Redis needs more memory than is available on the system, leading to swapping. Swapping to disk will significantly increase latency (see used_memory). Ideally, the OS should allocate a contiguous segment in physical memory with a fragmentation ratio equal to or greater than 1.

If the server's fragmentation ratio exceeds 1.5, restarting the Redis instance will allow the OS to reclaim previously unusable memory due to fragmentation. In this case, setting up alerts might suffice.

However, if your Redis server's fragmentation ratio is below 1, you may need to page out alerts so you can quickly increase available memory or reduce memory usage.

Starting from Redis 4, configuring Redis to use the included jemalloc copy enables the new active defragmentation feature. This tool can be configured to start when fragmentation reaches a certain level, copying values to contiguous memory regions and freeing old copies, thus reducing runtime fragmentation.

#### Alert Metric: evicted_keys (for caching only)

If you use Redis as a cache, you may need to configure it to automatically clear keys when the maximum memory limit is reached. If you use Redis as a database or queue, it's better to replace eviction with another strategy, in which case you can skip this metric.

Tracking key evictions is important because Redis processes each operation sequentially, meaning large-scale evictions can lead to lower hit rates and longer latencies. If you use TTL, you may not want to evict keys. In this case, if this metric is consistently greater than zero, your instance's latency may increase. Most other configurations not using TTL will eventually run out of memory and begin evicting keys. As long as your response times are acceptable, a steady eviction rate is acceptable.

You can configure the key eviction policy using the following command:

```
redis-cli CONFIG SET maxmemory-policy <policy>
```

Where `policy` is one of the following:

- **noeviction:** Returns an error when the memory limit is reached and users try to add more keys

- **volatile-lru:** Evicts the least recently used key among keys with an expiration set
- **volatile-ttl:** Evicts the key with the shortest remaining TTL among keys with an expiration set
- **volatile-random:** Evicts a random key among keys with an expiration set
- **allkeys-lru:** Evicts the least recently used key from all keys
- **allkeys-random:** Evicts a random key from all keys
- **volatile-lfu:** Added in Redis 4, evicts the least frequently used key among keys with an expiration set
- **allkeys-lfu:** Added in Redis 4, evicts the least frequently used key from all keys

Note: For performance reasons, Redis does not sample the entire key space when using LRU, TTL, or Redis 4 (starting from LFU). Redis first samples a random subset of the key space and applies the eviction policy to that sample. Typically, newer (> = 3) versions of Redis use an LRU sampling strategy closer to true LRU. The LFU strategy can be adjusted by setting, for example, how much time must pass before access levels decrease. For more details, refer to the Redis documentation.
#### Observation Metric: blocked_clients
Redis provides many blocking commands for list operations. BLPOP, BRPOP, and BRPOPLPUSH are blocking variants of LPOP, RPOP, and RPOPLPUSH, respectively. Commands execute as expected when the source list is non-empty. However, when the source list is empty, blocking commands wait until the source is filled or a timeout occurs.

An increasing number of blocked clients waiting for data can be a sign of problems. Delays or other issues may prevent the source list from being filled. While blocked clients themselves do not trigger alerts, if you observe this metric consistently at a non-zero value, investigation is warranted.
### Basic Activity Metrics
Note: This section includes metrics using the terms "master" and "slave." Except when referencing specific metric names, this article replaces these terms with "primary" and "replica."

| **Name** | **Description** | Metric Type |
| --- | --- | --- |
| connected_clients | Number of clients connected to Redis | Resource: Utilization |
| connected_slaves | Number of replicas connected to the current primary instance | Other |
| master_last_io_seconds_ago | Time since the last interaction between replica and primary instance (in seconds) | Other |
| keyspace | Total number of keys in the database | Resource: Utilization |

#### Alert Metric: connected_clients
Since access to Redis is typically mediated by applications (users usually do not directly access the database), the number of connected clients generally has reasonable upper and lower limits. If the number falls outside the normal range, it may indicate a problem. If it's too low, upstream connections may have been lost; if it's too high, a large number of concurrent client connections may overwhelm the server's ability to handle requests.

Regardless, the maximum number of client connections is always a limited resource—whether constrained by the operating system, Redis configuration, or network limitations. Monitoring client connections helps ensure sufficient resources are available for new clients or managing sessions.
#### Alert Metric: connected_slaves
If your database is read-heavy, you may be using Redis's built-in primary-replica replication feature. In this case, monitoring the number of connected replicas is critical. Unexpected changes in the number of connected replicas may indicate the primary host has gone down or there's an issue with a replica instance.

![image.png](../images/redis-3.png)

Note: In the above image, the Redis primary database shows it has two connected replicas, and each first child node reports having two connected replicas. Since secondary replicas are not directly connected to the Redis primary replica, they are not included in the count of replicas connected to the primary.

#### Alert Metric: master_last_io_seconds_ago

When using Redis's replication feature, replica instances regularly check in with their primary instance. Long periods without communication may indicate issues with your primary Redis server, replica server, or the connection between them. You risk providing stale data from the replica that has changed since the last synchronization. Minimizing interruptions in primary-replica communication is crucial. When a replica reconnects after an interruption, it sends a SYNC command to attempt partial resynchronization of commands missed during the interruption. If this isn't possible, the replica requests a full SYNC, causing the primary to immediately start background saving the database to disk while buffering any new commands modifying the dataset. After the background save completes, the data is sent along with buffered commands to the client. Each SYNC performed by the replica causes significant latency on the primary instance.

#### Important Metric: keyspace

Tracking the number of keys in the database is generally a good idea. As an in-memory data store, the larger the keyspace, the more physical memory Redis needs to ensure optimal performance. Redis continues adding keys until it reaches the maximum memory limit, at which point it starts evicting keys at the same rate as new keys are added.

If you use Redis as a cache and observe keyspace saturation (as shown in the figure above) along with a lower hit rate, your clients may be requesting old or evicted data. Tracking the number of `keyspace_misses` over time will help you identify the cause.

Additionally, if you use Redis as a database or queue, volatile keys may not be advisable. As the keyspace grows, you may need to consider adding more memory or splitting the dataset across hosts. Adding more memory is a simple and effective solution. When needed resources exceed what a single box can provide, combining resources from multiple computers through partitioning or sharding is an option. With a partitioning plan, Redis can store more keys without eviction or swapping. Applying a partitioning plan is more challenging than swapping a few memory sticks.

### Persistence Metrics

| **Name** | **Description** | Metric Type |
| --- | --- | --- |
| rdb_last_save_time | Unix timestamp of the last save to disk | Other |
| rdb_changes_since_last_save | Number of changes made to the database since the last dump | Other |

Enabling persistence may be necessary, especially when using Redis's replication feature. Since replicas blindly replicate any changes made to the primary instance, if you restart the primary instance without persistence, all connected replicas will replicate an empty dataset.<br />If you use Redis as a cache or in a use case where data loss is less critical, persistence may not be necessary.

#### Important Metrics: rdb_last_save_time and rdb_changes_since_last_save

It's best to monitor the volatility of your dataset. A long interval between writes to disk can lead to data loss if the server fails. Any changes made to the dataset between the last save and the failure will be lost.<br />Monitoring `rdb_changes_since_last_save` gives you deeper insight into the dataset's volatility. If your dataset doesn't change much during this interval, a long interval between writes is not problematic. Tracking both metrics provides a good understanding of how much data you would lose if a failure occurred at a given point in time.

### Error Metrics

Note: This section includes metrics using the terms "master" and "slave." Except when referencing specific metric names, this article replaces these terms with "primary" and "replica."<br />Redis error metrics can alert you to abnormal conditions. The following metrics track common errors:

| **Name** | **Description** | Metric Type |
| --- | --- | --- |
| rejected_connections | Number of connections rejected due to reaching the maxclient limit | Resource: Saturation |
| keyspace_misses | Number of failed key lookups | Resource: Errors / Other |
| master_link_down_since_seconds | Time since the link between primary and replica servers was disconnected (in seconds) | Resource: Errors |

#### Alert Metric: rejected_connections
Redis can handle many active connections, with 10,000 client connections available by default. You can set the maximum number of connections to another value by changing the `maxclient` directive in the `redis.conf` file. If your Redis instance is currently at the maximum number of connections, any new connection attempts will be refused.

![image.png](../images/redis-4.png)

Note that your system may not support the number of connections you request using the `maxclient` directive. Redis checks with the kernel to determine the number of available file descriptors. If the number of available file descriptors is less than `maxclient + 32` (Redis reserves 32 file descriptors for its own use), the `maxclient` directive is ignored, and the number of available file descriptors is used instead.

#### Alert Metric: keyspace_misses
Each time Redis looks up a key, there are only two possible outcomes: the key exists, or it does not. Looking up a non-existent key increments the `keyspace_misses` counter. A consistently non-zero value for this metric indicates clients are attempting to look up non-existent keys in the database. If Redis is not used as a cache, `keyspace_misses` should be zero or close to zero. Note that any blocking operations (BLPOP, BRPOP, BRPOPLPUSH) called on empty keys will increment `keyspace_misses`.
#### Alert Metric: master_link_down_since_seconds
This metric is only available when the connection between the primary node and its replicas is lost. Ideally, this value should never exceed zero—the primary and replica databases should maintain continuous communication to ensure replicas do not provide stale data. Larger intervals between connections should be addressed. Remember, after reconnection, your primary Redis instance will need to invest resources to update the data on the replicas, potentially causing increased latency.
## Conclusion
In this article, we covered some of the most useful metrics you can monitor to keep tabs on your Redis server. If you're just starting with Redis, monitoring the metrics listed below will give you a good understanding of your database infrastructure's health and performance:

- **Number of commands processed per second**

- **Latency**
- **Memory fragmentation ratio**
- **Evictions**
- **Rejected clients**

Ultimately, you'll recognize other metrics particularly relevant to your own infrastructure and use case. Of course, what you monitor will depend on the tools you have and the available metrics.