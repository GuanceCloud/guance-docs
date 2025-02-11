## 1 Query Metrics Reports "query error: tenant: ; requestURI: /select/3/guance/api/v1/query; auth error: cannot parse accountID from "": strconv.ParseUint: parsing "": invalid syntax"

When querying metrics, an error occurs:
![](img/query-metrics-error-1.png)

In the launcher pod, connect to the database via MySQL and execute the following SQL:
```sql
use df_core;
update main_influx_instance set configJSON='{"write": {"host": "http://guancedb-cluster-guance-insert.middleware:8480"}, "read": {"host": "http://guancedb-cluster-guance-select.middleware:8481"}}' where id=1;
```
Restart all kodo services:
```shell
kubectl delete pod -n forethought-kodo
```

## 2 Kodo Error in Metrics Management: query error: db config pwd is null:ro

There is a data interruption in Metrics Management, and through F12 inspection, the kodo API Response returns 'query error: db config pwd is null:ro'.
Solution:
Check the storage engine instance using the following SQL. If it has switched to Doris, **note that the datastore field should have the metric value as guancedb**.
```sql
select * from main_es_instance;
```
If the value of this field is not guancedb, modify it to guancedb using SQL.