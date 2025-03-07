# 【指标集】指标和标签信息获取

---

<br />**GET /api/v1/metric_info/get**

## 概述
获取 指标 对应的指标集和标签信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| metric | string | Y | 指标集名<br>例子: cpu <br>允许为空: False <br>允许为空字符串: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/metric_info/get?metric=kube_replicaset' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{"code":200,"content":{"declaration":{"asd":"aa,bb,cc,1,True","asdasd":"dawdawd","business":"aaa","dd":"dd","fawf":"afawf","organization":"64fe7b4062f74d0007b46676"},"metric_fields_info":[{"data_type":"int","desc":"The number of fully labeled replicas per ReplicaSet.","field":"fully_labeled_replicas","type":"inner","unit":"count"},{"data_type":"int","desc":"The most recently observed number of replicas.","field":"replicas","type":"inner","unit":"custom/[\\"angle\\",\\"rad\\"]"},{"data_type":"int","desc":"The number of available replicas (ready for at least minReadySeconds) for this replica set.","field":"replicas_available","type":"inner","unit":"count"},{"data_type":"int","desc":"The number of desired replicas.","field":"replicas_desired","type":"inner","unit":"count"},{"data_type":"int","desc":"The number of ready replicas for this replica set.","field":"replicas_ready","type":"inner","unit":"count"}],"tags_info":[{"tag_desc":"Namespace defines the space within each name must be unique.","tag_key":"namespace"},{"tag_desc":"K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.","tag_key":"cluster_name_k8s"},{"tag_desc":"","tag_key":"replica_set"},{"tag_desc":"","tag_key":"guance_site"},{"tag_desc":"The UID of ReplicaSet.","tag_key":"uid"},{"tag_desc":"Name must be unique within a namespace.","tag_key":"replicaset"}]},"errorCode":"","message":"","success":true,"traceId":"TRACE-B865D1FC-CB17-4676-B72C-AC3E5FE55334"} 
```




