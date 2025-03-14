## 1 Query Metrics Reports "query error: tenant: ; requestURI: /select/3/guance/api/v1/query; auth error: cannot parse accountID from "": strconv.ParseUint: parsing "": invalid syntax"

When querying metrics, an error occurs.

![](img/query-metrics-error-1.png)

Connect to the database via MySQL in the launcher pod and execute the following SQL:
```sql
use df_core;
update main_influx_instance set configJSON='{"write": {"host": "http://guancedb-cluster-guance-insert.middleware:8480"}, "read": {"host": "http://guancedb-cluster-guance-select.middleware:8481"}}' where id=1;
```

Restart all kodo services:
```shell
kubectl delete pod -n forethought-kodo
```

## 2 Kodo Error in Metrics Management `query error: db config pwd is null:ro`

There is a data gap in metrics management. Through F12 inspection, the kodo API response returns 'query error: db config pwd is null:ro'.

Solution:
Check the storage engine instance using the following SQL. If it has switched to Doris, **note that the datastore field should have the metric value as guancedb**.
```sql
select * from main_es_instance;
```
If the value of this field is not guancedb, modify it to guancedb via SQL.

## 3 Query Metrics Error

### Problem Description:
Metrics query reports `query error: the query is too broad or the time range is too long, resulting in too many rows`.

### Solution:

Add or modify the startup parameter `-search.maxQueryUniqueTimeseries` for the GuanceDB for metrics select component:

```
--search.maxQueryUniqueTimeseries=3000000
```