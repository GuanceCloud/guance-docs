
# Memcached
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "Election Enabled")

---

Memcached collector can collect the running status metrics from Memcached instances, and collect the metrics to the observation cloud to help monitor and analyze various abnormal situations of Memcached.

## Preconditions {#requirements}

- Memcached version >= `1.5.0`. Already tested version:
    - [x] 1.5.x
    - [x] 1.6.x

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `memcached.conf.sample` and name it `memcached.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.memcached]]
      ## Servers' addresses.
      servers = ["localhost:11211"]
      # unix_sockets = ["/var/run/memcached.sock"]
    
      ## Set true to enable election
      election = true
    
      ## Collect interval.
      # 单位 "ns", "us" (or "µs"), "ms", "s", "m", "h"
      interval = "10s"
    
    [inputs.memcached.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
    ```
    
    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.memcached.tags]`:

``` toml
 [inputs.memcached.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `memcached`

- tag


| Tag | Description |
|  ----  | --------|
|`server`|The host name from which metrics are gathered|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`accepting_conns`|Whether or not server is accepting conns|int|count|
|`auth_cmds`|Number of authentication commands handled, success or failure|int|count|
|`auth_errors`|Number of failed authentications|int|count|
|`bytes`|Current number of bytes used to store items|int|B|
|`bytes_read`|Total number of bytes read by this server from network|int|B|
|`bytes_written`|Total number of bytes sent by this server to network|int|B|
|`cas_badval`|Number of CAS  for which a key was found, but the CAS value did not match|int|count|
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
|`delete_misses`|umber of deletions requests for missing keys|int|count|
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
|`uptime`|Number of secs since the server started|int|count|


