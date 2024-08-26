

查询前请关注[事件相关字段说明](../events/#fields) 中的`df_monitor_checker_event_ref`、`df_fault_id`、`df_status`、`df_fault_status` 字段说明
# DQL 查询

## 1. 查询入口

- [ OpenAPI  「DQL数据查询」](../open-api/query-data/query-data-v1/)
- [ExternalAPI 「# 【数据查询】DQL数据查询」](../external-api/query-data/query-data/)

## 2. 查询语句

### 方式一：having 方式查询（适用于 doris 引擎）可直接得到结果

 #### 查询结构

```
{
    "queries": [
        {
            "qtype": "dql",
            "query": {
                "disableMultipleField": False,
                "q": "E::`monitor`:(`__docid`, `df_title`,`df_monitor_checker_event_ref`, `df_fault_id`, `df_status`, `df_fault_status`,`df_fault_start_time`, `df_event_id`) { df_monitor_checker_event_ref = exists() } by `df_monitor_checker_event_ref` having df_fault_status = 'fault' sorder by create_time desc",
                "timeRange": [
                    1724320359294,
                    1724323959294
                ],
                "align_time": True,
                // 指定本次查询禁止采样
                "disable_sampling": True,
                // 指定获取几个分组，也就是 100个未恢复事件
                "slimit": 100,
                "tz": "Asia/Shanghai"
            },
        }
    ]
}


```

### 方式二：非having方式查询（非 doris 引擎）需要过滤筛选

1、查询结构

```
{
    "queries": [
        {
            "qtype": "dql",
            "query": {
                "disableMultipleField": False,
                "q": "E::`monitor`:(`__docid`, `df_title`,`df_monitor_checker_event_ref`, `df_fault_id`, `df_status`, `df_fault_status`,`df_fault_start_time`, `df_event_id`, `create_time`) { df_monitor_checker_event_ref = exists() } by `df_monitor_checker_event_ref` sorder by create_time desc",
                "timeRange": [
                    1724320359294,
                    1724323959294
                ],
                "align_time": True,
                # 指定本次查询禁止采样
                "disable_sampling": True,
                # 指定获取 1000 个触发对象
                "slimit": 1000,
                "tz": "Asia/Shanghai"
            },
        }
    ]
}
```


2、对 dql 查询结果进行过滤
  对查询结果中的 df_fault_status 状态进行过滤，过滤出 df_fault_status=fault 的事件。此时这些数据就是未恢复事件列表

3、根据 time 字段对数据进行降序排列 得出最终的未恢复事件列表


# 如何确认当前工作空间 事件 的存储引擎类型

1、通过接口获取工作空间存储信息
- [OpenAPI  「获取当前工作空间信息」](../open-api/workspace/current/)
- [ExternalAPI 「【工作空间】获取详情」](../external-api/workspace/get/)
接口响应结果中 `datastore` 存储了当前工作空间内所有基础数据的存储引擎类型（不包括外部索引）。 `datastore` 中 `keyevent` 的值为 `doris` 就表明事件数据是 `doris` 存储引擎。
```


接口返回结果如下
{
    "code": 200,
    "content": {
        "id": 1,
        "uuid": "wksp_xxxxx",
        "name": "【Doris】工作空间名",
        "versionType": "pay",
        // ......
        "datastore": {
            "backup_log": "doris",
            "custom_object": "doris",
            "keyevent": "doris", // 判断此处 keyevent 对应的值，如果为 doris, 则表明是 doris 类型存储引擎
            "logging": "doris",
            "metric": "guancedb",
            "network": "doris",
            "object": "doris",
            "object_history": "doris",
            "profiling": "doris",
            "rum": "doris",
            "security": "doris",
            "tracing": "doris"
        },
        // ......
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "2956247345653191101"
}

```
