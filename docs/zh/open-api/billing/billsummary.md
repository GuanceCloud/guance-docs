# 获取空间账单各个计费项消费累计

---

<br />**GET /api/v1/billing/project/summary**

## 概述




## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/billing/project/summary' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed
```




## 响应
```shell
{
    "会话重放": 806.8,
    "扩展应用": 1500.0,
    "累计消费": 17211.88,
    "任务调用": 73.4,
    "服务费": 0,
    "用户访问监测PV数量": 8.81,
    "应用性能Profile": 14747.72,
    "网络(主机)": 34.0,
    "跨区私网流量费": 0,
    "时间线": 17.81,
    "应用性能Trace": 0.1,
    "日志类数据": 2.86,
    "短信": 18.7,
    "可用性监测API拨测": 0,
    "备份日志数据": 0.0,
    "可用性监测API拨测次数": 1.68
} 
```




