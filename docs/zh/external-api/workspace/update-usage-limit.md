# 【工作空间】使用量限制更新

---

<br />**POST /api/v1/workspace/\{workspace_uuid\}/usage_limit/update**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| workspace_uuid | string | Y | 工作空间UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| config | json | Y | 各个类型的使用量配置, metric "指标", network "网络", rum "用户访问", logging "日志", tracing "应用性能Trace", profile "应用性能Profile", dialing "可用性拨测"<br>例子: {rum: {openLimit: false, value: 0},logging: {openLimit: false, value: 0} <br>允许为空: False <br> |

## 参数补充说明

**请求主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|config         |json |  空间具体类型的日使用量限制 |

config 结构示例:

```json
      {
          "rum": {"openLimit": false, "value": 0},
          "logging": {"openLimit": false, "value": 0},
          "tracing": {"openLimit": true, "value": 10000},
          "metric": {"openLimit": false, "value": 0},
          "network": {"openLimit": false, "value": 0},
          "profile": {"openLimit": false, "value": 0},
          "dialing": {"openLimit": false, "value": 0},
      }
```






## 响应
```shell
 
```




