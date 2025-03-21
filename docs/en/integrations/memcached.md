---
title     : 'Memcached'
summary   : 'Collect metrics data from Memcached'
tags:
  - 'CACHING'
  - 'MIDDLEWARE'
__int_icon      : 'icon/memcached'
dashboard :
  - desc  : 'Memcached'
    path  : 'dashboard/en/memcached'
monitor   :
  - desc  : 'Memcached'
    path  : 'monitor/en/memcached' 
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Memcached collector can collect instance runtime status metrics from Memcached instances and send the metrics to <<< custom_key.brand_name >>>, helping with monitoring and analyzing various abnormal conditions of Memcached.

## Configuration {#config}

### Prerequisites {#requirements}

- Memcached version >= `1.5.0`. Tested versions:
    - [x] 1.5.x
    - [x] 1.6.x

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/db` directory under the DataKit installation directory, copy `memcached.conf.sample`, and rename it as `memcached.conf`. Example:
    
    ```toml
        
    [[inputs.memcached]]
      ## Servers' addresses.
      servers = ["localhost:11211"]
      # unix_sockets = ["/var/run/memcached.sock"]
    
      ## Set true to enable election
      election = true
    
      ## Collect extra stats
      # extra_stats = ["slabs", "items"]
    
      ## Collect interval.
      # units: "ns", "us", "ms", "s", "m", "h"
      interval = "10s"
    
    [inputs.memcached.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can currently enable the collector by injecting its configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data will append global election tags, or you can specify other labels in the configuration through `[inputs.memcached.tags]`:

``` toml
 [inputs.memcached.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `memcached`

- Tags


| Tag | Description |
|  ----  | --------|
|`server`|The host name from which metrics are gathered|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`accepting_conns`|Whether or not server is accepting connections|int|count|
|`auth_cmds`|Number of authentication commands handled, success or failure|int|count|
|`auth_errors`|Number of failed authentications|int|count|
|`bytes`|Current number of bytes used to store items|int|B|
|`bytes_read`|Total number of bytes read by this server from network|int|B|
|`bytes_written`|Total number of bytes sent by this server to network|int|B|
|`cas_badval`|Number of CAS operations where a key was found but the CAS value did not match|int|count|
|`cas_hits`|Number of successful CAS requests|int|count|
|`cas_misses`|Number of CAS requests against missing keys|int|count|
|`cmd_flush`|Cumulative number of flush requests|int|count|
|`cmd_get`|Cumulative number of retrieval requests|int|count|
|`cmd_set`|Cumulative number of storage requests|int|count|
|`cmd_touch`|Cumulative number of touch requests|int|count|
|`conn_yields`|Number of times any connection yielded to another due to hitting the -R limit|int|count|
|`connection_structures`|Number of connection structures allocated by the server|int|count|
|`curr_connections`|Number of open connections|int|count|
|`curr_items`|Current number of items stored|int|count|
|`decr_hits`|Number of successful `decr` requests|int|count|
|`decr_misses`|Number of `decr` requests against missing keys|int|count|
|`delete_hits`|Number of deletion requests resulting in an item being removed|int|count|
|`delete_misses`|Number of deletion requests for missing keys|int|count|
|`evicted_unfetched`|Items evicted from LRU that were never touched by get/incr/append/etc|int|count|
|`evictions`|Number of valid items removed from cache to free memory for new items|int|count|
|`expired_unfetched`|Items pulled from LRU that were never touched by get/incr/append/etc before expiring|int|count|
|`get_hits`|Number of keys that have been requested and found present|int|count|
|`get_misses`|Number of items that have been requested and not found|int|count|
|`hash_bytes`|Bytes currently used by hash tables|int|B|
|`hash_is_expanding`|Indicates if the hash table is being grown to a new size|int|count|
|`hash_power_level`|Current size multiplier for hash table|int|count|
|`incr_hits`|Number of successful incr requests|int|count|
|`incr_misses`|Number of incr requests against missing keys|int|count|
|`limit_maxbytes`|Number of bytes this server is allowed to use for storage|int|B|
|`listen_disabled_num`|Number of times server has stopped accepting new connections (`maxconns`)|int|count|
|`reclaimed`|Number of times an entry was stored using memory from an expired entry|int|count|
|`threads`|Number of worker threads requested|int|count|
|`total_connections`|Total number of connections opened since the server started running|int|count|
|`total_items`|Total number of items stored since the server started|int|count|
|`touch_hits`|Number of keys that have been touched with a new expiration time|int|count|
|`touch_misses`|Number of items that have been touched and not found|int|count|
|`uptime`|Number of seconds since the server started|int|count|



### `memcached_items`

- Tags


| Tag | Description |
|  ----  | --------|
|`server`|The host name from which metrics are gathered|
|`slab_id`|The id of the current slab|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age of the oldest item in the LRU|int|count|
|`crawler_reclaimed`|Number of items which freed by the LRU Crawler|int|count|
|`direct_reclaims`|Number of worker threads which had to directly pull LRU tails to find memory for a new item|int|count|
|`evicted`|Number of the items which had to be evicted from the LRU before expiring|int|count|
|`evicted_nonzero`|Number of the `onzero` items which had an explicit expire time set had to be evicted from the LRU before expiring|int|count|
|`evicted_time`|Seconds since the last access for the most recent item evicted from this class|int|s|
|`evicted_unfetched`|Number of the valid items evicted from the LRU which were never touched after being set|int|count|
|`expired_unfetched`|Number of the expired items reclaimed from the LRU which were never touched after being set|int|count|
|`lrutail_reflocked`|Number of items which found to be `refcount` locked in the LRU tail|int|count|
|`moves_to_cold`|Number of items which were moved from HOT or WARM into COLD|int|count|
|`moves_to_warm`|Number of items which were moved from COLD to WARM|int|count|
|`moves_within_lru`|Number of active items which were bumped within HOT or WARM|int|count|
|`number`|Number of items presently stored in this slab class|int|count|
|`number_cold`|Number of items presently stored in the COLD LRU|int|count|
|`number_hot`|Number of items presently stored in the HOT LRU|int|count|
|`number_noexp`|Number of items presently stored in the `NOEXP` class|int|count|
|`number_warm`|Number of items presently stored in the WARM LRU|int|count|
|`outofmemory`|Number of the underlying slab class which was unable to store a new item|int|count|
|`reclaimed`|Number of entries which were stored using memory from an expired entry|int|count|
|`tailrepairs`|How many times memcache self-healed a slab with a `refcount` leak|int|count|



### `memcached_slabs`

- Tags


| Tag | Description |
|  ----  | --------|
|`server`|The host name from which metrics are gathered|
|`slab_id`|The id of the current slab|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_slabs`|Total number of slab classes allocated|int|count|
|`cas_badval`|Number of CAS commands failed to modify a value due to a bad CAS id|int|count|
|`cas_hits`|Number of CAS commands modified this slab class|int|count|
|`chunk_size`|The amount of space each chunk uses|int|B|
|`chunks_per_page`|How many chunks exist within one page|int|count|
|`cmd_set`|Number of set requests stored data in this slab class|int|count|
|`decr_hits`|Number of `decrs` commands modified this slab class|int|count|
|`delete_hits`|Number of delete commands succeeded in this slab class|int|count|
|`free_chunks`|Chunks not yet allocated to items or freed via delete|int|count|
|`free_chunks_end`|Number of free chunks at the end of the last allocated page|int|count|
|`get_hits`|Number of get requests were serviced by this slab class|int|count|
|`incr_hits`|Number of `incrs` commands modified this slab class|int|count|
|`total_chunks`|Total number of chunks allocated to the slab class|int|count|
|`total_malloced`|Total amount of memory allocated to slab pages|int|B|
|`total_pages`|Total number of pages allocated to the slab class|int|count|
|`touch_hits`|Number of touches serviced by this slab class|int|count|
|`used_chunks`|How many chunks have been allocated to items|int|count|