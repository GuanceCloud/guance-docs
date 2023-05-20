
# Memcached
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Memcached 采集器可以从 Memcached 实例中采集实例运行状态指标，并将指标采集到观测云，帮助监控分析 Memcached 各种异常情况。

## 前置条件 {#requirements}

- Memcached 版本 >= `1.5.0`。已测试的版本:
    - [x] 1.5.x
    - [x] 1.6.x

## 配置 {#config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `memcached.conf.sample` 并命名为 `memcached.conf`。示例如下：
    
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

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.memcached.tags]` 指定其它标签：

``` toml
 [inputs.memcached.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `memcached`

- 标签


| Tag | Description |
|  ----  | --------|
|`server`|The host name from which metrics are gathered|

- 指标列表


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


