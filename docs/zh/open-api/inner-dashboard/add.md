# 新建单个用户视图

---

<br />**POST /api/v1/dashboard/add**

## 概述
新建单个用户视图




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sourceDashboardUUID | string |  | 源视图ID<br>允许为空: False <br>允许空字符串: True <br>最大长度: 128 <br> |
| name | string | Y | 视图名称<br>允许为空: False <br>最大长度: 256 <br> |
| templateInfos | json |  | 自定义模板数据<br>例子: {} <br>允许为空: False <br>允许空字符串: False <br> |
| dashboardBidding | json |  | mapping, 默认为{}<br>例子: {} <br>允许为空: False <br> |

## 参数补充说明

**请求主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|name         |list |  视图名称 |
|dashboardBidding         |dict |   仪表板绑定的信息|
|sourceDashboardUUID         |string |  克隆 仪表板 或者 内置用户视图 的UUID|
|templateInfos         |dict |  克隆 内置系统视图 的模板信息 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
--data-raw $'{"name":"test_阿里云 Redis 监控视图","templateInfos":{"dashboardBindSet":[],"dashboardExtend":{},"dashboardMapping":[],"dashboardOwnerType":"node","dashboardType":"CUSTOM","icon":"icon.svg","iconSet":{"icon":"http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/aliyun_redis/icon.svg","url":"http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/aliyun_redis/aliyun_redis.png"},"main":{"charts":[{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"CPU 使用率","name":"CPU 使用率","unit":"","units":["percent","percent"]},{"key":"网络出带宽","name":"网络出带宽","unit":"","units":["bandWidth","bps"]}],"xAxisShowType":"time"}},"group":{"name":"CPU / 内存"},"name":"CPU 使用率","pos":{"h":8,"i":"chrt_a6f8e55f3cfb4dc2bbdcc38581a05eab","w":8,"x":0,"y":2},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"CPU 使用率","code":"A","dataSource":"aliyun_acs_kvstore","field":"CpuUsage_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"6f020640-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"72990fb0-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`CpuUsage_Average`) AS `CPU 使用率`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[{"color":"#C8DD4F","key":"连接数使用率","name":"连接数使用率"}],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"连接数使用率","name":"连接数使用率","unit":"","units":["percent","percent"]}],"xAxisShowType":"time"}},"group":{"name":"网络流量"},"name":"连接数使用率","pos":{"h":8,"i":"chrt_816ca46b56384fcc8515e090b3b8abfb","w":6,"x":0,"y":12.5},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"连接数使用率","code":"A","dataSource":"aliyun_acs_kvstore","field":"ConnectionUsage_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"ba953ed0-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"932b12f0-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`ConnectionUsage_Average`) AS `连接数使用率`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[{"color":"#FF77AA","key":"QPS 使用率","name":"QPS 使用率"}],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"QPS 使用率","name":"QPS 使用率","unit":"","units":["percent","percent"]}],"xAxisShowType":"time"}},"group":{"name":"性能指标"},"name":"QPS 使用率","pos":{"h":8,"i":"chrt_eacb38b490404c23814b154f1ab4e031","w":8,"x":0,"y":23},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"QPS 使用率","code":"A","dataSource":"aliyun_acs_kvstore","field":"StandardQPSUsage_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"c4ef3d40-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"c9a944f0-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardQPSUsage_Average`) AS `QPS 使用率`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"流入带宽使用率","name":"流入带宽使用率","unit":"","units":["percent","percent"]},{"key":"流出带宽使用率","name":"流出带宽使用率","unit":"","units":["percent","percent"]}],"xAxisShowType":"time"}},"group":{"name":"网络流量"},"name":"流量带宽使用率","pos":{"h":8,"i":"chrt_db849e7b76854cfdbeeabe1153fdc769","w":6,"x":18,"y":12.5},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"流入带宽使用率","code":"A","dataSource":"aliyun_acs_kvstore","field":"StandardIntranetInRatio_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"ce1e2930-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"b8acaac0-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardIntranetInRatio_Average`) AS `流入带宽使用率`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""},{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"流出带宽使用率","code":"B","dataSource":"aliyun_acs_kvstore","field":"StandardIntranetOutRatio_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"ce1e2930-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"be873b90-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardIntranetOutRatio_Average`) AS `流出带宽使用率`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[{"color":"#41CEC7","key":"内存使用率","name":"内存使用率"}],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"内存使用率","name":"内存使用率","unit":"","units":["percent","percent"]}],"xAxisShowType":"time"}},"group":{"name":"CPU / 内存"},"name":"内存使用率","pos":{"h":8,"i":"chrt_b5bef611199a47a3b0956375b8f138c6","w":8,"x":8,"y":2},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"内存使用率","code":"A","dataSource":"aliyun_acs_kvstore","field":"MemoryUsage_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"ba953ed0-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"7f3f9630-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`MemoryUsage_Average`) AS `内存使用率`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[{"color":"#C57ECD","key":"命中率","name":"命中率"}],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"命中率","name":"命中率","unit":"","units":["percent","percent"]}],"xAxisShowType":"time"}},"group":{"name":"性能指标"},"name":"命中率","pos":{"h":8,"i":"chrt_e24cf24645a94711aaf6cb6ae75fa78b","w":8,"x":8,"y":23},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"命中率","code":"A","dataSource":"aliyun_acs_kvstore","field":"StandardHitRate_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"c4ef3d40-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"d27db4d0-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardHitRate_Average`) AS `命中率`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"平均响应时间","name":"平均响应时间","unit":"","units":["time","μs"]},{"key":"最大响应时间","name":"最大响应时间","unit":"","units":["time","μs"]}],"xAxisShowType":"time"}},"group":{"name":"性能指标"},"name":"响应时间","pos":{"h":8,"i":"chrt_02ca9c11c7d144909f34623c0decc0f2","w":8,"x":0,"y":31},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"平均响应时间","code":"A","dataSource":"aliyun_acs_kvstore","field":"StandardAvgRt_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"aaa580c0-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"e8704c30-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardAvgRt_Average`) AS `平均响应时间`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""},{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"最大响应时间","code":"B","dataSource":"aliyun_acs_kvstore","field":"StandardMaxRt_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"aaa580c0-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"ef4569a0-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardMaxRt_Average`) AS `最大响应时间`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"每秒命令失败次数","name":"每秒命令失败次数","unit":"次","units":["custom","次"]}],"xAxisShowType":"time"}},"group":{"name":"性能指标"},"name":"每秒命令失败次数","pos":{"h":8,"i":"chrt_c83aeefe8d074a1881062fe54288883c","w":8,"x":16,"y":23},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"每秒命令失败次数","code":"A","dataSource":"aliyun_acs_kvstore","field":"StandardFailedCount_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"aaa580c0-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"ddddd8a0-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardFailedCount_Average`) AS `每秒命令失败次数`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"入流量","name":"入流量","unit":"","units":["bandWidth","bps"]},{"key":"出流量","name":"出流量","unit":"","units":["bandWidth","bps"]}],"xAxisShowType":"time"}},"group":{"name":"网络流量"},"name":"网络流量","pos":{"h":8,"i":"chrt_500d78453cf14573b14ed70251dd4da2","w":6,"x":12,"y":12.5},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"入流量","code":"A","dataSource":"aliyun_acs_kvstore","field":"StandardIntranetIn_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"aaa580c0-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"a87d2490-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardIntranetIn_Average`) AS `入流量`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""},{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"出流量","code":"B","dataSource":"aliyun_acs_kvstore","field":"StandardIntranetOut_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"aaa580c0-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"aebcb8c0-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardIntranetOut_Average`) AS `出流量`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[{"color":"#00B2CE","key":"缓存内Key数量","name":"缓存内Key数量"}],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"缓存内Key数量","name":"缓存内Key数量","unit":"个","units":["custom","个"]}],"xAxisShowType":"time"}},"group":{"name":"性能指标"},"name":"缓存内Key数量","pos":{"h":8,"i":"chrt_5608460e97d5475d8f30c4341a2b4334","w":8,"x":16,"y":31},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"缓存内Key数量","code":"A","dataSource":"aliyun_acs_kvstore","field":"StandardKeys_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"aaa580c0-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"070e95c0-e6dd-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardKeys_Average`) AS `缓存内Key数量`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[{"color":"#A0DD86","key":"已用连接数","name":"已用连接数"}],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"已用连接数","name":"已用连接数","unit":"个","units":["custom","个"]}],"xAxisShowType":"time"}},"group":{"name":"网络流量"},"name":"已用连接数","pos":{"h":8,"i":"chrt_1e1dfc92bd5a47eda4f1fee21bbc1823","w":6,"x":6,"y":12.5},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"已用连接数","code":"A","dataSource":"aliyun_acs_kvstore","field":"StandardUsedConnection_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"aaa580c0-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"9cca73f0-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardUsedConnection_Average`) AS `已用连接数`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[{"color":"#3AB8FF","key":"内存使用量","name":"内存使用量"}],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"内存使用量","name":"内存使用量","unit":"","units":["digital","B"]}],"xAxisShowType":"time"}},"group":{"name":"CPU / 内存"},"name":"内存使用量","pos":{"h":8,"i":"chrt_8b047120b2f44c0bba86a9268d51b65e","w":8,"x":16,"y":2},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"内存使用量","code":"A","dataSource":"aliyun_acs_kvstore","field":"StandardUsedMemory_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"aaa580c0-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"894f6c40-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardUsedMemory_Average`) AS `内存使用量`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"},{"extend":{"fixedTime":"","settings":{"chartType":"areaLine","colors":[{"color":"#FFBD5F","key":"平均每秒访问次数","name":"平均每秒访问次数"}],"compareTitle":"","compareType":"","currentChartType":"sequence","density":"medium","fixedTime":"","isPercent":false,"isTimeInterval":true,"levels":[],"openCompare":false,"openStack":false,"showFieldMapping":false,"showLine":false,"showTitle":true,"stackType":"time","timeInterval":"default","titleDesc":"","units":[{"key":"平均每秒访问次数","name":"平均每秒访问次数","unit":"次","units":["custom","次"]}],"xAxisShowType":"time"}},"group":{"name":"性能指标"},"name":"平均每秒访问次数","pos":{"h":8,"i":"chrt_1fbf1f6e0e51495dbab1b9f69d04995c","w":8,"x":8,"y":31},"queries":[{"color":"","datasource":"dataflux","name":"","qtype":"dql","query":{"alias":"平均每秒访问次数","code":"A","dataSource":"aliyun_acs_kvstore","field":"StandardUsedQPS_Average","fieldFunc":"avg","fieldType":"float","fill":null,"filters":[{"id":"aaa580c0-5c8d-11ec-967d-cd56a11cd59b","logic":"and","name":"account_name","op":"=","type":"","value":"#{account_name}"},{"id":"fdabc890-e6dc-11ec-a44d-8558437e3e2c","logic":"and","name":"InstanceName","op":"=","type":"","value":"#{InstanceName}"}],"funcList":[],"groupBy":[],"groupByTime":"","namespace":"metric","q":"M::`aliyun_acs_kvstore`:(AVG(`StandardUsedQPS_Average`) AS `平均每秒访问次数`) { `account_name` = \'#{account_name}\' and `InstanceName` = \'#{InstanceName}\' }","queryFuncs":[],"type":"simple"},"type":"sequence","unit":""}],"type":"sequence"}],"groups":["CPU / 内存","网络流量","性能指标"],"type":"template","vars":[{"code":"account_name","datasource":"dataflux","definition":{"defaultVal":{"label":"*","value":"re(`.*`)"},"field":"","metric":"","object":"","tag":"","value":"show_tag_value(from=[\'aliyun_acs_kvstore\'], keyin=[\'account_name\'])[5m]"},"hide":0,"isHiddenAsterisk":0,"name":"账号名称","seq":0,"type":"QUERY","valueSort":"default"},{"code":"InstanceName","datasource":"dataflux","definition":{"defaultVal":{"label":"*","value":"re(`.*`)"},"field":"","metric":"","object":"","tag":"","value":"show_tag_value(from=[\'aliyun_acs_kvstore\'], keyin=[\'InstanceName\']){account_name=\'#{account_name}\'}[5m]"},"hide":0,"isHiddenAsterisk":0,"name":"实例名称","seq":1,"type":"QUERY","valueSort":"default"}]},"summary":"","tagInfo":[{"id":"tag_b768629fdebc4b259f56a802376bc9eb","name":"Function"},{"id":"tag_0b69bf4cbf7b4adb8cc4450244673748","name":"阿里云监控"}],"tags":["IT 运维"],"thumbnail":"aliyun_redis.png","title":"阿里云 Redis 监控视图","url":null}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [
            "chtg_604d4d14191c405a968a7c939d6b5571",
            "chtg_3c5c604f8968431e8746e1c5762ae1fc",
            "chtg_c488448f830a441a96f424f429402e21"
        ],
        "chartPos": [
            {
                "chartUUID": "chrt_9c2790887e1a44b0832ed8d71db9c60b",
                "pos": {
                    "h": 8,
                    "i": "chrt_a6f8e55f3cfb4dc2bbdcc38581a05eab",
                    "w": 8,
                    "x": 0,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_f6278e8f5fca4a26976ae00a6eb5277b",
                "pos": {
                    "h": 8,
                    "i": "chrt_816ca46b56384fcc8515e090b3b8abfb",
                    "w": 6,
                    "x": 0,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_a033b14d9de645f6bc2e99ecb27c0874",
                "pos": {
                    "h": 8,
                    "i": "chrt_eacb38b490404c23814b154f1ab4e031",
                    "w": 8,
                    "x": 0,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_2763b9633e254263b9a8fa528e62397e",
                "pos": {
                    "h": 8,
                    "i": "chrt_db849e7b76854cfdbeeabe1153fdc769",
                    "w": 6,
                    "x": 18,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_d4cf5b8bc9d64d218735e064d71e2c2e",
                "pos": {
                    "h": 8,
                    "i": "chrt_b5bef611199a47a3b0956375b8f138c6",
                    "w": 8,
                    "x": 8,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_69c5b03dadb74cef98cd267d14c1f014",
                "pos": {
                    "h": 8,
                    "i": "chrt_e24cf24645a94711aaf6cb6ae75fa78b",
                    "w": 8,
                    "x": 8,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_c825f5133bbb4fadbfa4a38a5138031b",
                "pos": {
                    "h": 8,
                    "i": "chrt_02ca9c11c7d144909f34623c0decc0f2",
                    "w": 8,
                    "x": 0,
                    "y": 31
                }
            },
            {
                "chartUUID": "chrt_450f5a9f797f4392ab634a59a8f50e57",
                "pos": {
                    "h": 8,
                    "i": "chrt_c83aeefe8d074a1881062fe54288883c",
                    "w": 8,
                    "x": 16,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_2502ecaf8dd0429db806863a2e64c71e",
                "pos": {
                    "h": 8,
                    "i": "chrt_500d78453cf14573b14ed70251dd4da2",
                    "w": 6,
                    "x": 12,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_b5f2e4e572af4ba6bc968e20c0ed78d5",
                "pos": {
                    "h": 8,
                    "i": "chrt_5608460e97d5475d8f30c4341a2b4334",
                    "w": 8,
                    "x": 16,
                    "y": 31
                }
            },
            {
                "chartUUID": "chrt_40dbab36ff5c42c6925164c4f4744846",
                "pos": {
                    "h": 8,
                    "i": "chrt_1e1dfc92bd5a47eda4f1fee21bbc1823",
                    "w": 6,
                    "x": 6,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_3332e1dff57440f1835cbf39b3045c72",
                "pos": {
                    "h": 8,
                    "i": "chrt_8b047120b2f44c0bba86a9268d51b65e",
                    "w": 8,
                    "x": 16,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_b77e35cc911e426d8ee205da075eb5bc",
                "pos": {
                    "h": 8,
                    "i": "chrt_1fbf1f6e0e51495dbab1b9f69d04995c",
                    "w": 8,
                    "x": 8,
                    "y": 31
                }
            }
        ],
        "createAt": 1698732345,
        "createdWay": "manual",
        "creator": "wsak_xxxxx",
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {
            "icon": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/aliyun_redis/icon.svg",
            "url": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/aliyun_redis/aliyun_redis.png"
        },
        "id": 4615,
        "isPublic": 1,
        "mapping": [],
        "name": "test_阿里云 Redis 监控视图",
        "ownerType": "inner",
        "status": 0,
        "type": "CUSTOM",
        "updateAt": 1698732345,
        "updator": "wsak_xxxxx",
        "uuid": "dsbd_c66d57c9f10149378b1fd36977145713",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6D5CD765-D14C-462C-BDC2-885F1A714A64"
} 
```




