
## 1 查询指标报"query error: tenant: ; requestURI: /select/3/guance/api/v1/query; auth error: cannot parse accountID from "": strconv.ParseUint: parsing "": invalid syntax"
查询指标时报错
![](img/query-metrics-error-1.png)
在launcher pod中通过mysql连接到数据库，执行下列sql
```sql
use df_core;
update main_influx_instance set configJSON='{"write": {"host": "http://guancedb-cluster-guance-insert.middleware:8480"}, "read": {"host": "http://guancedb-cluster-guance-select.middleware:8481"}}' where id=1;
```
重启 kodo 所有服务
```shell
kubectl delete pod -n forethought-kodo
```

## 2 指标管理里 kodo报错 query error: db config pwd is null:ro
指标管理里无数据，通过f12查看到kodo接口Response返回'query error: db config pwd is null:ro'
解决方案：
通过下列sql检查存储引擎实例，如果是切换后了doris，**注意datastore字段中，metric值应该为guancedb**。
```sql
select * from main_es_instance;
```
如果该字段的值不是guancedb，请通过sql修改为guancedb。
