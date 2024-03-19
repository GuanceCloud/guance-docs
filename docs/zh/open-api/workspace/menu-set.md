# 功能菜单设置

---

<br />**POST /api/v1/workspace/menu/set**

## 概述
设置当前工作空间功能菜单




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| menu | array | Y | 配置的菜单栏列表<br>允许为空: False <br> |
| menu[*] | json | Y | 菜单选项<br>允许为空: False <br> |
| menu[*].key | string | Y | 菜单<br>例子: CloudDial <br>允许为空: False <br>可选值: ['Scene', 'Events', 'ExceptionsTracking', 'Objectadmin', 'MetricQuery', 'LogIndi', 'Tracing', 'Rum', 'CloudDial', 'Security', 'GitLabCI', 'Monitor', 'Integration', 'Workspace', 'Billing'] <br> |
| menu[*].value | int | Y | 菜单项是否开启：1 开启，0 不开启<br>例子: 1 <br>允许为空: False <br>可选值: [0, 1] <br> |

## 参数补充说明


**参数说明**

| 参数名 | type    | 必选 | 说明                     |
| :------ | :------- | :---- | :------------------------ |
| menu   | array[json]   | Y    | 菜单栏列表               |
| key    | string  | Y    | 菜单项                |
| value  | int     | Y    | 是否开启：0不开启，1开启 |


**菜单项说明**

| key                | 说明           |
| :------------------ | :-------------- |
| Scene              | 场景           |
| Events             | 事件           |
| ExceptionsTracking | 异常追踪       |
| Objectadmin        | 基础设施       |
| MetricQuery        | 指标           |
| LogIndi            | 日志           |
| Tracing            | 应用性能监测   |
| Rum                | 用户访问监测   |
| CloudDial          | 可用性监测     |
| Security           | 安全巡检       |
| GitLabCI           | CI 可视化      |
| Monitor            | 监控           |
| Integration        | 集成           |
| Workspace          | 管理           |
| Billing            | 付费计划与账单 |

注意：设置菜单项，最好全量修改，确定每个菜单的开启/关闭




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/menu/set' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \

--data-raw '{"menu":[{"key":"Scene","value":1},{"key":"Events","value":1},{"key":"ExceptionsTracking","value":1},{"key":"Objectadmin","value":1},{"key":"MetricQuery","value":1},{"key":"LogIndi","value":1},{"key":"Tracing","value":1},{"key":"Rum","value":1},{"key":"CloudDial","value":1},{"key":"Security","value":1},{"key":"GitLabCI","value":1},{"key":"Monitor","value":1},{"key":"Integration","value":1},{"key":"Workspace","value":1},{"key":"Billing","value":1}]}' \
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "config": [
            {
                "key": "Scene",
                "value": 1
            },
            {
                "key": "Events",
                "value": 1
            },
            {
                "key": "ExceptionsTracking",
                "value": 1
            },
            {
                "key": "Objectadmin",
                "value": 1
            },
            {
                "key": "MetricQuery",
                "value": 1
            },
            {
                "key": "LogIndi",
                "value": 1
            },
            {
                "key": "Tracing",
                "value": 1
            },
            {
                "key": "Rum",
                "value": 1
            },
            {
                "key": "CloudDial",
                "value": 1
            },
            {
                "key": "Security",
                "value": 1
            },
            {
                "key": "GitLabCI",
                "value": 1
            },
            {
                "key": "Monitor",
                "value": 1
            },
            {
                "key": "Integration",
                "value": 1
            },
            {
                "key": "Workspace",
                "value": 1
            },
            {
                "key": "Billing",
                "value": 1
            }
        ],
        "createAt": 1697627382,
        "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "deleteAt": -1,
        "id": 763,
        "keyCode": "WsMenuCfg",
        "status": 0,
        "updateAt": 1697627382,
        "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "uuid": "ctcf_98daec54e21e42549be04fe4807574a3",
        "workspaceUUID": "wksp_4b57c7baxxxxxxxxxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "475074598825122309"
} 
```




