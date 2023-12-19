# 修改一个告警策略

---

<br />**POST /api/v1/monitor/group/\{monitor_uuid\}/modify**

## 概述
根据`monitor_uuid`修改指定的告警策略配置信息




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| monitor_uuid | string | Y | 告警策略UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 监控器名字<br>允许为空: False <br> |
| alertOpt | json |  | 告警设置<br>允许为空: False <br> |
| alertOpt.silentTimeout | integer |  | 告警设置<br>允许为空: False <br> |
| alertOpt.alertTarget | array |  | 触发动作<br>允许为空: False <br> |
| alertOpt.aggInterval | integer | Y | 告警聚合间隔，单位秒, 0代表不聚合<br>允许为空: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields | array |  | 聚合字段列表，保持空列表[]表示「聚合规则：全部」,  df_monitor_checker_id：监控器/智能巡检/SLO,   df_dimension_tags：检测维度,   df_label：标签,  CLUSTER：智能聚合<br>例子: ['CLUSTER'] <br>允许为空: False <br> |
| alertOpt.aggLabels | array |  | 按标签聚合时的标签值列表，需要在aggFields中指定有df_label才会生效<br>允许为空: False <br> |
| alertOpt.aggClusterFields | array |  | 智能聚合时的字段列表，需要在aggFields中指定有CLUSTER才会生效, 可选值 "df_title"：标题, "df_message"：内容<br>例子: ['df_title'] <br>允许为空: False <br> |

## 参数补充说明







## 响应
```shell
{
    "code": 200,
    "content": {
        "alertOpt": {
            "alertTarget": [],
            "silentTimeout": 0
        },
        "config": {},
        "createAt": 1641870634,
        "creator": "acnt_63c77346766c11ebb7caf2b2c21faf74",
        "deleteAt": -1,
        "id": 769,
        "name": "修改后的名称",
        "status": 0,
        "type": "aliyun_rds_mysql",
        "updateAt": 1642593872.2646232,
        "updator": "wsak_0f70ae95544143549f6ac2cb56ee0037",
        "uuid": "monitor_84cbb7c18f964771b8153fbca1013615",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-DAEC1D96-1053-4CBC-8997-398635FE1884"
} 
```




